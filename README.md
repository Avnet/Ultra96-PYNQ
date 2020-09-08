![alt tag](./ultra96-pynq.png)\
![alt tag](./ultra96_v2-pynq.png)
![alt tag](./software.png)

## Grab the pre-built SD images

Click the releases tab above or [click here to obtain SD card images and instructions for Ultra96 v1 or v2](https://github.com/Avnet/Ultra96-PYNQ/releases)

## Xilinx Vitis AI hardware accelerated inference for PYNQ >= v2.5

Supports Ultra96 v1 and v2, ZCU104 and ZCU111, [click here for how to get started!](https://www.hackster.io/wadulisi/easy-ai-with-python-and-pynq-dd4822)

![alt tag](./pynq-dpu.jpeg)

## Build your own PYNQ SD image for Ultra96 v1/v2

This is optional for advanced users if they want to rebuild their own U96 PYNQ images.

This repository contains source files and instructions for building PYNQ to run on the [Ultra96 board](http://zedboard.org/product/ultra96-v2-development-board).

Building PYNQ for Ultra96 can take many hours to complete.  Plan accordingly!

**Required tools:**

* Ubuntu 16.04 LTS 64-bit host PC
* Passwordless SUDO privilege for the building user
* At least 160GB of free hard disk space if you do not have the Xilinx tools installed yet
* Roughly 80GB of free hard drive space if you have the Xilinx tools installed
* You may be able to work with less free hard drive space, YMMV
* At least 8GB of RAM (more is better)
* Xilinx Petalinux and Vivado or SDx (find the version compatible with a specific PYNQ release at
[Xilinx Tool Version](https://pynq.readthedocs.io/en/latest/pynq_sd_card.html))
* Read Xilinx UG1144 for Petalinux host PC setup requirements
* [Create a Xilinx account](https://www.xilinx.com/registration/create-account.html) to obtain and license the tools

### Step 1: Clone and configure the Ultra96 repository

Retrieve the Ultra96 PYNQ board git into a new directory somewhere outside the PYNQ git directory.
You can define the path to this new directory as shown (adjust this path if you like).

```shell
export LOCAL_ULTRA96=$(pwd)/ultra96-pynq-git
```

Then clone the repository and setup Ultra96-PYNQ git to work on a branch (for example, `image_v2.6.0`).

```shell
git clone https://github.com/Avnet/Ultra96-PYNQ.git $LOCAL_ULTRA96
cd $LOCAL_ULTRA96
git checkout -b image_v2.6.0 origin/image_v2.6.0
```

Pre-built Ultra96 v1 and v2 BSPs and overlays for the current release are included under the [GitHub Release File Assets](https://github.com/Avnet/Ultra96-PYNQ/releases).

Alternatively, if you would like to start with your own or a new BSP [see notes at bottom](#build-pynq-compatible-bsps-from-scratch).
When you prepare the new BSP by yourself, the overlay files will be prepared as well.

**IMPORTANT: place the v1 (sensors96b_v1.bsp) or v2 (sensors96b_v2.bsp) BSP in the `$LOCAL_ULTRA96/Ultra96` folder.**

**IMPORTANT: place the v1 (sensors96b.bit, sensors96b.hwh) or v2 (sensors96b.bit, sensors96b.hwh) overlay files in the `$LOCAL_ULTRA96/Ultra96/sensors96b` folder.**

Next you must setup soft links depending upon whether you are using Ultra96 v1 or v2.

For Ultra96 v1:

```shell
cd $LOCAL_ULTRA96/Ultra96
ln -s specs/Ultra96_v1.spec Ultra96.spec
ln -s petalinux_bsp_v1 petalinux_bsp
```

For Ultra96 v2:

```shell
cd $LOCAL_ULTRA96/Ultra96
ln -s specs/Ultra96_v2.spec Ultra96.spec
ln -s petalinux_bsp_v2 petalinux_bsp
```

### Step 2: Setup the PYNQ repository and building environment

Retrieve the main PYNQ repo into a new directory somewhere outside the Ultra96-PYNQ directory.
You can define the path to this new directoy (adjust this path if you like).

```shell
export LOCAL_PYNQ=$(pwd)/pynq-git
```

Clone and setup PYNQ git to work on a branch (for example, `image_v2.6.0`).

```shell
git clone https://github.com/Xilinx/PYNQ.git $LOCAL_PYNQ
cd $LOCAL_PYNQ
git checkout origin/image_v2.6.0
```

Configure and install build tools, this will take some effort and will be an iterative process. Run `setup_host.sh` to install missing tools, `make checkenv` to check if all tools are installed.

```shell
cd sdbuild
./scripts/setup_host.sh
make checkenv
```

### Step 3: Build PYNQ image

In your local PYNQ repository while still in the sub directory `sdbuild`, run make.

**IMPORTANT: For the BOARDDIR path setting it should be absolute not relative, you have been warned!**

```shell
make clean
make BOARDDIR=$LOCAL_ULTRA96
```

Once the build has completed (it will take a long long time), if successful an SD card image will be available under the PYNQ git directory `sdbuild/output`. Depending on the PYNQ release, the image may have different names. As an example, for PYNQ v2.6, the image is `Ultra96-2.6.img`.

Use Etcher or Win32DiskImager to write this image to an SD card.

Insert card, PYNQ should boot up on the Ultra96!

For more information about how to setup and use PYNQ for Ultra96, please refer to the [online documentation](https://ultra96-pynq.readthedocs.io/en/latest/).

## Build PYNQ-compatible BSPs from scratch

**Notes: Pre-built 2020.1 PetaLinux BSPs can be found under the GitHub v2.6.0 Releases Asset Files. If you optionally use these, you would skip the steps below to create and configure the BSPs from scratch and copy the prebuilt BSP to the location of where the build from scratch procedures creates them.**

To get started you must obtain and install Xilinx Vitis or Vivado and Petalinux on Ubuntu 16.04 LTS. For Xilinx tools, you will need a version compatible with the PYNQ release (for Xilinx tool compatibility, see [Xilinx Tool Version](https://pynq.readthedocs.io/en/latest/pynq_sd_card.html)). If you are installing the Xilinx tools for the first time on your existing setup you must read Xilinx UG1144 for Petalinux setup requirements.

If you prefer, you can also setup all the tools on a VirtualBox VM (e.g. using [Vagrant software](https://pynq.readthedocs.io/en/latest/pynq_sd_card.html#prepare-the-building-environment)).

### Step 1: Hardware design

Use the Xilinx Vivado tools to generate the hardware design. The hardware design source files contain a PL (Xilinx Programmable Logic) design sensors96b that enables U96 PYNQ to interact with a Grove mezzanine board. The hardware design also contains Ultra96 board specific settings. After building the hardware design, it will need to be manually imported into the Petalinux BSP.

To build the hardware design for Ultra96 v1:

```shell
cd $LOCAL_ULTRA96/Ultra96/sensors96b
cp -f sensors96b.tcl.v1 sensors96b.tcl
make
```

To build the hardware design for Ultra96 v2:

```shell
cd $LOCAL_ULTRA96/Ultra96/sensors96b
cp -f sensors96b.tcl.v2 sensors96b.tcl
make
```

### Step 2: Create and configure BSP

After the hardware design has finished building and you have installed Petalinux,
create the Ultra96 BSP by executing:

```shell
cd $LOCAL_ULTRA96
mkdir bsp
cd bsp
petalinux-create -t project -n sensors96b --template zynqMP
cd sensors96b
petalinux-config --get-hw-description=../../Ultra96/sensors96b
```

After the system config menus appear you need to set the following case-sensitive values, after completion exit and save:

* Subsystem AUTO Hardware Settings → Serial Settings → PMUFW serial stdin/stdout → (psu_uart_1)
* Subsystem AUTO Hardware Settings → Serial Settings → FSBL serial stdin/stdout → (psu_uart_1)
* Subsystem AUTO Hardware Settings → Serial Settings → ATF serial stdin/stdout → (psu_uart_1)
* Subsystem AUTO Hardware Settings → Serial Settings → DTG serial stdin/stdout → (psu_uart_1)
* DTG Settings → MACHINE_NAME → (avnet-ultra96-rev1)
* u-boot Configuration → u-boot config → (other)  (Note: "other" is the default setting, leave it this way!)
* u-boot Configuration → u-boot config target → set this to nothing, delete default and make it blank!
* Image Packaging Configuration → Root filesystem type → (EXT4 (SD/eMMC/SATA/USB))
* Yocto Settings → YOCTO_MACHINE_NAME → (ultra96-zynqmp)

To work around a potential bug for Ultra96 that prevents including your own hardware design you must edit:  
`$LOCAL_ULTRA96/bsp/sensors96b/project-spec/meta-user/conf/petalinuxbsp.conf`.  

Add the following line at the bottom of the file:

```shell
MACHINE_FEATURES_remove_ultra96-zynqmp = "mipi"
```

For Ultra96 v2 you may want to remove the TI WiFi driver module. To do this:

```shell
petalinux-config -c kernel
```

Locate the following configuration:

* Device Drivers → Network device support → Wireless LAN → Texas Instrument devices

Deselect it (type 'N') and exit, exit, exit. 
When asked, save the configuration using the default name and exit.

### Step 3: Package BSP

Finish creating the BSP by packaging it up into a single BSP file and placing it for PYNQ to find.

For Ultra96 v1:

```shell
cd $LOCAL_ULTRA96/bsp
petalinux-package --bsp --force -p sensors96b --hwsource ../Ultra96/sensors96b/sensors96b --output ../Ultra96/sensors96b_v1.bsp
```

For Ultra96 v2:

```shell
cd $LOCAL_ULTRA96/bsp
petalinux-package --bsp --force -p sensors96b --hwsource ../Ultra96/sensors96b/sensors96b --output ../Ultra96/sensors96b_v2.bsp
```

Note: The PYNQ packages scripts and extra files will also pull in and override some settings for any bsp automatically.  For example the v2 Microchip wifi driver.
