#!/bin/sh

set -e

ln -s /pac /var/www/localhost/

exec lighttpd -D -f /etc/lighttpd/lighttpd.conf
