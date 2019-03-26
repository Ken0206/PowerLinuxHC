#!/bin/bash
#Description: Power Linux health check - analysis disk usage
#Write by Ken (kenpeng@tiis.com.tw)
#Date: 2017-10-31
#Version: v1.00

hostName=""
tmpFile1=${RANDOM}_temp
tmpFile2=${RANDOM}_temp
find ahc -name disk_usage > ${tmpFile2}		#尋找並列出檔案清單存檔
echo -e "\nDisk usage:\n"

while read FileListLine
do
	hostName=$(echo ${FileListLine} | awk -F'/' '{print $2}' | awk -F'_' '{print $2}')
	grep -v "Filesystem" ${FileListLine} > ${tmpFile1}		#過濾資料(測試環境)
	usageVal=0				#使用率值
	hostV=0					#是否顯示 hostname 判斷值
	remainingSpaceW=""		#可用空間
	remainingSpaceM=""		#可用空間單位 G 或 M (K 未判斷)
	remainingSpaceC=0		#可用空間字串總數
	remainingSpace=0		#可用空間，去掉單位

	while read LINE
	do
	    usageVal=$(echo ${LINE} | awk '{print $5}' | awk -F'%' '{print $1}')
		remainingSpaceW=$(echo ${LINE} | awk '{print $4}')
		remainingSpaceC=${#remainingSpaceW}
		remainingSpaceM=${remainingSpaceW:${remainingSpaceC}-1}
        remainingSpace=${remainingSpaceW:0:${remainingSpaceC}-1}

		if [ ${usageVal} -gt 95 ] && [ ${remainingSpaceM} == M  ] && [ ${remainingSpace} -lt 256 ]
		then			#使用率大於95% 且 可用空間單位是 M 且 可用空間小於 256
			if [ ${hostV} -eq 0 ]		#是否顯示 hostname
			then
				echo ${hostName}
				hostV=1
			fi
			echo ${LINE} echo -n ${LINE} | awk '{print $6 " " $5 " " $4}'
											#  mount point,  Use%,  Avail
		fi
	done < ${tmpFile1}
	[ ${hostV} -eq 1 ] && echo
done < ${tmpFile2}
rm -f ${tmpFile1} ${tmpFile2}
echo "----------------------------------------------------------"

