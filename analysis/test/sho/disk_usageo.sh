#!/bin/bash

hostName=""
tmpFile1=${RANDOM}_temp
tmpFile2=${RANDOM}_temp
find ahc -name disk_usage > ${tmpFile2}
echo -e "\nDisk usage:\n"

while read LINE1
do
	hostName=$(echo ${LINE1} | awk -F'/' '{print $2}' | awk -F'_' '{print $2}')
	grep -v "Filesystem" ${LINE1} > ${tmpFile1}
	usageVal=0
	hostV=0

	while read LINE
	do
	    #echo ${LINE}
	    usageVal=$(echo ${LINE} | awk '{print $5}' | awk -F'%' '{print $1}')
	    #echo ${usageVal}
		if [ ${usageVal} -gt 95 ]
		then
			if [ ${hostV} -eq 0 ]
			then
				echo ${hostName}
				hostV=1
			fi
			echo ${LINE} echo -n ${LINE} | awk '{print $6 " " $5}'
		fi
	done < ${tmpFile1}
	[ ${hostV} -eq 1 ] && echo
done < ${tmpFile2}
rm -f ${tmpFile1} ${tmpFile2}
