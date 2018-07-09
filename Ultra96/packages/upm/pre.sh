#!/bin/bash

set -e
set -x

target=$1
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo mkdir $target/root/upm_build
sudo cp $script_dir/v1.3.0.patch $target/root/upm_build
