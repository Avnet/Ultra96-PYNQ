#!/bin/bash

set -e
set -x

target=$1
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo mkdir $target/root/mraa_build
sudo cp $script_dir/ultra96.patch $target/root/mraa_build

