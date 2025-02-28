#!/bin/bash
# Adrian's script for setting up a quick test deployment
podman pull docker://docker.io/library/redis:6-alpine
podman pull docker://docker.io/library/postgres:14-alpine
podman pull quay.io/gelbpunkt/stockfish:latest
podman pull quay.io/gelbpunkt/okapi:latest
podman pod create --name idlerpgbeta -p 5432:5432 -p 6379:6379
podman run --rm -d --pod idlerpgbeta --name redis-beta redis:6-alpine
cat <<EOF > start.sh
createdb idlerpg
psql idlerpg -c "CREATE ROLE jens WITH PASSWORD 'owo';"
psql idlerpg -c "ALTER ROLE jens WITH LOGIN;"
psql idlerpg -c "CREATE ROLE prest WITH PASSWORD 'placeholder';"
psql idlerpg -c "CREATE ROLE votehandler WITH PASSWORD 'placeholder';"

psql idlerpg <<'DONE'
$(<schema.sql)
DONE
EOF

chmod 777 start.sh
podman run --rm -d --pod idlerpgbeta --name postgres-beta -e POSTGRES_PASSWORD="test" -v $(pwd)/start.sh:/docker-entrypoint-initdb.d/init.sh:Z postgres:14-alpine
sleep 15
rm start.sh
podman run --rm -d --pod idlerpgbeta --name stockfish-beta gelbpunkt/stockfish:latest
podman run --rm -d --pod idlerpgbeta --name okapi-beta gelbpunkt/okapi:latest
# uncomment to enable lavalink
# podman build -t lavalink:latest -f units/Dockerfile.lavalink .
# podman run --rm -d --pod idlerpgbeta --name lavalink-beta -v $(pwd)/application.yml:/lavalink/application.yml:Z lavalink:latest
