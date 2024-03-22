#!/bin/sh

set -x

SCRIPTDIR=$(dirname "${BASH_SOURCE[0]}")

D="$SCRIPTDIR/datadir/cert"
if [[ ! -d "$D" ]]; then
mkdir -p $D
openssl req -newkey rsa:2048 -nodes -keyout "$D/key.pem" -x509 -days 365 -out "$D/cert.pem" -subj "/C=US/CN=localhost"

cat >$SCRIPTDIR/datadir/Caddyfile <<EOF
{
  auto_https disable_certs
}

*.onion {
  tls /cert/cert.pem /cert/key.pem
  encode gzip

  reverse_proxy gitea:3000 {
    header_up X-Real-IP {remote_host}
  }
}
EOF

fi

docker-compose down
docker-compose build
docker-compose up -d
docker-compose exec -T tor-node cat /var/lib/tor/gitea_service/hostname | tee datadir/toraddress.txt
docker-compose logs -f
