# Tor on Alpine Linux dockerfile

FROM alpine
MAINTAINER Shlomo shabbat@gmail.com

ENV TOR_ENV production
ENV TOR_VER 0.2.8.9
ENV TOR_FILE tor-$TOR_VER.tar.gz
ENV TOR_URL https://dist.torproject.org/$TOR_FILE
ENV TOR_TEMP tor-$TOR_VER

RUN set -xe \
    && apk add --no-cache build-base \
               gmp-dev \
               libevent \
               libevent-dev \
               libgmpxx \
               openssl \
               openssl-dev \
               python-dev \
    && cd /tmp \
    && wget $TOR_URL \
    && tar xzvf $TOR_FILE \
    && cd $TOR_TEMP \
    && ./configure --prefix=/ --exec-prefix=/usr \
    && make install \
    && cd .. \
    && rm -rf $TOR_FILE $TOR_TEMP \
    && apk del build-base \
               git \
               gmp-dev \
               go \
               python-dev \
    && addgroup -g 20000 -S tord && adduser -u 20000 -G tord -S tord \
    && chown -Rv tord:tord /home/tord/

COPY ./torrc /etc/tor/torrc
COPY ./tor-entrypoint.sh /tor-entrypoint.sh

RUN chmod 755 /tor-entrypoint.sh \
    && echo "HashedControlPassword $(tor --hash-password testdrive | sed '1d')" >> /etc/tor/torrc

#VOLUME /etc/tor /home/tord/.tor

# SocksPort, ControlPort
EXPOSE 9050 9100


ENTRYPOINT ["/tor-entrypoint.sh"]
