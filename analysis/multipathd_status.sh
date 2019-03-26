#!/bin/bash
#Description: Power Linux health check - check multipathd service
#Write by Ken (kenpeng@tiis.com.tw)
#Date: 2017-10-31
#Version: v1.00

tmpFile=${RANDOM}_temp
find ahc -name systemctl_status_multipathd > ${tmpFile}		#尋找並列出檔案清單存檔
echo -e "\ncheck multipathd service :"

while read LINE
do
	hostName=$(echo ${LINE} | awk -F'/' '{print $2}' | awk -F'_' '{print $2}')
	enableV=$(grep 'Loaded:' ${LINE} | awk '{print $4}')
	startV=$(grep 'Active:' ${LINE} | awk '{print $2}')
	if [ -s ${LINE} ] && ([ ${enableV} != 'enabled)' ] || [ ${startV} != 'active' ])
	then
		echo ${hostName} 
		[ ${enableV} != 'enabled)' ] && echo " service disable"
		[ ${startV} != 'active' ] && echo " service stop"
		echo
	fi
	#echo
done < ${tmpFile}
rm -f ${tmpFile}
echo "----------------------------------------------------------"

