#!/bin/bash

set -e
set -x

# Install firmware files on root filesystem
cd /wilc_bld
git clone https://github.com/linux4wilc/firmware
cd firmware
git checkout tags/wilc_linux_15_2
cp /wilc_bld/firmware/wilc3000_wifi_firmware.bin /lib/firmware/mchp/
cp /wilc_bld/firmware/wilc3000_ble_firmware.bin /lib/firmware/mchp/
cd /
rm -rf wilc_bld

# Start module on bootup
echo "wilc-sdio" >> /etc/modules

# Wilc cannot do wlan1 only wlan0 and p2p0, so fix that for host ap
chmod a+x /usr/local/share/wpa_ap/ap.sh
if [ -f /etc/default/isc-dhcp-server ] && \
	grep -q "INTERFACES=" /etc/default/isc-dhcp-server; then
	if ! grep -q "p2p0" /etc/default/isc-dhcp-server; then
		sed -i 's/\(INTERFACES=\)"\(.*\)"/\1"\2 p2p0"/g' \
		/etc/default/isc-dhcp-server
	fi
else
	echo 'INTERFACES="p2p0"' > /etc/default/isc-dhcp-server
fi

cat - >> /etc/dhcp/dhcpd.conf <<EOT

subnet 192.168.2.0 netmask 255.255.255.0 {
   option subnet-mask 255.255.255.0;
   option broadcast-address 192.168.2.0;
   range 192.168.2.2 192.168.2.100;
}
EOT

cat - > /etc/network/interfaces.d/wlan0 <<EOT
iface wlan0 inet dhcp
	wireless_mode managed
	wireless_essid any
	wpa-driver wext
	wpa-conf /etc/wpa_supplicant.conf
EOT

# Uncomment the following line to enable wireless access point by default
# systemctl enable wpa_ap.service
