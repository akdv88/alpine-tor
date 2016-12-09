FROM alpine
MAINTAINER Shlomo shabbat@gmail.com

RUN set -xe \
    && apk add --no-cache lighttpd \
    && mkfifo -m 600 /tmp/log \
    && chown lighttpd:lighttpd /tmp/log

COPY lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY lighttpd-entrypoint.sh /lighttpd-entrypoint.sh

RUN chmod +x /lighttpd-entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/lighttpd-entrypoint.sh"]
