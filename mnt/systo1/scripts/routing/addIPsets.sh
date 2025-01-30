#!/bin/sh

source /mnt/systo1/scripts/routing/vars.sh

mysql -u $routing_db_user -p$routing_db_pass -D $routing_db -Ns -e "SELECT DISTINCT INET_NTOA(ip) FROM ip_list;" | while read line
do
  ipset -exist add ipaddrs $line
done
# Manully added addresses
ipset -exist add ipaddrs 1.1.1.1
ipset -exist add ipaddrs 2.2.2.2
