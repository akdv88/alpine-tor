#!/bin/sh
# Shell script to make PAC file to proxify Russian blocked sites with two functions inside:
# shExpMatch for urls and dnsDomainIs for domains. However, it seems that generated PAC file doesn't work with any popular browsers,
# such as Firefox or Chrome - both giving errors related to memory.
# Although this file is correct, but now it's useless.

dir="/tmp"
inlist="$dir/curl-list"
outlist="$dir/out-list"
idnlist="$dir/idn-list"
sort="$dir/sort-list"
url="$dir/url-list"
dns="$dir/dns-list"
pac="$dir/tor-proxy.pac"
proxy="SOCKS 127.0.0.1:9050"

clear \
&& echo -ne "\nDownloading full banned list..." \
&& curl -s http://api.antizapret.info/all.php \
	| sed 's/^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9];//g; s/^;//g; s/;.*$//g; s/^.*http:\/\//http:\/\//g; s/^.*https:\/\//https:\/\//g; /^$/d' \
	| tr '[:upper:]' '[:lower:]' > $inlist \
&& echo -e "Done" \
&& echo -ne "Parsing http urls..." \
&& grep -E "^http:" $inlist \
        | sed 's/^http:\/\/www[0-9]*\.//g; s/^http:\/\///g; s/\/$//g' > $outlist \
        && sed -i '/^http:/d' $inlist \
&& echo -e "Done" \
&& echo -ne "Parsing https urls..." \
&& grep -E "^https:" $inlist \
        | sed 's/^https:\/\/www[0-9]*\.//g; s/^https:\/\///g; s/\/$//g' >> $outlist \
        && sed -i '/^https:/d' $inlist \
&& echo -e "Done" \
&& echo -ne "Parsing asterisks..." \
&& grep -E "^\*" $inlist \
        | sed 's/^\*\.//g' >> $outlist \
        && sed -i '/^\*/d' $inlist \
&& echo -e "Done" \
&& echo -ne "Parsing commas..." \
&& grep -E ',' $inlist | tr "," "\n" \
        | sed 's/^newcamd525:\/\///g; s/:[0-9]*$//g' >> $outlist \
        && sed -i '/,/d' $inlist \
&& echo -e "Done" \
&& echo -ne "Parsing www..." \
&& sed 's/^www[0-9]*\.//g' $inlist >> $outlist \
	&& rm $inlist \
&& echo -e "Done" \
&& echo -ne "Performing idn convertion..." \
&& grep -E "[а-я]" $outlist | while read line
	do 
		(echo $line | sed 's/\/.*//g' | idn) >> $idnlist
	done \
	&& sed -i '/[а-я]/d' $outlist \
	&& cat $idnlist >> $outlist \
	&& rm $idnlist \
&& echo -e "Done" \
&& echo -ne "Sorting & splitting to url & dns..." \
&& sort -u out-list | sort -d -o $sort \
	&& rm $outlist \
	&& grep -E "\/" $sort >> $url \
	&& grep -Ev "\/" $sort >> $dns \
	&& rm $sort \
&& echo -e "Done" \
&& echo -n "Making PAC file..." \
&& echo -e 'function FindProxyForURL(url, host) {\n\turl = url.toLowerCase();\n\thost = host.toLowerCase();' > $pac \
	&& echo -e "\tif (shExpMatch(url, \"*$(head -n 1 $url | sed 's/\.[a-z]*$//g')*\") ||" >> $pac \
	&& sed -i '1d' $url \
	&& cat $url | while read line
           do
		echo -e "\tshExpMatch(url, \"*$(echo $line | sed 's/\.[a-z]*$//g')*\") ||" >> $pac
		echo -ne "\e[0K\rMaking PAC file...$(wc -l $pac | grep -Eo "[0-9]*") lines writed"
	   done \
	&& sed -i '$s/\s||/)/g' $pac \
	&& echo -e "\treturn \"$proxy\";\n" >> $pac \
	&& rm $url \
	&& echo -e "\tif (dnsDomainIs(host, \"$(head -n 1 $dns)\") ||" >> $pac \
	&& sed -i '1d' $dns \
	&& cat $dns | while read line
	  do
		echo -e "\tdnsDomainIs(host, \"$line\") ||" >> $pac
		echo -ne "\e[0K\rMaking PAC file...$(wc -l $pac | grep -Eo "[0-9]*") lines writed"
	  done \
	&& sed -i '$s/\s||/)/g' $pac \
	&& echo -e "\treturn \"$proxy\";\n" >> $pac \
	&& rm $dns \
	&& echo "}" >> $pac \
	&& echo -e "Done\n$(wc -l $pac | grep -Eo "[0-9]*") lines writed to $pac\n" \
&& exit 0
