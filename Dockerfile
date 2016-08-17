FROM golang
MAINTAINER Abiola Ibrahim <abiola89@gmail.com>

LABEL caddy_version="0.8.3" architecture="amd64"

RUN apt-get update && apt-get install -y openssh-client git

RUN go get github.com/mholt/caddy/caddy

EXPOSE 80 443 2015
VOLUME /srv
WORKDIR /srv

ADD Caddyfile /etc/Caddyfile
ADD index.html /srv/index.html
COPY start /start

RUN chmod +x /start

ENTRYPOINT ["/start"]
CMD ["--conf", "/etc/Caddyfile"]

