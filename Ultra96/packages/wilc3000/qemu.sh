#! /bin/bash

set -x
set -e

cd /wilc_bld

# Install firmware files on root filesystem
git clone https://github.com/linux4wilc/firmware
cd firmware
git checkout tags/wilc_linux_15_2
cp /wilc_bld/firmware/wilc3000_wifi_firmware.bin /lib/firmware/mchp/
cp /wilc_bld/firmware/wilc3000_ble_firmware.bin /lib/firmware/mchp/

cd /
rm -rf wilc_bld

# Register wifi driver (depmod doesn't work here)
# depmod -a

# Start module on bootup
echo "wilc-sdio" >> /etc/modules

# Wilc cannot do wlan1 only wlan0 and p2p0, so fix that for host ap
echo "INTERFACES=\"usb0 p2p0\"" > /etc/default/isc-dhcp-server
cp /usr/local/share/wpa_ap/ap.sh /usr/local/share/wpa_ap/ap_v1.sh
cp /usr/local/share/wpa_ap/ap_v2.sh /usr/local/share/wpa_ap/ap.sh
chmod a+x /usr/local/share/wpa_ap/ap.sh

