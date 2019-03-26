#!/bin/bash
#
#Description: Power Linux health check, redownload main shell script and run
#Write by Ken (kenpeng@tiis.com.tw)
#Version: v1.00

# get new version powerLinuxHC.sh
[ -f /root/mw/test ] && ftpServer='192.168.188.71' || ftpServer='192.168.100.145'

ftp -n << EOF
  open ${ftpServer}
  user ftpmrtg 900mrtg2100
  lcd /root/mw
  cd /PowerLinuxHC
  bin
  prom
  get powerLinuxHC.sh
EOF

# run main HC shell script
chmod +x /root/mw/powerLinuxHC.sh
/root/mw/powerLinuxHC.sh 2> powerLinuxHC.log
