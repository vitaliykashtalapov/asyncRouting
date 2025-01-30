#!/bin/sh

iptables -t nat -D POSTROUTING -o wg0 -j MASQUERADE
iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE

iptables -D PREROUTING -t mangle -m set --match-set ipaddrs dst -j MARK --set-xmark 0x1/0xffffffff
iptables -A PREROUTING -t mangle -m set --match-set ipaddrs dst -j MARK --set-xmark 0x1/0xffffffff

echo 2 > /proc/sys/net/ipv4/conf/wg0/rp_filter
