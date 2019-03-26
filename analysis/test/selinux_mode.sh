#!/bin/bash
#Description: Power Linux health check - SELinux mode
#Write by Ken (kenpeng@tiis.com.tw)
#Date: 2017-10-31
#Version: v1.00

tmpFile=${RANDOM}_temp
find ahc -name selinux > ${tmpFile}		#尋找並列出檔案清單存檔
echo -e "\nSELinux mode:\n"

while read LINE
do
	hostName=$(echo ${LINE} | awk -F'/' '{print $2}' | awk -F'_' '{print $2}')
	SELinuxMode=$(cat ${LINE})
	[ ${SELinuxMode} != "Disabled" ] && echo ${hostName} ${SELinuxMode}
done < ${tmpFile}
rm -f ${tmpFile}
echo "----------------------------------------------------------"

