#!/bin/sh

set -e

ln -sf /pac /var/www/localhost/ 

cat << EOF > /var/www/localhost/pac/default.html
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<link rel="icon" href="http://soft2u.ru/wp-content/uploads/tor_browser_icon_soft2u.ru_.png">
</head><body>
<img src="http://www.idigitaltimes.com/sites/idigitaltimes.com/files/2015/05/29/tor-deanonymizing-traffic-hidden-service-traffic-hsdir-relay.jpg" alt="Tor" style="width:100px;height:60px;">
<h1>Tor Proxy Pac</h1>
<h4>Type http://address/tor-proxy.pac to recieve PAC file</h4>
</body></html>
EOF

cat < /tmp/log 1>&2 &
exec lighttpd -D -f /etc/lighttpd/lighttpd.conf 2>&1
