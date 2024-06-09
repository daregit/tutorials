#!/bin/sh

set -x

SCRIPTDIR=$(dirname "${BASH_SOURCE[0]}")

D="$SCRIPTDIR/cert"
if [[ ! -d "$D" ]]; then
mkdir -p $D
openssl req -newkey rsa:2048 -nodes -keyout "$D/key.pem" -x509 -days 365 -out "$D/cert.pem" -subj "/C=US/CN=localhost"
fi

docker-compose down
docker-compose build
docker-compose up -d

ONION=$(docker-compose exec -T tor-node cat /var/lib/tor/gitea_service/hostname)
#openssl req -newkey rsa:2048 -nodes -keyout "$D/key.pem" -x509 -days 365 -out "$D/cert.pem" -subj "/C=US/CN=${ONION}"

docker-compose restart caddy

echo "gitea is ready under ${ONION}"
