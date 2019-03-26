#!/bin/bash
# 排除名單 exclude，同一機器有數行資料不適用，如︰disk_usage.sh
# date 2019-01-14

if [ $# -ne 1 ]
then
  echo -e "\n\nPlease use :\n\n\t./filter fileName\n"
  exit 1
fi

if [ ! -f ${0%/*}/exclude ] ; then
  echo -e "${0%/*}/exclude not found!"
  exit 1
fi

if [ ! -f $1 ] ; then
  echo -e "\n file \"$1\" not found!"
  exit 1
fi

chk1=$1_$(date +%H%M%S).txt
cp $1 ${chk1}

for i in $(cat exclude)
do
  sed -i "/${i}/d" ${chk1}
done

# 刪除空行
#sed -i "/^$/d" ${chk1} 
