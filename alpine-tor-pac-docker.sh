#!/bin/sh

docker run -d --name torclient akdv88/alpine-tor:torclient \
        && docker run -d --name pacstorage akdv88/alpine-tor:storage \
        && docker run -d --restart=always --volumes-from pacstorage --name pacmaker akdv88/alpine-tor:pacmaker \
        && docker run -d --restart=always --volumes-from pacstorage -p 192.168.1.155:80:80 --name paclighttpd akdv88/alpine-tor:lighttpd \

docker ps -a
