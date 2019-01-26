## Build PYNQ v2.3 for Ultra96:
This repository contains source files and instructions for building PYNQ to run on the 
[Ultra96 board](http://zedboard.org/product/ultra96).
## Quick Start
**Building PYNQ for Ultra96 can take many hours to complete.  Plan accordingly!**\
\
**IMPORTANT: Building PYNQ requires passwordless SUDO privilege for the building user!**\
\
**Required tools:**
* Ubuntu 16.04 LTS 64-bit host PC
* At least 130GB of free hard disk space if you do not have the Xilinx tools installed yet
* Roughly 60GB of free hard drive space if you have the Xilinx tools installed
* You may be able to get away with less free hard drive space, YMMV
* At least 8GB of RAM (more is better)
* 2018.2 Xilinx Vivado or SDX and PetaLinux tools (Web-pack or full versions)
* A free Xilinx developer account to obtain and license the tools: https://www.xilinx.com/registration/create-account.html
* Note: If you purchase an Ultra96 board, a free voucher for the full-version Xilinx SDX tool suite and PetaLinux 2018.2 is included

**Retrieve the main PYNQ repo:**
```shell
git clone https://github.com/Xilinx/PYNQ.git <LOCAL PYNQ>
```
**Setup PYNQ git to use detached branch "image_v2.3":**
```shell
cd <LOCAL PYNQ>
git checkout origin/image_v2.3
```
**Configure and install build tools, this will take some effort and will be an iterative proces. You are on your own to install missing requested tools:**
```shell
cd sdbuild
make checkenv
```
**Retrieve the Ultra96 PYNQ board git in a NEW directory somewhere outside the PYNQ git directory:**
```shell
git clone https://github.com/Avnet/Ultra96-PYNQ.git <LOCAL ULTRA96>
```
**Setup Ultra96 PYNQ Board git to use detached branch "master":**
```shell
cd <LOCAL PYNQ>
git checkout origin/master
```
## Note: The best BSP to use at this time is xilinx-ultra96-reva-v2018.2-final.bsp  You may download it for free from a Xilinx developer account.
**Place the  file in the Ultra96 PYNQ Board repo:**
```
cp  <From download location>/xilinx-ultra96-reva-v2018.2-final.bsp  <LOCAL ULTRA96>/Ultra96/
```
**Go back to your PYNQ repository and go to the directory "sdbuild", run make:**\
**IMPORTANT: For the BOARDDIR path setting it should be absolute not relative, you have been warned!**
```shell
cd <LOCAL PYNQ>/sdbuild
make BOARDDIR=<LOCAL ULTRA96>
```
**Once the build has completed (it will take a long long time), if successful an SD card image will be available under the PYNQ git directory here: ./sdbuild/output/Ultra96_v2.3.img**
\
\
**Use Etcher or Win32DiskImager to write this image to an SD card.  Insert card, PYNQ should boot up on the Ultra96!**

**For more information about how to setup and use PYNQ for Ultra96:** https://ultra96-pynq.readthedocs.io/en/latest/
