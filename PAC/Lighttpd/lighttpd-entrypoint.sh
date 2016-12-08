#!/bin/sh

set -e

exec lighttpd -f /etc/lighttpd/lighttpd.conf
