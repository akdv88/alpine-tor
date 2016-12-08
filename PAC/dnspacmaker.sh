#!/bin/sh
# Shell script to make PAC file to proxify Russian blocked sites.
# It uses only dnsDomainIs function to parse.
# Generated PAC file works with Firefox only.

dir="/tmp"
inlist="$dir/curl-list"
outlist="$dir/out-list"
idnlist="$dir/idn-list"
sort="$dir/sort-list"
pac="$STORAGE/tor-proxy.pac"
proxy="SOCKS 127.0.0.1:9050"

   echo -ne "\nDownloading full banned list..." \
	&& curl -s http://api.antizapret.info/all.php \
	| sed 's/^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9];//g; s/^;//g; s/;.*$//g; s/^.*http:\/\//http:\/\//g; s/^.*https:\/\//https:\/\//g; /^$/d' \
	| tr '[:upper:]' '[:lower:]' > $inlist \
	&& echo -e "Done" \
&& echo -n "Parsing http urls..." \
	&& grep -E "^http:" $inlist \
        | sed 's/^http:\/\/www[0-9]*\.//g; s/^http:\/\///g; s/\/.*$//g' > $outlist \
        && sed -i '/^http:/d' $inlist \
	&& echo -e "Done" \
&& echo -n "Parsing https urls..." \
	&& grep -E "^https:" $inlist \
        | sed 's/^https:\/\/www[0-9]*\.//g; s/^https:\/\///g; s/\/.*$//g' >> $outlist \
        && sed -i '/^https:/d' $inlist \
	&& echo -e "Done" \
&& echo -n "Parsing asterisks..." \
	&& grep -E "^\*" $inlist \
        | sed 's/^\*\.//g' >> $outlist \
        && sed -i '/^\*/d' $inlist \
	&& echo -e "Done" \
&& echo -n "Parsing commas..." \
	&& grep -E ',' $inlist | tr "," "\n" \
        | sed 's/^newcamd525:\/\///g; s/:[0-9]*$//g' >> $outlist \
        && sed -i '/,/d' $inlist \
	&& echo -e "Done" \
&& echo -n "Parsing www..." \
	&& sed 's/^www[0-9]*\.//g' $inlist >> $outlist \
	&& rm $inlist \
	&& echo -e "Done" \
&& echo -n "Performing idn convertion..." \
	&& grep -E "[а-я]" $outlist | while read line
	do 
		(echo $line | idn) >> $idnlist
	done \
	&& sed -i '/[а-я]/d' $outlist \
	&& cat $idnlist >> $outlist \
	&& rm $idnlist \
	&& echo -e "Done" \
&& echo -n "Making PAC file..." \
	&& echo -e 'function FindProxyForURL(url, host) {\n\thost = host.toLowerCase();' > $pac \
	&& sort -u $outlist | sort -d > $sort \
	&& rm $outlist \
	&& echo -e "\tif (dnsDomainIs(host, \"$(head -n 1 $sort)\") ||" >> $pac \
	&& sed -i '1d' $sort \
	&& sed -e 's/^/\tdnsDomainIs(host, \"/g; s/$/\") \|\|/g' $sort >> $pac \
	&& sed -i '$s/\s||/)/g' $pac \
	&& echo -e "\treturn \"$proxy\";\n" >> $pac \
	&& rm $sort \
	&& echo "}" >> $pac \
	&& echo -e "Done\n\n\t$(wc -l $pac | grep -Eo "[0-9]*") lines writed to $pac\n" \
&& exit 0
