FROM alpine
MAINTAINER Shlomo shabbat@gmail.com

#ENV TOR_ENV production

RUN set -xe \
    && apk add --no-cache lighttpd

COPY lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY lighttpd-entrypoint.sh /lighttpd-entrypoint.sh

RUN chmod +x /lighttpd-entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/lighttpd-entrypoint.sh"]
