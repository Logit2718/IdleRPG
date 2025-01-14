"""
The IdleRPG Discord Bot
Copyright (C) 2018-2021 Diniboy and Gelbpunkt
This program is free software: you can redistribute it and/or modify

it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
"""
import asyncio
import html

from collections import defaultdict
from datetime import timedelta

import discord
import wavelink

from discord.ext import commands

from classes.converters import IntFromTo
from cogs.help import chunks
from utils.i18n import _, locale_doc


class VoteDidNotPass(commands.CheckFailure):
    pass


class NeedsToBeInVoiceChat(commands.CheckFailure):
    pass


class NeedsToBePlaying(commands.CheckFailure):
    pass


class PlayerLocked(commands.CheckFailure):
    pass


class NotDJ(commands.CheckFailure):
    pass


class Artist:
    def __init__(self, raw_data):
        self.id = raw_data["id"]
        self.name = raw_data["name"]


class Album:
    def __init__(self, raw_data):
        self.id = raw_data["id"]
        self.title = raw_data["title"]
        self.cover = raw_data["cover"]


class Track:
    def __init__(self, raw_data):
        self.id = raw_data["id"]
        self.title = raw_data["title"]
        self.duration = raw_data["duration"]
        self.explicit = raw_data["explicit_lyrics"]
        self.artist = Artist(raw_data["artist"])
        self.album = Album(raw_data["album"])


def is_in_vc():
    def predicate(ctx):
        try:
            ctx.voice_channel = ctx.author.voice.channel.id
        except AttributeError:
            raise NeedsToBeInVoiceChat()
        return True

    return commands.check(predicate)


def is_playing():
    def predicate(ctx):
        try:
            ctx.voice_channel = ctx.author.voice.channel.id
        except AttributeError:
            raise NeedsToBeInVoiceChat()
        if not ctx.guild.me.voice:
            raise NeedsToBePlaying()
        return True

    return commands.check(predicate)


def get_player():
    def predicate(ctx):
        ctx.player = ctx.bot.wavelink.get_player(ctx.guild.id)
        return True

    return commands.check(predicate)


def is_not_locked():
    def predicate(ctx):
        if (
            getattr(ctx.player, "locked", False) is True
            and not getattr(ctx.player, "dj", None) == ctx.author
        ):
            raise PlayerLocked()
        return True

    return commands.check(predicate)


def is_dj():
    def predicate(ctx):
        if not getattr(ctx.player, "dj", None) == ctx.author:
            raise NotDJ()
        return True

    return commands.check(predicate)


def vote(action):
    async def predicate(ctx):
        if ctx.author == ctx.player.dj:
            return True
        if action == "skip":
            text = _(
                "{user} wants to skip a track. React if you agree."
                " **{current}/{total}** voted for it!"
            )
        elif action == "pause_resume":
            text = _(
                "{user} wants to pause/resume the player. React if you agree."
                " **{current}/{total}** voted for it!"
            )
        elif action == "stop":
            text = _(
                "{user} wants to stop playback. React if you agree."
                " **{current}/{total}** voted for it!"
            )
        elif action == "volume":
            text = _(
                "{user} wants to change the volume. React if you agree."
                " **{current}/{total}** voted for it!"
            )
        elif action == "loop":
            text = _(
                "{user} wants to toggle repeating. React if you agree."
                " **{current}/{total}** voted for it!"
            )
        elif action == "equalizer":
            text = _(
                "{user} wants to change the equalizer. React if you agree."
                " **{current}/{total}** voted for it!"
            )
        members = [
            m
            for m in ctx.bot.get_channel(int(ctx.player.channel_id)).voice_states
            if m != ctx.guild.me.id
        ]
        accepted = {ctx.author.id}
        needed = len(members) // 2 + 1

        msg = await ctx.send(
            text.format(user=ctx.author.mention, current=len(accepted), total=needed)
        )

        def check(r, u):
            return (
                u.id in members
                and u.id not in accepted
                and str(r.emoji) == "\U00002705"
                and r.message.id == msg.id
            )

        await msg.add_reaction("\U00002705")

        while len(accepted) < needed:
            try:
                r, u = await ctx.bot.wait_for("reaction_add", check=check, timeout=10)
            except asyncio.TimeoutError:
                raise VoteDidNotPass()
            accepted.add(u)
            await msg.edit(
                content=text.format(
                    user=ctx.author.mention, current=len(accepted), total=needed
                )
            )

        await msg.delete()
        await ctx.send(_("Vote passed!"))
        return True

    return commands.check(predicate)


