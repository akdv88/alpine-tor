FROM alpine
MAINTAINER Shlomo shabbat@gmail.com

#ENV TOR_ENV production

RUN set -xe \
    && apk add -U lighttpd \
    && rm -rf /var/cache/apk/*

COPY lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY lighttpd-entrypoint.sh /lighttpd-entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/lighttpd-entrypoint.sh"]
