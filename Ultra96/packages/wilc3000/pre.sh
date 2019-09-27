#! /bin/bash

target=$1
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo cp $script_dir/wpa_ap.service $target/lib/systemd/system
sudo cp -r $script_dir/wpa_ap $target/usr/local/share/
sudo mkdir $target/wilc_bld
sudo mkdir -p $target/lib/firmware/mchp
cd $BUILD_ROOT/${PYNQ_BOARD}/petalinux_project
petalinux-build -c wilc
sudo mkdir -p $target/lib/modules/4.19.0-xilinx-v2019.1/extra
sudo cp -rf build/tmp/sysroots-components/*/wilc/lib/modules/4.19.0-xilinx-v2019.1/extra/wilc-sdio.ko $target/lib/modules/4.19.0-xilinx-v2019.1/extra/
