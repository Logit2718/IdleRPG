��    Z      �     �      �     �     �  R   �      #  -   D     r     �     �     �     �     �     �     	  +   	  &   B	  1   i	  +   �	  /   �	     �	     
  �   '
       .     ?   E  !   �  %   �     �  <   �       c   (     �  .   �     �  z   �  u   l  }   �  )   `  :   �  *   �     �        '        -  �  3  �  �  !   �     �     �  D   �  #     5   :  /   p  3   �  7   �       c      c   �  5   �  �     �   �  �   R  �     �  �  �  �  �  K    /#    J&  �   _)    �)     
+     %+  8   (+  a   a+  T   �+  e   ,  X   ~,  i   �,  \   A-  `   �-  [   �-  )   [.  1   �.  K   �.     /  !   /     </  8   Z/  5   �/  �   �/  �  �0     12     B2  ]   J2  +   �2  4   �2  #   	3     -3     H3     h3     n3     �3     �3     �3  4   �3  +   �3  =   )4  5   g4  =   �4     �4     �4  �   5     �5  7   �5  P   6  +   k6  !   �6     �6  G   �6     7  h   &7     �7  9   �7     �7  �   �7  ~   �8  |   9  .   �9  G   �9  1   �9     +:     B:  -   G:     u:  d  |:  �  �;  +   v=     �=  "   �=  0   �=     	>  <   )>  3   f>  6   �>  B   �>     ?  `   -?  [   �?  3   �?  �   @  �   �@  �   EA  �   �A    �B  �  �F    jJ  $  pN  2  �Q  �   �T  !  ~U  $   �V     �V  <   �V  h   	W  \   rW  h   �W  ^   8X  k   �X  _   Y  }   cY  t   �Y  /   VZ  8   �Z  R   �Z     [  %   *[     P[  9   m[  @   �[  �   �[        W      +       @   A   X   F   S   
   O   $   Z   I       L                9   Q   V   N       P       C   E   6   U   5   (       G          .   %                   :              ,   R   '            ?              ;                                   &   K   8                     -   D   J      <         0   M          !                 T           1   2   H           )         #   3                          =       4          B       >      7   	   /   *   Y   "    Action #{number} Armor Battle **{author}** vs **{enemy}** started! 30 seconds of fighting will now start! Battle against a player (active) Battle against a player (inclusdes raidstats) Battle against another player Battle {p1} vs {p2} Check the available languages Damage Defines an avatar's edges Inverts a user's avatar Let the battle begin! Name Noone joined your raid tournament {author}. Noone joined your tournament {author}. Noone wanted to join your activebattle, {author}! Noone wanted to join your battle, {author}! Noone wanted to join your raidbattle, {author}! Not a valid language. Open a trick or treat bag Open a trick or treat bag, you can get some with `{prefix}trickortreat`.

            Trick or treat bags contain halloween-themed items, ranging from 1 to 50 base stat.
            Their value will be between 1 and 200. Pixelfy an avatar Raid Tournament ended! The winner is {winner}. Raid Tournament ended! The winner is {winner}.
Money was given! Raidbattle {p1} vs. {p2} started! Remaining trick-or-treat bags: {bags} Round Done! Seems you haven't got a trick or treat bag yet. Go get some! Set your language Shows the amount of trick or treat bags you have. You can get more by using `{prefix}trickortreat`. Shows your trick or treat bags Someone refused to move. Activebattle stopped. Start a new tournament There are **{num}** entries, due to the fact we need a playable raid tournament, the last **{removed}** have been removed. There are **{num}** entries, due to the fact we need a playable tournament, the last **{removed}** have been removed. To permanently choose a language, please create a character and enter this command again. I set it to {language} temporarily. Tournament ended! The winner is {winner}. Tournament ended! The winner is {winner}.
Money was given! Tournament started with **{num}** entries. Trick or treat! Type Use 1, 2, 3, 4 or 5 as intensity value. Value View all available languages' locale codes. You can check if your language is available by comparing against [this list](https://saimana.com/list-of-country-locale-code/)

            Some of these languages, like xtreme-owo or unplayable are no real languages but serve as a way to spice up the english text.
            If something is not yet translated, the english original text is used. Walk around the houses and scare the residents! Maybe they have a gift for you?

            This command requires two players, one that is waiting and one that rings at the door.
            If you are the one waiting, you will get a direct message from the bot later, otherwise you will get a reply immediately.

            There is a 50% chance you will receive a halloween bag from the other person.

            (This command has a cooldown of 3h) Winner of this match is {winner}! You are too poor. You can't battle yourself. You currently have **{trickortreat}** Trick or Treat Bags, {author}! You don't have a character, {user}. You don't have enough money to join the activebattle. You don't have enough money to join the battle. You don't have enough money to join the raidbattle. You found a new item when opening a trick-or-treat bag! You gained an item! You walk around the houses and ring at {waiting}'s house! Sadly they don't have anything for you... You walk around the houses and ring at {waiting}'s house! That's a trick or treat bag for you, yay! You walk around the houses... Noone is there... *yet* Your current language is **{current_locale}**. Available options: {all_locales}

Please use `{prefix}locale set language_code` to choose one. `<locale>` - The locale code of the language you want to use; full list can be found in `{prefix}language`

            Changes the language the bot replies for you. `[member]` - A discord User whose avatar to invert; defaults to oneself

            Invert the colors in someone's avatar.

            (This command has a channel cooldown of 15 seconds.) `[member]` - A discord User whose avatar to oil-paint; defaults to oneself

            Creates an oil-painting effect on someone's avatar.

            (This command has a channel cooldown of 15 seconds.) `[money]` - A whole number that can be 0 or greater; defaults to 0
            `[enemy]` - A user who has a profile; defaults to anyone

            Fight against another player while betting money.
            To decide players' stats, their items, race and class bonuses are evaluated.

            The money is removed from both players at the start of the battle. Once a winner has been decided, they will receive their money, plus the enemy's money.
            The battle takes place in rounds. Each round, both players have to choose their move using the reactions.
            Players can attack (⚔️), defend (🛡️) or recover HP (❤️).

            The battle ends if one player's HP drops to 0 (winner decided), or a player does not move (forfeit).
            In case of a forfeit, neither of the players will get their money back.

            The battle's winner will receive a PvP win, which shows on their profile.
            (This command has a cooldown of 10 minutes.) `[money]` - A whole number that can be 0 or greater; defaults to 0
            `[enemy]` - A user who has a profile; defaults to anyone

            Fight against another player while betting money.
            To decide the fight, the players' items, race and class bonuses and an additional number from 1 to 7 are evaluated, this serves as a way to give players with lower stats a chance at winning.

            The money is removed from both players at the start of the battle. Once a winner has been decided, they will receive their money, plus the enemy's money.
            The battle lasts 30 seconds, after which the winner and loser will be mentioned.

            If both players' stats + random number are the same, the winner is decided at random.
            The battle's winner will receive a PvP win, which shows on their profile.
            (This command has a cooldown of 90 seconds.) `[money]` - A whole number that can be 0 or greater; defaults to 0
            `[enemy]` - A user who has a profile; defaults to anyone

            Fight against another player while betting money.
            To decide the players' stats, their items, race and class bonuses and raidstats are evaluated.

            The money is removed from both players at the start of the battle. Once a winner has been decided, they will receive their money, plus the enemy's money.
            The battle is divided into rounds, in which a player attacks. The first round's attacker is chosen randomly, all other rounds the attacker is the last round's defender.

            The battle ends if one player's HP drops to 0 (winner decided), or if 5 minutes after the battle started pass (tie).
            In case of a tie, both players will get their money back.

            The battle's winner will receive a PvP win, which shows on their profile.
            (This command has a cooldown of 5 minutes) `[prize]` - The amount of money the winner will get

            Start a new raid tournament. Players have 30 seconds to join via the reaction.
            Tournament entries are free, only the tournament host has to pay the price.

            Only an exponent of 2 (2^n) users can join. If there are more than the nearest exponent, the last joined players will be disregarded.

            The match-ups will be decided at random, the battles themselves will be decided like raid battles (see `{prefix}help raidbattle` for details).

            The winner of a match moves onto the next round, the losers get eliminated, until there is only one player left.
            Tournaments in IdleRPG follow the single-elimination principle.

            (This command has a cooldown of 30 minutes.) `[prize]` - The amount of money the winner will get

            Start a new tournament. Players have 30 seconds to join via the reaction.
            Tournament entries are free, only the tournament host has to pay the price.

            Only an exponent of 2 (2^n) users can join. If there are more than the nearest exponent, the last joined players will be disregarded.

            The match-ups will be decided at random, the battles themselves will be decided like regular battles (see `{prefix}help battle` for details).

            The winner of a match moves onto the next round, the losers get eliminated, until there is only one player left.
            Tournaments in IdleRPG follow the single-elimination principle.

            (This command has a cooldown of 30 minutes.) `[user]` - A discord User whose avatar to edit; defaults to oneself

            Finds and exaggerates edges in a user's avatar, creating a cool image effect. `[user]` - A discord User whose avatar to pixelfy; defaults to oneself
            `[size]` - The pixelation rate to use, can be a number between 1 and 5; defaults to 2

            Pixelfies a user's avatar. If the user has an animated icon, the first frame is used. oil-paint someone's avatar vs {attacker} attacks! {defender} takes **{dmg}HP** damage. {author} seeks a battle with {enemy}! React with ⚔ now to duel them! The price is **${money}**. {author} seeks a battle! React with ⚔ now to duel them! The price is **${money}**. {author} seeks a raidbattle with {enemy}! React with ⚔ now to duel them! The price is **${money}**. {author} seeks a raidbattle! React with ⚔ now to duel them! The price is **${money}**. {author} seeks an active battle with {enemy}! React with ⚔ now to duel them! The price is **${money}**. {author} seeks an active battle! React with ⚔ now to duel them! The price is **${money}**. {author} started a raid tournament! Free entries, prize is **${prize}**! React with ⚔ to join! {author} started a tournament! Free entries, prize is **${prize}**! React with ⚔ to join! {p1} - {hp1} HP left
{p2} - {hp2} HP left {p1} won the raidbattle vs {p2}! Congratulations! {prevaction}
{player1}: **{hp1}** HP
{player2}: **{hp2}** HP
React to play. {user} does nothing... {user} joined the raidtournament. {user} joined the tournament. {user}, you already moved! Waiting for {other}'s move... {winner} won the battle vs {looser}! Congratulations! 🎃 As you step out of the door, you open your candy and plastic reveals an ancient image on top of a chocolate bar, passed along for generations. You decide to keep it in your `{prefix}eventbackground`s. Project-Id-Version: PACKAGE VERSION
Report-Msgid-Bugs-To: 
PO-Revision-Date: 2021-06-17 00:36+0000
Last-Translator: m.s <matteo.sarrantonio@asiconsulting.it>
Language-Team: Italian <http://translate.travitia.xyz/projects/idlerpg/bot/it/>
Language: it
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Plural-Forms: nplurals=2; plural=n != 1;
X-Generator: Weblate 4.6.2
 Azione #{number} Corazza La battaglia **{author}** contro **{enemy}** inizia! Inizieranno 30 secondi di combattimento! Battaglia contro un giocatore (interattiva) Battaglia contro un giocatore (include le raidstats) Battaglia contro un altro giocatore Battaglia {p1} contro {p2} Controlla le lingue disponibili Danno Definire i bordi di un avatar Inverte un avatar di un utente La battaglia ha inizio! Nome Nessuno si è unito al tuo raid tournament {author}. Nessuno si è unito al tuo torneo {author}. Nessuno ha voluto partecipare alla tua activebattle {author}! Nessuno ha voluto unirsi alla tua battaglia {author}! Nessuno ha voluto partecipare nella tua raidbattle, {author}! Lingua non valida. Apri una borsa di dolci Apri una borsa di dolci, puoi ricevere qualche `{prefix}trickortreat`.

Le borse dei dolci contengono oggetti a tema halloween, che possono variare da 1 a 50 di grado.
Il loro valore sarà tra 1 e 200. Pixella un avatar Il Raid Tournament è finito! Il vincitore è {winner}. Il Raid Tournament è finito! Il vincitore è {winner}.
I soldi sono stati dati! La raidbattle {p1} contro {p2} è iniziata! Borse dei dolci rimanenti: {bags} Scontro finito! Sembra che non hai ancora una borsa di dolci. Vai a prenderne qualcuna! Scegli la tua lingua Mostra la quantità di borse di dolci rimanenti. Ne puoi ottenere di più usando `{prefix}trickortreat`. Mostra le tue borse dei dolci Qualcuno si è rifiutato di agire. Activebattle stoppata. Inizia un nuovo torneo Ci sono **{num}** partecipanti, visto che abbiamo bisogno di un raid tournament giocabile, gli ultimi **{removed}** sono stati rimossi. Ci sono **{num}** partecipanti, visto che abbiamo bisogno di un torneo giocabile, gli ultimi **{removed}** sono stati rimossi. Per scegliere una lingua, crea un personaggio e scrivi di nuovo questo comando. Io la imposto temporaneamente in {language}. Il torneo è finito! Il vincitore è {winner}. Il torneo è finito! Il vincitore è {winner}.
I soldi sono stati dati! Il torneo è iniziato con **{num}** partecipanti. Dolcetto o scherzetto! Tipo Usa 1,2,3,4 o 5 come valore per l'intensità. Valore Vedi tutti i codici delle lingue disponibili . Puoi controllare se la tua lingua è disponibile confrontando [questa lista] (https://saimana.com/list-of-country-locale-code/)

Qualcuna di queste lingue, come xtreme-owo or unplayable non sono vere lingue ma servono per arricchire l'inglese.
Se qualcosa non è ancora tradotto, è usato il testo in inglese. Cammina per le case e spaventa gli abitanti! Magari hanno un regalo per te?

Questo comando necessita di due giocatori, uno che aspetta e l'altro che suona alla porta.
Se sei quello che aspetta, riceverai un messaggio diretto dal bot, altrimenti riceverai una risposta subito.

C'è una probabilità del 50% di ricevere una borsa di halloween dall'altra persona.

(Questo comando ha un cooldown di 3 ore) Il vincitore di questo scontro è {winner}! Sei troppo povero. Non puoi scontrarti con te stesso. Hai **{trickortreat}** borse di dolci, {author}! Non hai un personaggio, {user}. Non hai abbastanza soldi per partecipare alla active battle. Non hai abbastanza soldi per unirti alla battaglia. Non hai abbastanza soldi per entrare nella raidbattle. Hai trovato un nuovo oggetto quando hai aperto una borsa di dolci! Hai ottenuto un oggetto! Cammini in giro per le case e suoni alla casa di {waiting}! Purtroppo non hanno niente per te... Cammini in giro per le case e suoni alla casa di {waiting}! C'è una borsa di dolci per te! Cammini per le case... Non c'è nessuno... *ancora* La tua lingua è **{current_locale}**. Altre opzioni: {all_locales}

Per favore usa `{prefix}locale set linguage_code` per sceglierne una. `<locale>`- Il codice della lingua che vuoi usare; la lista completa può essere trovata in `{prefix}language`

Cambia la lingua in cui il bot ti risponde. `[member]`- Un utente discord che ha un avatar da invertire; predefinito a se stessi

Inverte i colori di un avatar.

(Questo comando ha un cooldown del canale di 15 secondi) `[member]`- Un utente discord che ha un avatar da dipingere ad olio; predefinito a se stessi

Crea una pittura ad olio con l'avatar di qualcuno

(Questo comando ha un cooldown di 15 secondi per canale) `[money]` - Un numero intero che può essere 0 o maggiore; il valore predefinito è 0
 `[enemy]` - Un utente che ha un profilo; predefinito chiunque

 Combatti contro un altro giocatore mentre scommetti denaro.
 Per decidere le statistiche dei giocatori, vengono valutati i loro oggetti, i bonus di razza e classe.

 Il denaro viene rimosso da entrambi i giocatori all'inizio della battaglia. Una volta che il vincitore è stato deciso, riceveranno i loro soldi, più i soldi del nemico.
 La battaglia si svolge in round. Ogni round, entrambi i giocatori devono scegliere la propria mossa utilizzando le reazioni.
 I giocatori possono attaccare (⚔️), difendere (🛡️) o recuperare HP (❤️).

 La battaglia termina se gli HP di un giocatore scendono a 0 (il vincitore è deciso), o un giocatore non si muove (forfait).
 In caso di forfait, nessuno dei giocatori riavrà indietro i propri soldi.

 Il vincitore della battaglia riceverà una vittoria PvP, che viene mostrata sul suo profilo.
 (Questo comando ha un tempo di recupero di 10 minuti.) `[money]`- Un numero che può essere 0 o più grande; predefinito è 0
`[enemy]` Un utente che ha un profilo; predefinito a tutti

Combatti contro un altro giocatore mentre scommetti soldi.
Per decidere la battaglia, l'equipaggiamento, la razza e i bonus delle classi e un numero a caso da 1 a 7 sono valutati, questo serve per dare ai giocatori con statistiche più basse una possibilità per vincere.

I soldi sono rimossi da entrambi i giocatori all'inizio della battaglia. Quando il vincitore è stato deciso, riceverà i suoi soldi, più i soldi del nemico.
La battaglia durerà 30 secondi, dopo i quali il vincitore e il perdente verranno menzionati.

Se le statistiche di tutti e due i giocatori + i numeri a caso sono uguali, il vincitore verrà deciso a caso.
Il vincitore della battaglia riceverà una vittoria PvP, che viene mostrata sul suo profilo.
(questo comando ha un cooldown di 90 secondi.) `[money]`- Un numero che può essere 0 o più grande; default è 0
`[enemy]`- Un utente che ha un profilo; default a tutti

Combatti contro un altro giocatore mentre scommetti denaro.
 Per decidere le statistiche dei giocatori, vengono valutati i loro oggetti, i bonus di razza e classe e le statistiche dei raid.

 Il denaro viene rimosso da entrambi i giocatori all'inizio della battaglia. Una volta che il vincitore è stato deciso, riceverà i suoi soldi, più i soldi del nemico.
 La battaglia è divisa in round, in cui un giocatore attacca. L'attaccante del primo round viene scelto casualmente, in tutti gli altri round l'attaccante è il difensore dell'ultimo round.

La battaglia finisce se gli HP di un giocatore vanno a 0 (vincitore deciso), o se 5 minuti dopo l'inizio della battaglia passano (pareggio).
In caso di pareggio, tutti e due i giocatori riceveranno i soldi indietro.

Il vincitore della battaglia riceverà una vittoria PvP, che sarà mostrata sul suo profilo.
 (Questo comando ha cooldown  di 5 minuti) `[prize]`- La quantità di soldi che il vincitore otterrà

Inizia un nuovo raid tournament. I giocatori avranno 30 secondi per partecipare reagendo.
Le iscrizioni ai tornei sono gratuite, solo l'organizzatore deve pagare il costo.

Solo un numero di utenti esponente di 2 (2^n) può partecipare. Se ci sono più giocatori dell'esponente più vicino, gli ultimi partecipanti verranno cacciati.

Gli accoppiamenti saranno decisi a caso, le battaglie saranno organizzate come battaglie normali (vedi `{prefix}help battle`per maggiori dettagli).

Il vincitore di una battaglia verrà qualificato per il round dopo, il perdente verrà eliminato, finchè non ci sarà solo un giocatore rimasto.
I tornei di IdleRPG seguono il principio della singola eliminazione

(Questo comando ha un cooldown di 30 minuti.) `[prize] ` - La quantità di soldi che il vincitore riceverà

Inizia un nuovo torneo. I giocatori hanno 30 secondi per partecipare tramite le reazioni.
Le iscrizioni ai tornei sono gratuite, solo l'organizzatore del torneo deve pagare il costo.

Solo un numero di utenti esponente di 2 (2^n) può partecipare. Se ci sono più giocatori dell'esponente più vicino, gli ultimi partecipanti verranno cacciati.

Gli accoppiamenti saranno decisi a caso, le battaglie saranno organizzate come battaglie normali (vedi `{prefix}help battle`per maggiori dettagli).

Il vincitore di una battaglia verrà qualificato per il round dopo, il perdente verrà eliminato, finchè non ci sarà solo un giocatore rimasto.
I tornei di IdleRPG seguono il principio della singola eliminazione

(Questo comando ha un cooldown di 30 minuti.) `[user]`- Un Utente di discord che ha un avatar da pixellare; predefinito a se stessi

Trova e esagera i bordi di un avatar di un utente, creando un fantastico effetto dell'imagine. `[user]`- Un Utente di discord che ha un avatar da pixellare; predefinito a se stessi
`[size]` - Il tasso si pixellazione da usare, può essere un numero tra 1 e 5; il valore predefinito è 2

Pixellifica un avatar di un utente. Se l'utente ha un'icona animata, sarà usato il primo frame. Dipinge ad olio l'avatar di qualcuno contro {attacker} attacca! {defender} subisce **{dmg}HP** di danno. {author} cerca una battaglia con {enemy}! Reagisci con ⚔ per combattere! Il premio è di **${money}**. {author} cerca una battaglia! Reagisci con ⚔ per combattere! Il premio è di **${money}**. {author}cerca una raidbattle con {enemy}! Reagisci con ⚔ per combattere! Il premio è di **${money}**. {author} cerca una raid battle! Reagisci con ⚔ per combattere! Il premio è di **${money}**. {author} cerca una active battle con {enemy}! Reagisci con ⚔ per duellarlo! Il premio è di **${money}**. {author} cerca una active battle! Reagisci con ⚔ per duellarlo! Il premio è di **${money}**. {author} ha iniziato un raid tournament! Iscrizioni gratuite, il premio è di **${prize}**! Reagisci con ⚔ per partecipare! {author} ha iniziato un torneo! Iscrizioni gratuite, il premio è di **${prize}**! Reagisci con ⚔ per partecipare! {p1}-{hp1} HP rimanenti
{p2}-{hp2} HP rimanenti {p1}ha vinto la raidbattle contro {p2}! Congratulazioni! {prevaction}
{player1}: **{hp1}** HP
{player2}: **{hp2}** HP
Reagisci per giocare. {user} non fa niente... {user} partecipa nel raid tournament. {user} partecipa nel torneo. {user}, hai già mosso! Aspettando la mossa di {other}... {winner} ha vinto la battaglia contro {looser}! Congratulazioni! 🎃 Quando esci dalla porta, apri il tuo dolcetto e la plastica rivela una vecchia immagine sopra a una barretta di cioccolato, passata per generazioni. Decidi di portarla nei tuoi `{prefix}eventbackground`s. 