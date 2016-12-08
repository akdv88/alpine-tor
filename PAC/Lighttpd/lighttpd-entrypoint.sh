#!/bin/sh

set -e

ln -s /pac /var/www/localhost/pac

exec lighttpd -f /etc/lighttpd/lighttpd.conf
