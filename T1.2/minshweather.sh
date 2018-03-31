#!/bin/bash
check_wget=`dpkg -s wget | grep "Status"`

if [ -n "$check_wget" ]; then
	while [ 1 ]
	do
		var=$(cat config.ini | sed 's/period=//g')
		wget -q pogoda.tut.by
		echo -n "Temperature in Minsk: "
		cat index.html | grep temp-i | sed 's/<span class="temp-i">//g;s/&deg;<\/span><\/div>//g' | sed '1!d'
		rm index.html
		sleep $var
	done
else
	echo "wget not installed. Pls, do sudo apt-get install wget"
fi	