#!/bin/bash

if [ $# -ne 2 ]
then
  echo -e "\n\nPlease use :\n\tcheck fileName1 fileName2\n"
  exit 1
fi

if [ ! -f $1 ] || [ ! -f $2 ]
then
  echo -e "\n file \"$1\" or \"$2\" not exist!"
  exit 1
fi

chk1=${RANDOM}_temp
chk2=${RANDOM}_temp
tmp2=${RANDOM}_temp
outputf=o$(date +%H%M%S)_$1_$2.txt

tr '[:upper:]' '[:lower:]' < $1 | sort | uniq > ${chk1}
tr '[:upper:]' '[:lower:]' < $2 | sort | uniq > ${chk2}

for i in $(cat ${chk2})
do
  grep -v ${i} ${chk1} > ${tmp2}
  rm -f ${chk1}
  mv ${tmp2} ${chk1}
done
echo >> ${outputf}
echo '"'$1'" have, in "'$2'" not have' >> ${outputf}
cat ${chk1} >> ${outputf}

echo -e "\n-------------------------------------------------\n"  >> ${outputf}

tr '[:upper:]' '[:lower:]' < $2 | sort | uniq > ${chk1}
tr '[:upper:]' '[:lower:]' < $1 | sort | uniq > ${chk2}

for i in $(cat ${chk2})
do
  grep -v ${i} ${chk1} > ${tmp2}
  rm -f ${chk1}
  mv ${tmp2} ${chk1}
done
echo '"'$2'" have, in "'$1'" not have' >> ${outputf}
cat ${chk1} >> ${outputf}

rm -f ${chk1} ${chk2} ${tmp2}
