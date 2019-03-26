#!/bin/bash
#Description: Power Linux health check - check multipathd service
#Write by Ken (kenpeng@tiis.com.tw)
#Date: 2017-10-31
#Version: v1.00

tmpFile=${RANDOM}_temp
find ahc -name status_multipathd > ${tmpFile}		#尋找並列出檔案清單存檔
echo -e "\ncheck multipathd service :\n"

while read LINE
do
	hostName=$(echo ${LINE} | awk -F'/' '{print $2}' | awk -F'_' '{print $2}')
	enableV=$(grep 'Loaded:' ${LINE} | awk '{print $4}')
	startV=$(grep 'Active:' ${LINE} | awk '{print $2}')
	if [ -s ${LINE} ] && ([ ${enableV} != 'enabled)' ] || [ ${startV} != 'active' ])
	then
		echo ${hostName} 
		if [ ${enableV} != 'enabled)' ]
		then
			[ ${startV} != 'active' ] && echo "service disable" || echo -e "service disable\n"
		fi
		[ ${startV} != 'active' ] && echo -e "service stop\n"
	fi
done < ${tmpFile}
rm -f ${tmpFile}
echo "----------------------------------------------------------"

