#!/bin/sh

modprobe ip_set_hash_ip
sleep 5
modprobe ebt_mark
sleep 5
modprobe xt_set
sleep 5
ipset create ipaddrs hash:ip
sh /mnt/systo1/scripts/routing/addIPsets.sh
iptables -A PREROUTING -t mangle -m set --match-set ipaddrs dst -j MARK --set-xmark 0x1/0xffffffff
ip route add default dev wg0 table 100
ip rule add table 100 fwmark 0x1 prio 100
echo 2 > /proc/sys/net/ipv4/conf/wg0/rp_filter
