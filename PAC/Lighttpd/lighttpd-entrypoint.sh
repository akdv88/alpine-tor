#!/bin/sh

set -e

ln -s /pac /var/www/localhost/

cat << EOF > /var/www/localhost/pac/default.html
<!DOCTYPE html>
<html>
<body>

<h1>Tor Proxy Pac</h1>

</body>
</html>
EOF

exec lighttpd -D -f /etc/lighttpd/lighttpd.conf 2>&1
