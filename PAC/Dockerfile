FROM alpine
MAINTAINER Shlomo shabbat@gmail.com

#ENV TOR_TEMP tor-$TOR_VER

RUN set -xe \
    && apk add -U curl \
                  libidn

EXPOSE 80

ENTRYPOINT ["/bin/bash"]
