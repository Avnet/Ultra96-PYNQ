#! /bin/bash

set -x
set -e

cd /root/upm_build

wget https://github.com/intel-iot-devkit/upm/archive/v1.3.0.zip
unzip -a v1.3.0.zip
cd upm-1.3.0
cp -rf /root/upm_build/v1.3.0.patch .
patch -p1 < v1.3.0.patch

mkdir build
cd build
PKG_CONFIG_PATH=/opt/mraa/lib/pkgconfig cmake -DBUILDSWIGNODE=OFF -DPYTHON3_EXECUTABLE=/usr/bin/python3.6m -DCMAKE_INSTALL_PREFIX=/opt/upm -DPYTHON3_PACKAGES_PATH=/usr/local/lib/python3.6/dist-packages ..
make -j 4
make install
echo /opt/upm/lib > /etc/ld.so.conf.d/upm.conf
ldconfig

cd /root
rm -rf upm_build
