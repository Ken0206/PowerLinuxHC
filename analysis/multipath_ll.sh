#!/bin/bash
#Description: Power Linux health check - check fail in "multipath -ll"
#Write by Ken (kenpeng@tiis.com.tw)
#Date: 2017-10-31
#Version: v1.00

hostName=""
tmpFile1=${RANDOM}_temp
find ahc -name multipath_ll > ${tmpFile1}		#尋找並列出檔案清單存檔
echo -e "\ncheck failed in \"multipath -ll\" :"

while read FileListLine
do
	hostName=$(echo ${FileListLine} | awk -F'/' '{print $2}' | awk -F'_' '{print $2}')
	#[ -s ${FileListLine} ] && echo ${hostName} && cat ${FileListLine} && echo -e "\n"
	grep "failed" ${FileListLine} &> /dev/null
	[ $? -eq 0 ] && echo ${hostName} && grep "failed" ${FileListLine} && echo
done < ${tmpFile1}
rm -f ${tmpFile1}
echo "----------------------------------------------------------"

