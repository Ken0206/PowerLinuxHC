#!/bin/bash
#
# Description: Power Linux health check main HC shell script. 
# sysstat , device-mapper-multipath , LVM

# prepare work directory
readonly Outfiles=PowerLinux.$(hostname).$(date +%Y%m%d).tar.gz
readonly WORKDIR=/usrtmp/ahc/PowerLinux_$(hostname)
rm -rf ${WORKDIR}
mkdir -p ${WORKDIR}
cd ${WORKDIR}
echo 'v20180326' > PowerLinux_HC_v

# Collect data
echo $PATH > PATH
/usr/sbin/multipathd show config > multipathd_show_config
/usr/sbin/multipathd show paths > multipathd_show_paths
/usr/sbin/multipathd show maps >  multipathd_show_maps
/usr/sbin/multipath -ll > multipath_ll
/usr/sbin/multipath -v3 > multipath_v3
cp /etc/multipath.conf .   
systemctl status multipathd > systemctl_status_multipathd
cp /etc/redhat-release .
uname -a > uname_a  
df -h | grep -E "rootvg-root|rootvg-var|rootvg-tmp" > df_h
free -m > free_m
grep -E "error|fail" /var/log/messages > error_messages
/usr/sbin/getenforce > getenforce
/usr/sbin/ifconfig > ifconfig
/usr/sbin/ifstat > ifstat
uptime > uptime
vmstat > vmstat
iostat > iostat
mpstat > mpstat
pidstat > pidstat
lscpu > lscpu
w > w
crontab -l > crontab_l
mount > mount
cp /etc/fstab .
cp /etc/crontab .
cp /proc/cpuinfo .
cp /proc/loadavg .
cp /proc/meminfo .
cp /proc/partitions .
cp /proc/swaps .
cp /proc/version .
cp /root/mw/mw_hc.log .

# packing compressed data, clean up temporary data
cd ..
tar -czf ${Outfiles} ${WORKDIR} 2> /dev/null
chmod o+r ${Outfiles}
rm -rf ${WORKDIR}

exit 0
