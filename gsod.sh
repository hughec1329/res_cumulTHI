#!/bin/bash
# script to grab ca stations for GSOD database

cat GSOD_stations.TXT | grep 'US CA' | wc -l	# 566 CA stations

lnum=$(cat GSOD_stations.TXT | grep 'US US CA' | grep -v 'NO DATA' | cut -c 84-100 | awk -F " " '{if ($1<20000101 && $2>20120101) print NR}')    # get line nums of ca stations that have data from 2000 - 2012, number = 66

for i in $lnum
do
	sed $i'q;d' gsod_ca_stations.txt >> ./bigCA.txt
done


# can plot by lat long?

