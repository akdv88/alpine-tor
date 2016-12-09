#!/bin/sh

set -e

ln -s /pac /var/www/localhost/

cat << EOF > /var/www/localhost/pac/default.html
<!DOCTYPE html>
<html>
<body>

<h1>Tor Proxy Pac</h1>
<h4>Type http://address/tor-proxy.pac to recieve PAC file</h4>

</body>
</html>
EOF

cat < /tmp/logpipe 1>&2 &
exec lighttpd -D -f /etc/lighttpd/lighttpd.conf 2>&1
