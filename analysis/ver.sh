#!/bin/bash
#Description: Power Linux health check - search error or fail in /var/log/messages
#Write by Ken (kenpeng@tiis.com.tw)
#Date: 2017-11-27

tmpFile=${RANDOM}_temp
find ahc -name redhat-release > ${tmpFile}		#尋找並列出檔案清單存檔
echo -e "\nRedHat Version:\n"

while read LINE
do
	dir=$(echo ${LINE} | awk -F'/' '{print $1"/"$2"/"}') 
	hostName=$(echo ${LINE} | awk -F'/' '{print $2}' | awk -F'_' '{print $2}')
	osVer=$(awk '{print $1$2" "$7}' ${LINE})
	kernelVer=$(awk '{print $3}' ${dir}uname_a)
	echo -e ${hostName} ${osVer}  ${kernelVer}
done < ${tmpFile}
rm -f ${tmpFile}
echo
echo "----------------------------------------------------------"

