FROM alpine
MAINTAINER Shlomo shabbat@gmail.com

ENV dir /tmp

COPY dnspacmaker.sh $dir/dnspacmaker.sh

RUN set -xe \
    && apk add -U curl \
                  libidn \
    && chmod +x /tmp/dnspacmaker.sh \
    && .$dir/dnspacmaker.sh

EXPOSE 80

ENTRYPOINT ["/bin/bash"]
