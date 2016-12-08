#!/bin/sh

set -e

ln -s ln -s /pac /var/www/localhost/pac

lighttpd -f /etc/lighttpd/lighttpd.conf
