#!/bin/sh

set -euxo pipefail

SCRIPTDIR=$(dirname "${BASH_SOURCE[0]}")

docker-compose down
docker-compose build
docker-compose up -d
ONION=$(docker-compose exec -T tor-node cat /var/lib/tor/gitea_service/hostname)

echo "gitea is ready under ${ONION}"
