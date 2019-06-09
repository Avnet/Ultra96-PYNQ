#!/bin/bash

set -e
set -x

target=$1
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo mkdir $target/wilc_bld
sudo mkdir -p $target/lib/firmware/mchp
sudo mkdir -p $target/lib/modules/4.14.0-xilinx-v2018.3/extra
sudo cp $script_dir/wilc-sdio.ko $target/lib/modules/4.14.0-xilinx-v2018.3/extra/

