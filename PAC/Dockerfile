FROM alpine
MAINTAINER Shlomo shabbat@gmail.com

ENV UPDATE_TIME 12h
ENV STORAGE /pac

COPY pac-entrypoint.sh /pac-entrypoint.sh
COPY dnspacmaker.sh $dir/dnspacmaker.sh

RUN set -xe \
    && apk add --no-cache curl \
                  libidn \
    && chmod +x /pac-entrypoint.sh \
    && chmod +x /dnspacmaker.sh

ENTRYPOINT ["/pac-entrypoint.sh"]
