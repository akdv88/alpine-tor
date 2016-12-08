FROM alpine
MAINTAINER Shlomo shabbat@gmail.com

ENV UPDATE_TIME 12h

COPY entrypoint.sh /entrypoint.sh
COPY dnspacmaker.sh $dir/dnspacmaker.sh

RUN set -xe \
    && apk add -U curl \
                  libidn \
    && chmod +x /entrypoint.sh \
    && chmod +x /dnspacmaker.sh \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["/entrypoint.sh"]
