FROM alpine:latest

RUN apk --update upgrade && apk add tor sudo bash
RUN rm -rf /var/cache/apk/*

RUN echo "HiddenServiceDir /var/lib/tor/gitea_service" >>/etc/tor/torrc
RUN echo "HiddenServicePort 22 gitea:22" >>/etc/tor/torrc
RUN echo "HiddenServicePort 80 caddy:80" >>/etc/tor/torrc
RUN echo "HiddenServicePort 443 caddy:443" >>/etc/tor/torrc

ENTRYPOINT ["/bin/bash", "-c", "sudo -u tor tor"]
