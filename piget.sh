#!/usr/bin/env bash

usage () {
    echo "Usage: piget.sh [from <Start search offset>] [beep] [raw] <Number string to search for> ...";
    echo "<Start search offset> : Default is 0";
    echo beep : Beep when found;
    echo raw : The displayed content is the content of the received data \(tags etc. are not displayed if not specified\)
    exit 1;
}

if [ $# -eq 0 ]; then
    usage;
fi

rawmode=0;
beepon=0;
strhr=0;
lookfor=();
while [ "$1" != "" ]; do
    #echo arg: $1;
    if [ "$1" == "from" ]; then
        if [ $# -lt 2 ]; then
            usage;
        fi
        shift;
        strhr=$1;
    elif [ "$1" == "beep" ]; then
        beepon=1;
    elif [ "$1" == "raw" ]; then
        rawmode=1;
    else
        lookfor+=("$1");
    fi
    shift;
done

blksize=1000;
if [ ${#lookfor} -gt $blksize ]; then
    echo "Number string to search for is too long. Max length is $blksize";
    exit 1;
fi

#echo Lookfor: ${lookfor[@]}
maxprmlen=0;
lookgors="";
for prm in ${lookfor[@]}
do {
    prmlen=${#prm};
    if [ $prmlen -gt $maxprmlen ]; then
        maxprmlen=$prmlen;
    fi
    lookgors="$lookgors -e $prm"
} done

dlt=$maxprmlen
dlt=$((dlt - 1))
rdoffset=$((blksize - dlt))

echo "Searching for ${lookgors[@]} from $strhr offset with $rdoffset offset";
#exit 1;

while true;  
do { 
    rtn=`curl https://api.pi.delivery/v1/pi?start=$strhr\&numberOfDigits=1000\&radix=10 2> /dev/null | grep $lookgors 2> /dev/null`; 
    if [ ${#rtn} -eq 0 ]; 
    then echo -en [${lookfor[@]}]$strhr :"\x0d";
    else {
        if [ $rawmode -eq 1 ]; then
            echo [${lookfor[@]}]$strhr :$rtn | grep --color $lookgors;
        else
            echo [${lookfor[@]}]$strhr :$rtn |sed -e "s/\"content\"://" | sed -e "s/[{}\"]//g" | grep --color $lookgors;
        fi
        if [ $beepon -eq 1 ]; then echo -en "\x07";
        fi
    }
    fi;
    
    strhr=$((strhr + rdoffset));
} done
