FROM alpine
MAINTAINER Shlomo shabbat@gmail.com

ENV UPDATE_TIME 1m
ENV STORAGE /pac

COPY pac-entrypoint.sh /pac-entrypoint.sh
COPY dnspacmaker.sh $dir/dnspacmaker.sh

RUN set -xe \
    && apk add -U curl \
                  libidn \
    && chmod +x /pac-entrypoint.sh \
    && chmod +x /dnspacmaker.sh \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["/pac-entrypoint.sh"]
