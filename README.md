![alt tag](./ultra96-pynq.png)\
![alt tag](./ultra96_v2-pynq.png)
![alt tag](./software.png)

## Grab the pre-built SD images

Click the releases tab above or [click here to obtain SD card images and instructions for Ultra96 v1 or v2](https://github.com/Avnet/Ultra96-PYNQ/releases)

## Xilinx Vitis AI hardware accelerated inference for PYNQ >= v2.5

Built for Ultra96 v1/2 and also ZCU104 and ZCU111, [click here for how to get started!](https://www.hackster.io/wadulisi/easy-ai-with-python-and-pynq-dd4822)

![alt tag](./pynq-dpu.jpeg)

## Build your own PYNQ SD image for Ultra96 v1/v2

This is OPTIONAL for advanced users if they want to rebuild their own U96 PYNQ images.

This repository contains source files and instructions for building PYNQ to run on the [Ultra96 board](http://zedboard.org/product/ultra96-v2-development-board).

Building PYNQ for Ultra96 can take many hours to complete.  Plan accordingly!

**Required tools:**

* Ubuntu 16.04 or 18.04 LTS 64-bit host PC (sorry Ubuntu 20.04 LTS has issues with PetaLinux)
* Passwordless SUDO privilege for the building user
* At least 160GB of free hard disk space if you do not have the Xilinx tools installed yet
* Roughly 80GB of free hard drive space if you have the Xilinx tools installed
* You may be able to work with less free hard drive space, YMMV
* At least 8GB of RAM (more is better)
* Xilinx Petalinux, Vitis or Vivado v2020.2 tools
* Read Xilinx UG1144 for Petalinux host PC setup requirements
* [Create a Xilinx account](https://www.xilinx.com/registration/create-account.html) to obtain and license the tools

### Step 1: Setup the tools

Make sure you 'source' the settings64.sh and settings.sh scripts to add the PetaLinux and Vivado tools to the path 

### Step 2: One time PYNQ tools setup
* Clone PYNQ from https://github.com/Xilinx/PYNQ and checkout branch: image_v2.7
* cd into the clone and proper branch, then execute "./sdbuild/scripts/setup_host.sh"
* Install any requested additonal Debian apt packages that setup_host.sh asks for
* Once setup_host.sh is successful, reboot and re-login
* You may remove the just cloned PYNQ git repo, it is no longer needed

### Step 3: Clone the Ultra96 repository

Retrieve the Ultra96 PYNQ board git into a new directory somewhere outside the prior PYNQ git directory.

Clone the repository and setup Ultra96-PYNQ git to work on the `image_v2.7` branch.

```shell
git clone https://github.com/Avnet/Ultra96-PYNQ.git --branch image_v2.7
```

### Step 4: Build the SD image Ultra96

Execute a simple build script that will create an SD image for either Ultra96 v1 or v2.

For Ultra96 v2:
```shell
./buildu96 2
```
For Ultra96 v1:
```shell
./build96 1
```

The build script will first download a large rootfs file and appropriate bsp file. The downloads can take some time.
Once the files are downloaded, the script is smart enough to use what has already been downloaded.  The build itself
can easily take hours to complete.

### Step 5: Burn the SD image

Please use Balena Etcher or Win32 Disk Imager to copy the .img file onto an SD card 16GB or larger.
