#! /bin/bash

set -x
set -e

cd /root/upm_build

wget https://github.com/intel-iot-devkit/upm/archive/v1.7.1.zip
unzip -a v1.7.1.zip
cd upm-1.7.1
patch CMakeLists.txt < ../CMakeLists.txt.patch 


mkdir build
cd build
cmake \
    -DBUILDSWIGNODE=OFF \
    -DPYTHON3_LIBRARY:FILEPATH=/usr/lib/aarch64-linux-gnu/libpython3.8.so \
    -DPYTHON3_EXECUTABLE=/usr/bin/python3.8 \
    -DCMAKE_INSTALL_PREFIX=/opt/upm \
    -DPYTHON3_PACKAGES_PATH=/usr/local/lib/python3.8/dist-packages \
    ..
make -j 4
make install
echo /opt/upm/lib > /etc/ld.so.conf.d/upm.conf
ldconfig

# https://github.com/eclipse/upm/issues/682 
cp src/*/python3.8/*.py /usr/local/lib/python3.8/dist-packages/upm
cp src/interfaces/python3.8/*.py /usr/local/lib/python3.8/dist-packages/upm


cd /root
rm -rf upm_build