class FakeTrack(wavelink.Track):
    __slots__ = (
        "id",
        "info",
        "query",
        "title",
        "ytid",
        "length",
        "duration",
        "uri",
        "is_stream",
        "dead",
        "thumb",
        "requester",
        "channel_id",
        "track_obj",
    )

    def __init__(self, *args, **kwargs):
        self.requester = kwargs.pop("requester", None)
        self.channel_id = kwargs.pop("channel_id", None)
        self.id = kwargs.pop("id", None)
        self.track_obj = kwargs.pop("track_obj", None)
        super().__init__(*args, **kwargs)
        self.title = self.track_obj.title


class Music(commands.Cog):
    def __init__(self, bot):
        self.bot = bot
        self.queue = defaultdict(lambda: [])  # Redis is not needed because why

        if (
            self.bot.config.music.query_endpoint is None
            or self.bot.config.music.resolve_endpoint is None
        ):
            bot.logger.warning("music endpoints not set, unloading music cog...")
            bot.unload_extension("cogs.music")

        if not hasattr(self.bot, "wavelink"):
            self.bot.wavelink = wavelink.Client(bot=self.bot)

        self.bot.loop.create_task(self.connect())

    async def connect(self):
        for conf in self.bot.config.music.nodes:
            if conf["identifier"] not in self.bot.wavelink.nodes:
                node = await self.bot.wavelink.initiate_node(**conf)
                node.set_hook(self.event_hook)
        await asyncio.sleep(5)
        if not self.bot.wavelink.nodes:
            self.bot.logger.warning(
                "FAILED to connect to lavalink backend, unloading music cog..."
            )
            self.bot.unload_extension("cogs.music")

    @is_not_locked()
    @get_player()
    @is_in_vc()
    @commands.command(aliases=["cp"], brief=_("Choose a result to play"))
    @locale_doc
    async def chooseplay(self, ctx, *, query: str):
        _(
            """`<query>` - The query to search a song by

            Query for a track and play or add any result to the playlist, you can choose from a multitude of tracks."""
        )
        async with self.bot.trusted_session.get(
            self.bot.config.music.query_endpoint,
            params={"limit": 5, "q": query},
        ) as r:
            results = await r.json()
        if not results:
            return await ctx.send(_("No results..."))
        track_objs = [Track(i) for i in results]
        if len(track_objs) > 1:
            track_idx = await self.bot.paginator.Choose(
                title=_("Song results"),
                placeholder=_("Select a song to play"),
                return_index=True,
                entries=[
                    f"**{i.title}** by {i.artist.name} on"
                    f" {i.album.title}"
                    f" ({timedelta(seconds=i.duration)})"
                    for i in track_objs
                ],
                choices=[i.title for i in track_objs],
            ).paginate(ctx)
            track_obj = track_objs[track_idx]
        else:
            track_obj = track_objs[0]
            if not await ctx.confirm(
                f"The only result was **{track_obj.title}** by"
                f" {track_obj.artist.name} on"
                f" {track_obj.album.title}. Play it?"
            ):
                return

        msg = await ctx.send(_("Loading track... This might take up to 3 seconds..."))
        tracks = await self.bot.wavelink.get_tracks(
            f"{self.bot.config.music.resolve_endpoint}?id={track_obj.id}"
        )
        if not tracks:
            return await msg.edit(content=_("No results..."))
        track = tracks[0]
        track = self.update_track(
            track,
            requester=ctx.author,
            channel_id=ctx.channel.id,
            track_obj=track_obj,
        )

        if not ctx.player.is_connected:
            await ctx.player.connect(ctx.voice_channel)
            # Setup some attributes
            ctx.player.dj = ctx.author
            ctx.player.locked = False
            ctx.player.loop = False

        await self.add_entry_to_queue(track, ctx.player, msg=msg)

    @is_not_locked()
    @get_player()
    @is_in_vc()
    @commands.command(brief=_("Play a song"))
    @locale_doc
    async def play(self, ctx, *, query: str):
        _(
            """`<query>` - The query to search a song by

            Query for a track and play or add the first result to the playlist.
            If this is not the song you were looking for, try `{prefix}chooseplay`."""
        )
        msg = await ctx.send(
            _("Downloading track... This might take up to 3 seconds...")
        )
        async with self.bot.trusted_session.get(
            self.bot.config.music.query_endpoint,
            params={"limit": 1, "q": query},
        ) as r:
            results = await r.json()
        try:
            track_obj = Track(results[0])
            tracks = await self.bot.wavelink.get_tracks(
                f"{self.bot.config.music.resolve_endpoint}?id={track_obj.id}"
            )
            if not tracks:
                return await msg.edit(content=_("No results..."))
            track = tracks[0]
            track = self.update_track(
                track,
                requester=ctx.author,
                channel_id=ctx.channel.id,
                track_obj=track_obj,
            )
        except (KeyError, IndexError):
            return await msg.edit(content=_("No results..."))

        if not ctx.player.is_connected:
            await ctx.player.connect(ctx.voice_channel)
            # Setup some attributes
            ctx.player.dj = ctx.author
            ctx.player.locked = False
            ctx.player.loop = False

        await self.add_entry_to_queue(track, ctx.player, msg=msg)

    @is_dj()
    @get_player()
    @is_playing()
    @commands.command(aliases=["unlock"], brief=_("Lock the player"))
    @locale_doc
    async def lock(self, ctx):
        _(
            """Lock/Unlock the player. This allows nobody else to control the music.

            Only the session's DJ can use this command."""
        )
        if ctx.player.locked:
            ctx.player.locked = False
        else:
            ctx.player.locked = True
        await ctx.message.add_reaction("✅")

    @vote("loop")
    @is_not_locked()
    @get_player()
    @is_playing()
    @commands.command(aliases=["repeat"], brief=_("Toggle repeat"))
    @locale_doc
    async def loop(self, ctx):
        _(
            """Toggle repeat of the playing queue.

            Once a song finishes, it will be added at the end of the queue automatically.

            If there are more than one person in the session and a non-DJ uses this command, a vote has to pass first."""
        )
        if ctx.player.loop:
            ctx.player.loop = False
        else:
            ctx.player.loop = True
        await ctx.message.add_reaction("✅")

    @vote("skip")
    @is_not_locked()
    @get_player()
    @is_playing()
    @commands.command(brief=_("Skip the currently playing song."))
    @locale_doc
    async def skip(self, ctx):
        _(
            """Skip the currently playing song.

            If there are more than one person in the session and a non-DJ uses this command, a vote has to pass first."""
        )
        await ctx.player.stop()
        await ctx.message.add_reaction("✅")

    @vote("stop")
    @is_not_locked()
    @get_player()
    @is_playing()
    @commands.command(aliases=["leave"], brief=_("Stops the music"))
    @locale_doc
    async def stop(self, ctx):
        _(
            """Stops the music and leaves voice chat.

            If there are more than one person in the session and a non-DJ uses this command, a vote has to pass first."""
        )
        del self.queue[ctx.guild.id]
        await ctx.player.destroy()
        await ctx.message.add_reaction("✅")

    @vote("volume")
    @is_not_locked()
    @get_player()
    @is_playing()
    @commands.command(aliases=["vol"], brief=_("Change the volume"))
    @locale_doc
    async def volume(self, ctx, volume: IntFromTo(0, 100)):
        _(
            """Changes the playback's volume.

            If there are more than one person in the session and a non-DJ uses this command, a vote has to pass first."""
        )
        if volume > ctx.player.volume:
            vol_warn = await ctx.send(
                _(
                    "⚠`Playback volume is going to change to {volume} in 5"
                    " seconds. To avoid the sudden earrape, control the volume on"
                    " client side!`"
                ).format(volume=volume)
            )
            await asyncio.sleep(5)
            await ctx.player.set_volume(volume)
            await vol_warn.delete()
        else:
            await ctx.player.set_volume(volume)
        await ctx.send(
            _(":white_check_mark:` Volume successfully changed to {volume}!`").format(
                volume=volume
            ),
            delete_after=5,
        )

    @vote("pause_resume")
    @is_not_locked()
    @get_player()
    @is_playing()
    @commands.command(aliases=["resume"])
    @locale_doc
    async def pause(self, ctx):
        _(
            """Toggles the music playback's paused state.

            If there are more than one person in the session and a non-DJ uses this command, a vote has to pass first."""
        )
        if not ctx.player.paused:
            await ctx.player.set_pause(True)
            await ctx.send(_(":white_check_mark:`Song paused!`"), delete_after=5)
        else:
            await ctx.player.set_pause(False)
            await ctx.send(_(":white_check_mark:`Song resumed!`"), delete_after=5)

    @vote("equalizer")
    @is_not_locked()
    @get_player()
    @is_playing()
    @commands.command(aliases=["equaliser", "eq"], brief=_("Change the equalizer"))
    @locale_doc
    async def equalizer(self, ctx, eq: str.upper):
        _(
            """`<eq>` - The equalizer to use

            Sets the equalizer. May be **flat, piano, metal or boost**.
            Flat is the standard, piano is quiet, metal boosts high frequencies and boost boosts low frequencies.

            If there are more than one person in the session and a non-DJ uses this command, a vote has to pass first."""
        )
        if eq not in ("FLAT", "PIANO", "METAL", "BOOST"):
            return await ctx.send(
                _("Not a valid equalizer. May be flat, piano, metal or boost.")
            )
        await ctx.player.set_eq(getattr(wavelink.Equalizer, eq.lower())())
        await ctx.message.add_reaction("✅")

    @get_player()
    @is_playing()
    @commands.command(aliases=["np"], brief=_("Shows the current song."))
    @locale_doc
    async def now_playing(self, ctx):
        _("""Displays some information about the currently playing song.""")
        current_song = self.queue[ctx.guild.id][0]

        if not (ctx.guild and ctx.author.color == discord.Color.default()):
            embed_color = ctx.author.color
        else:
            embed_color = self.bot.config.game.primary_colour

        playing_embed = discord.Embed(title=_("Now playing..."), colour=embed_color)
        playing_embed.add_field(
            name=_("Title"), value=f"```{current_song.track_obj.title}```", inline=False
        )
        playing_embed.add_field(
            name=_("Artist"),
            value=current_song.track_obj.artist.name,
        )
        playing_embed.set_thumbnail(url=current_song.track_obj.album.cover)
        playing_embed.add_field(name=_("Volume"), value=f"{ctx.player.volume} %")
        if ctx.player.paused:
            playing_embed.add_field(name=_("Playing status"), value=_("`⏸Paused`"))
        playing_embed.add_field(name=_("DJ"), value=ctx.player.dj.mention)
        playing_embed.add_field(
            name=_("Locked"), value=_("Yes") if ctx.player.locked else _("No")
        )
        playing_embed.add_field(
            name=_("Looping"), value=_("Yes") if ctx.player.loop else _("No")
        )
        playing_embed.add_field(
            name=_("Explicit"),
            value=_("Yes") if current_song.track_obj.explicit else _("No"),
        )
        playing_embed.add_field(name=_("Equalizer"), value=ctx.player.eq)
        button_position = int(100 * (ctx.player.position / current_song.length) / 2.5)
        controller = (
            "```ɴᴏᴡ ᴘʟᴀʏɪɴɢ:"
            f" {current_song.track_obj.title}\n{(button_position - 1) * '─'}⚪{(40 - button_position) * '─'}\n"
            f" ◄◄⠀{'▐▐' if not ctx.player.paused else '▶'} ⠀►►⠀⠀　　⠀"
            f" {str(timedelta(milliseconds=ctx.player.position)).split('.')[0]} /"
            f" {timedelta(seconds=current_song.track_obj.duration)}```"
        )
        playing_embed.description = controller
        playing_embed.set_footer(
            text=_("Song requested by: {user}").format(
                user=current_song.requester.display_name
            ),
            icon_url=current_song.requester.display_avatar.url,
        )
        await ctx.send(embed=playing_embed)

    @get_player()
    @is_playing()
    @commands.command(aliases=["q", "que", "cue"], brief=_("Show upcoming songs"))
    @locale_doc
    async def queue(self, ctx):
        _("""Show the next (maximum 5) tracks in the queue.""")
        entries = self.queue[ctx.guild.id][1:6]
        if entries:
            paginator = commands.Paginator()
            for entry in entries:
                paginator.add_line(
                    f"• {entry.title}"
                    f" ({timedelta(seconds=entry.track_obj.duration)}) -"
                    f" {entry.requester.display_name}"
                )
            queue_length = self.get_queue_length(ctx.guild.id) - 1
            text = _("Upcoming entries")
            await ctx.send(
                embed=discord.Embed(
                    title=f"{text} ({len(entries)}/{queue_length})",
                    description=paginator.pages[0],
                    color=discord.Color.gold(),
                )
            )
        else:
            await ctx.send(_("⚠`No more entries left.`"))

    @commands.command()
    @locale_doc
    async def lyrics(self, ctx, *, query: str = None):
        _(
            """`<query>` - The query to search the song by; defaults to the currently playing song

            Retrieves song lyrics. If no song specified, will check the current playing song."""
        )
        await ctx.trigger_typing()
        if query is None and ctx.guild:
            track = self.bot.wavelink.get_player(ctx.guild.id).current
            if not track:
                return await ctx.send(
                    _("I am not playing. Please specify a song to look for.")
                )
            query = f"{track.title} {track.track_obj.artist.name}"
        elif query is None and not ctx.guild:
            return await ctx.send(_("Please specify a song."))
        elif len(query) < 3:
            return await ctx.send(_(":x: Look for a longer query!"), delete_after=5)
        async with self.bot.session.get(f"https://lyrics.tsu.sh/v1?q={query}") as r:
            result = await r.json()
        if "error" in result:
            return await ctx.send(_("⚠ No results!"))
        p = commands.Paginator()
        for line in html.unescape(result["content"]).split("\n"):
            for i in chunks(line, 1900):
                p.add_line(i)
        await self.bot.paginator.Paginator(
            title=result["song"]["full_title"],
            entries=p.pages,
            length=1,
        ).paginate(ctx)

    def update_track(
        self,
        track: wavelink.Track,
        requester: discord.Member,
        channel_id: int,
        track_obj: Track,
    ):
        return FakeTrack(
            track.id,
            track.info,
            query=track.query,
            requester=requester,
            channel_id=channel_id,
            track_obj=track_obj,
        )

    async def add_entry_to_queue(
        self, track: FakeTrack, player: wavelink.Player, msg: discord.Message = None
    ):
        if not self.get_queue_length(player.guild_id):
            self.queue[player.guild_id].append(track)
            await self.play_track(track, player, msg=msg)
        else:
            self.queue[player.guild_id].append(track)
            await msg.edit(
                content=_("🎧 Added {title} to the queue...").format(
                    title=track.title,
                )
            )

    async def play_track(self, track: FakeTrack, player: wavelink.Player, msg=None):
        if msg is None:
            await self.bot.get_channel(track.channel_id).send(
                _("🎧 Playing {title}...").format(title=track.title)
            )
        else:
            await msg.edit(content=_("🎧 Playing {title}...").format(title=track.title))
        await player.play(track)

    def get_queue_length(self, guild_id: int) -> int:
        """Returns the queue's length or False if there is no upcoming songs"""
        return len(self.queue[guild_id])

    async def on_track_end(self, player: wavelink.Player):
        if not player.loop:
            try:
                self.queue[player.guild_id].pop(0)  # remove the previous entry
            except IndexError:
                pass
            if (
                not self.get_queue_length(player.guild_id)
                or len(self.bot.get_channel(int(player.channel_id)).voice_states) == 1
            ):
                # That was the last track
                await player.destroy()
                del self.queue[player.guild_id]
            else:
                await self.play_track(
                    self.queue[player.guild_id][0],
                    player,
                )
        else:
            # VC empty?
            if len(self.bot.get_channel(int(player.channel_id)).voice_states) == 1:
                await player.destroy()
                del self.queue[player.guild_id]
            # Cycle it so we still keep our format
            track = self.queue[player.guild_id].pop(0)
            self.queue[player.guild_id].append(track)
            await self.play_track(self.queue[player.guild_id][0], player)

    async def event_hook(self, event):
        """Handle wavelink events"""
        if isinstance(event, wavelink.TrackEnd):
            await self.on_track_end(event.player)

    async def cleanup(self):
        for player in self.bot.wavelink.players.values():
            await player.destroy()
        await self.bot.wavelink.destroy_node(identifier="MAIN")

    def cog_unload(self):
        self.bot.queue.put_nowait(self.cleanup())


def setup(bot):
    bot.add_cog(Music(bot))
