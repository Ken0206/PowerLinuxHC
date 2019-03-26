#!/bin/bash
#
#Description: Power Linux health check, download new shell script files
#Write by Ken (kenpeng@tiis.com.tw)
#Version: v1.00

# get all files
[ -d /root/mw/powerLinux ] || mkdir -p /root/mw/powerLinux
[ -f /root/mw/test ] && ftpServer='192.168.188.71' || ftpServer='192.168.100.145'

ftp -n << EOF
  open ${ftpServer}
  user ftpmrtg 900mrtg2100
  lcd /root/mw
  cd /PowerLinuxHC
  bin
  prom
  mget *.sh
  lcd /root/mw/powerLinux
  cd /PowerLinuxHC/powerLinux
  mget *
EOF

chmod +x /root/mw/call_hc_powerLinux.sh
chmod +x /root/mw/powerLinuxHC.sh
