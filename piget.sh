#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "Usage: piget.sh <string to search for>";
    exit 1;
fi
lookfor=$1;

blksize=1000;
if [ ${#lookfor} -gt $blksize ]; then
    echo "String to search for is too long. Max length is $blksize";
    exit 1;
fi

dlt=${#lookfor}
dlt=$((dlt - 1))
rdoffset=$((blksize - dlt))

strhr=0;
while true;  
do { 
    rtn=`curl https://api.pi.delivery/v1/pi?start=$strhr\&numberOfDigits=1000\&radix=10 2> /dev/null | grep $lookfor 2> /dev/null`; 
    if [ ${#rtn} -eq 0 ]; 
    then echo -en [$lookfor]$strhr :"\x0d";
    else echo [$lookfor]$strhr :$rtn | grep --color $lookfor;
    fi;
    
    strhr=$((strhr + rdoffset));
} done
