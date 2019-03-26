#!/bin/bash
#Description: Power Linux health check - analysis disk usage
#Write by Ken (kenpeng@tiis.com.tw)
#Date: 2017-10-31
#Version: v1.00

tmpFile1=${RANDOM}_temp
find Examples -name "*.sh" > ${tmpFile1}		#尋找並列出檔案清單存檔

while read FileListLine
do
    echo ${FileListLine}
    grep read ${FileListLine}

done < ${tmpFile1}
rm -f ${tmpFile1} 

