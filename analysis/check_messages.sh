#!/bin/bash
#Description: Power Linux health check - search error or fail in /var/log/messages
#Write by Ken (kenpeng@tiis.com.tw)
#Date: 2017-10-31
#Version: v1.00

hostName=""
tmpFile=${RANDOM}_temp
find ahc -name error_messages > ${tmpFile}		#尋找並列出檔案清單存檔
echo -e "\ncheck /var/log/message:\n"

while read LINE
do
	hostName=$(echo ${LINE} | awk -F'/' '{print $2}' | awk -F'_' '{print $2}')
	[ -s ${LINE} ] && echo ${hostName}
	#[ -s ${LINE} ] && echo ${hostName} && cat ${LINE} && echo -e "\n"
done < ${tmpFile}
rm -f ${tmpFile}
echo
echo "----------------------------------------------------------"

