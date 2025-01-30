ip rule del table 100 fwmark 0x1 prio 100
ip route del default dev wg0 table 100
ip route del 10.0.0.0/24 dev wg0
iptables -D PREROUTING -t mangle -m set --match-set ipaddrs dst -j MARK --set-xmark 0x1/0xffffffff
iptables -D POSTROUTING -t nat -o wg0 -j MASQUERADE
ip link delete dev wg0
