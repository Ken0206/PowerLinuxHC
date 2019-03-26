#!/bin/bash
#
#Description: MW health check
#Write by Ken (kenpeng@tiis.com.tw)
#Version: v1.00

[ -d /var/monitor_disk ] || mkdir -p /var/monitor_disk
cp mw_hc_ftp.sh /var/monitor_disk/
chmod +x /var/monitor_disk/mw_hc_ftp.sh
cp mw_hc.sh /root/mw/
chmod +x /root/mw/mw_hc.sh


