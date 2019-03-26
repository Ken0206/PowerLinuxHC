#!/bin/bash
#
#Description: Power Linux health check, upload new shell script files
#Write by Ken (kenpeng@tiis.com.tw)
#Version: v1.00

[ -f /root/mw/test ] && ftpServer='192.168.188.71' || ftpServer='192.168.100.145'

ftp -n << EOF
  open ${ftpServer} 
  user ftpmrtg 900mrtg2100
  lcd /tmp/PowerLinuxHC
  cd /PowerLinuxHC
  bin
  prom
  mput *.sh
  lcd /tmp/PowerLinuxHC/powerLinux
  cd /PowerLinuxHC/powerLinux
  mput *
EOF
