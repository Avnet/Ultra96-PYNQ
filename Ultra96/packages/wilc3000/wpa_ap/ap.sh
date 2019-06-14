#!/bin/bash

# User can adjust wlan0 to connect to a specific wifi network
while ! ifconfig wlan0 up
do
  sleep 1
done

while ! ifconfig p2p0 up
do
  sleep 1
done

. /etc/environment
cd /usr/local/share/wpa_ap

# Create a new managed mode interface wlan1 to run AP
iw phy phy0 interface add p2p0 type managed

hid=$(ifconfig p2p0 | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}' | sed "s/:/_/g")
ip=192.168.2.1

sed "s/pynq/pynq_$hid/g" wpa_ap.conf > wpa_ap_actual.conf

ifconfig p2p0 down
sleep 2
wpa_supplicant -c ./wpa_ap_actual.conf  -ip2p0 &

ifconfig p2p0 $ip

