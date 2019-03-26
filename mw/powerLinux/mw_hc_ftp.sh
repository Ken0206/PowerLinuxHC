#!/bin/bash
#
#DIR=`dirname $0`
#. ${DIR}/config
DATE=`date +"%Y%m%d"`
#chk_date=`date +"%d"`
#chk_hour=`date +"%H"`
#chk_time=`date +"%M"`

#FTP to cxlsvr145 /mrtg/system_rawdata
[ -f /root/mw/test ] && ftpServer='192.168.188.71' || ftpServer='192.168.100.145'
#SERVER=192.168.100.145
FTP_ID=ftpmrtg
FTP_PWD=900mrtg2100
SOURCE_PATH=/usrtmp/ahc
#TARGET_PATH=/mrtg/system_rawdata
#FILE=${HOSTNAME}_rawdata

## every 15th to get data at 21:00-21:10
#if [[ $chk_date -eq 15 && $chk_hour -eq 21 ]];then
#  if [[ $chk_time -ge 00 && $chk_time -lt 10 ]];then

#${DIR}/rawdata.sh > ${SOURCE_PATH}/${FILE}

#ftp -n << EOF
#  open ${SERVER}
#  user ${FTP_ID} ${FTP_PWD}
#  lcd ${SOURCE_PATH}
#  cd ${TARGET_PATH}
#  bin
#  prom
#  passive
#  mkdir ${DATE}
#  cd ${DATE}
#  put ${FILE}
#EOF

#rm -rf ${SOURCE_PATH}/${FILE}

#  fi
#fi

MW_TIMESTAMP=`date +"%Y%m%d"`
MW_HOST=`hostname`
MW_SOURCE_PATH=/usrtmp/ahc/
#MW_FILE=*_HC_${MW_HOST}.${MW_TIMESTAMP}
#was.cxl1csat01.20161006.tar.gz
MW_FILE=*.${MW_HOST}.${MW_TIMESTAMP}.*
MW_FOLDER=${DATE}_MW_HC
#if [[ $chk_date -eq 20 && $chk_hour -eq 21 ]];then
#  if [[ $chk_time -ge 00 && $chk_time -lt 10 ]];then

#/home/support/mw_hc.sh > /dev/null 2>&1

ftp -n << EOF
  open ${ftpServer}
  user ${FTP_ID} ${FTP_PWD}
  lcd ${MW_SOURCE_PATH}
  bin
  prom
  passive
  mkdir ${MW_FOLDER}
  cd ${MW_FOLDER}
  mput ${MW_FILE}
EOF

#rm -rf ${MW_SOURCE_PATH}/${MW_FILE}

#  fi
#fi
