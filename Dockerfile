FROM alpine:3.5
MAINTAINER Abiola Ibrahim <abiola89@gmail.com>

LABEL caddy_version="0.9.5" architecture="amd64"

#ARG plugins=git
ARG plugins="awslambda,cors,expires,filter,git,filemanager,hugo,ipfilter,jsonp,jwt,locale,mailout,minify,multipass,prometheus,ratelimit,realip,search,upload"

RUN apk add --no-cache openssh-client git tar curl

RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/build?os=linux&arch=amd64&features=${plugins}" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
 && chmod 0755 /usr/bin/caddy \
 && /usr/bin/caddy -version \
 && curl -L -o - https://github.com/spf13/hugo/releases/download/v0.18.1/hugo_0.18.1_Linux-64bit.tar.gz | tar -C /usr/bin/ -zx hugo_0.18.1_linux_amd64 \
 && mv /usr/bin/hugo_0.18.1_linux_amd64/hugo_0.18.1_linux_amd64 /usr/bin/hugo \
 && chmod 0755 /usr/bin/hugo

EXPOSE 80 443 2015
VOLUME /root/.caddy
WORKDIR /srv

COPY Caddyfile /etc/Caddyfile
COPY index.html /srv/index.html

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]
