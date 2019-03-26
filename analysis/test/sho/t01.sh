#!/bin/bash

percentage=""
mountpoint=""
percentageValue=0
processTmpFile=${RANDOM}_temp
#grep -v "Filesystem" disk_usage > ${processTmpFile}
grep -v "Filesystem" disk_usage | awk '{print $5}' | awk -F'%' '{print $1}' > ${processTmpFile}

for i in $(cat ${processTmpFile})
do
	#echo ${i}
	[ ${i} -gt 90 ] && echo ${i}
	#percentage=$(echo i | awk '{print $5}')
	#mountpoint=$(echo i | awk '{print $6}')
	#percentageValue=$(echo ${i} | awk '{print $5}' | awk -F'%' '{print $1}')
	#echo ${percentageValue}
	#[ ${percentageValue} -gt 90 ] && echo ${i} | awk '{print $6 " " $5}'
done

rm ${processTmpFile}

#percentage=$(grep -v "Filesystem" ${processTmpFile} | awk '{print $5}')
#mountpoint=$(grep -v "Filesystem" disk_usage | awk '{print $6}')
#percentageValue=$(grep -v "Filesystem" disk_usage | awk '{print $5}' | awk -F'%' '{print $1}')

#echo ${percentage}
#echo ${percentageValue}
#echo ${mountpoint}
