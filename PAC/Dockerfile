FROM alpine
MAINTAINER Shlomo shabbat@gmail.com

#ENV TOR_TEMP tor-$TOR_VER

COPY alpine-tor/PAC/dnspacmaker.sh /tmp

RUN set -xe \
    && apk add -U curl \
                  libidn \
    && chmod +x /tmp/dnspacmaker.sh \
    && ./dnspacmaker.sh

EXPOSE 80

ENTRYPOINT ["/bin/bash"]
