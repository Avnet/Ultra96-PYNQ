## Build PYNQ v2.3 for Ultra96 using a fresh (or your own) PetaLinux BSP:
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
**Setup PYNQ git to work on branch "image_v2.3":**
```shell
cd <LOCAL PYNQ>
git checkout origin/image_v2.3
```
**Configure and install build tools, this will take some effort and will be an iterative proces. Install on your own MISSING requested tools:**
```shell
cd sdbuild
make checkenv
```
**Retrieve the Ultra96 PYNQ board git in a NEW directory somewhere outside the PYNQ git directory:**
```shell
git clone https://github.com/Avnet/Ultra96-PYNQ.git <LOCAL ULTRA96>
```
**Setup Ultra96 PYNQ board repo to work with the "image_v2.3" branch:**
```shell
cd <LOCAL ULTRA96>
git checkout origin/image_v2.3
```
## Note: If you already have a pre-made Ultra96 BSP that meets the requirements, you can skip creating one and skip to the next Note!

**Obtain and install Xilinx Vivado or SDx and PetaLinux v2018.2 on Ubuntu 16.04 LTS. If you are installing the Xilinx tools for the first time on your existing setup you must read Xilinx UG1144 for PetaLinux setup requirements.  If you prefer, you can also setup all the tools on a VirtualBox VM.  Follow Avnet's VM and Xilinx tools install instructions here:** (http TBD)
\
\
**Use the Xilinx SDx or Vivado tools to generate the hardware design.  The hardware design source files contain a PL (Xilinx Programmable Logic) design that will enable PYNQ to interact with a Grove or Click optional mezzanine board.  The hardware design also contains Ultra96 board specific settings.  After building the hardware design, it will be manually imported into the PetaLinux BSP to be used for PYNQ.  To build the hardware design that PetaLinux will boot up with:**
```shell
cd <LOCAL ULTRA96>/Ultra96/sensors96b
make
```
**After the hardware design has completed building and you have installed PetaLinux 2018.2 then create the Ultra96 BSP by executing PetaLinux cmds FROM the TOP DIRECTORY of the Ultra96 PYNQ board git. You may see a couple warnings after the -config, those are normal:**
```shell
cd <LOCAL ULTRA96>
mkdir bsp
cd bsp
petalinux-create -t project -n sensors96b --template zynqMP
cd sensors96b
petalinux-config --get-hw-description=../../Ultra96/sensors96b/sensors96b/sensors96b.sdk
```
**After the system config menus appear you need to set the following case-sensitive values, after completion exit and save:**
* Subsystem AUTO Hardware Settings → Serial Settings → Primary stdin/stdout → (psu_uart_1)
* DTG Settings → MACHINE_NAME → (zcu100-revc)
* u-boot Configuration → u-boot config target → (xilinx_zynqmp_zcu100_revC_defconfig)
* Image Packaging Configuration → Root filesystem type → (SD card)
* Yocto Settings → YOCTO_MACHINE_NAME → (ultra96-zynqmp)

**OPTIONAL: configure u-boot to decrease the boot delay:**
```shell
petalinux-config -c u-boot
```
*Optionally change "delay in seconds before automatically booting" default is 4 seconds then exit and save*\
\
**Finish creating the BSP by packaging it up into a single BSP file and placing it for PYNQ to find:**
```shell
cd <LOCAL ULTRA96>/bsp
petalinux-package --bsp -p sensors96b --hwsource ../../Ultra96/sensors96b/sensors96b --output ../../Ultra96/sensors96b.bsp
```
## Note: If you already have a proper BSP for Ultra96, the file and project name must match what is in Ultra96.spec.  Change one or the other accordingly. Place your BSP in the Ultra96 dir under the top dir of the location of the Ultra96 PYNQ board git, proceed from here to complete the build.

**Then in your PYNQ repository (branch: image_v2.3) go to the directory "sdbuild" and run make:**\
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
