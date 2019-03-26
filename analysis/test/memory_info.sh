#!/bin/bash
#Description: Power Linux health check - analysis memory usage
#Write by Ken (kenpeng@tiis.com.tw)
#Date: 2017-10-31
#Version: v1.00

tmpFile=${RANDOM}_temp
find ahc -name memory_info > ${tmpFile}		#尋找並列出檔案清單存檔
echo -e "\nMemory & swap info :\n"

while read LINE
do
	spaceV=0		#控制是否加一空行
	hostName=$(echo ${LINE} | awk -F'/' '{print $2}' | awk -F'_' '{print $2}')
	memTotal=$(grep 'Mem:' ${LINE} | awk '{print $2}')
	memUsed=$(grep 'Mem:' ${LINE} | awk '{print $3}')
	swapTotol=$(grep 'Swap:' ${LINE} | awk '{print $2}')
	swapUsed=$(grep 'Swap:' ${LINE} | awk '{print $3}')
	memUsedP=$(echo "scale=3;"${memUsed}/${memTotal}*100 | bc)			#記憶體使用率
	swapMemP=$(echo "scale=3;"${swapTotol}/${memTotal}*100 | bc)		#swap/memory 百分比
	swapUsedP=$(echo "scale=3;"${swapUsed}/${swapTotol}*100 | bc)		#swap使用率
	[ $(echo "${memUsedP} > 120" | bc) -eq 1 ] && echo ${hostName} 'Memory used' ${memUsedP}'% > 120%' && spaceV=1
	[ $(echo "${swapMemP} < 30" | bc) -eq 1 ] && echo ${hostName} 'Swap are Memory' ${swapMemP}'% < 30%' && spaceV=1
	[ $(echo "${swapUsedP} > 50" | bc) -eq 1 ] && echo ${hostName} 'Swap used' ${swapUsedP}'% > 50%' && spaceV=1
	[ ${spaceV} -eq 1 ] && echo
done < ${tmpFile}
rm -f ${tmpFile}
echo "----------------------------------------------------------"

