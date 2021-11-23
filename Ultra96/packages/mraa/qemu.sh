#! /bin/bash

set -x
set -e

cd /root/mraa_build
wget https://github.com/intel-iot-devkit/mraa/archive/v2.2.0.zip
unzip -a v2.2.0.zip
cd mraa-2.2.0
mkdir build
cd build
cmake -DPYTHON3_EXECUTABLE=/usr/bin/python3.8 \
    -DCMAKE_INSTALL_PREFIX=/opt/mraa \
    -DPYTHON3_LIBRARY=/usr/lib/python3.8/config-3.8m-aarch64-linux-gnu \
    -DPYTHON3_INCLUDE_DIR=/usr/include/python3.8 \
    -DPYTHON3_PACKAGES_PATH=/usr/local/lib/python3.8/dist-packages \
    ..
make -j 4
make install
echo /opt/mraa/lib > /etc/ld.so.conf.d/mraa.conf
echo 'export PATH=/opt/mraa/bin:$PATH' > /etc/profile.d/mraa.sh
ldconfig

cd /root
rm -rf mraa_build
