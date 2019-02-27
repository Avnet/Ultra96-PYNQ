#! /bin/bash

set -x
set -e

# patch for SWIG: 
# https://github.com/intel-iot-devkit/mraa/blob/master/docs/building.md
cd /usr/share/swig3.0
wget https://git.yoctoproject.org/cgit.cgi/poky/plain/meta/recipes-devtools/swig/swig/0001-Add-Node-7.x-aka-V8-5.2-support.patch
patch -p2 < "0001-Add-Node-7.x-aka-V8-5.2-support.patch"

# patch for mraa 2.0.0
patch_file="/root/mraa_build/ultra96.patch"

cd /root/mraa_build
wget https://github.com/intel-iot-devkit/mraa/archive/v2.0.0.zip
unzip -a v2.0.0.zip
cd mraa-2.0.0
patch -p1 < $patch_file

mkdir build
cd build
cmake -DPYTHON3_EXECUTABLE=/usr/bin/python3.6m -DCMAKE_INSTALL_PREFIX=/opt/mraa -DPYTHON3_LIBRARY=/usr/lib/python3.6/config-3.6m-aarch64-linux-gnu/ -DPYTHON3_INCLUDE_DIR=/usr/include/python3.6m  -DPYTHON3_PACKAGES_PATH=/usr/local/lib/python3.6/dist-packages ..
cmake -DPYTHON3_EXECUTABLE=/usr/bin/python3.6m -DCMAKE_INSTALL_PREFIX=/opt/mraa -DPYTHON3_LIBRARY=/usr/lib/python3.6/config-3.6m-aarch64-linux-gnu/ -DPYTHON3_INCLUDE_DIR=/usr/include/python3.6m  -DPYTHON3_PACKAGES_PATH=/usr/local/lib/python3.6/dist-packages ..
make -j 4
make install
echo /opt/mraa/lib > /etc/ld.so.conf.d/mraa.conf
echo 'export PATH=/opt/mraa/bin:$PATH' > /etc/profile.d/mraa.sh
ldconfig

cd /root
rm -rf mraa_build
