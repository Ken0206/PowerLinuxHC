#!/bin/bash
#Description: Power Linux health check
#Write by Ken (kenpeng@tiis.com.tw)
#Date: 2017-10-31
#Version: v1.00

./check_messages.sh
./disk_usage.sh
./memory_info.sh
#./multipathd_status.sh
./selinux_mode.sh
./multipath_ll.sh