#!/bin/sh

# ATTENTION! wg show doesn't display connect status on router

modprobe wireguard
sleep 5
ip link add dev wg0 type wireguard
ip address add dev wg0 10.0.0.1/24
wg setconf wg0 /mnt/systo1/wireguard/wg0.conf
sleep 20

max_attempts=10
attempts=0

while [ $attempts -lt $max_attempts ] && [ "$(ip addr | grep wg0 | cut -d ' ' -f 3 | head -n 1)" != "<POINTOPOINT,NOARP,UP,LOWER_UP>" ]; do
  nping --udp --count 1 -data-length 16 --source-port sPORT --dest-port dPORT IPADDRESS
  ip link set up dev wg0 > /dev/null
  sleep 5
  attempts=$((attempts + 1))
done

if [ $attempts -lt $max_attempts ]; then

  iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE

  else echo "Failed to bring up interface after $max_attempts attempts"
fi
