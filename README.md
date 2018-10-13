## Board Files for the Ultra96 platform for Xilinx PYNQ v2.3

This repository provides the board files for the 
[Ultra96 board](http://zedboard.org/product/ultra96).

## Quick Start

Retrieve the main PYNQ repo:

```shell
git clone https://github.com/Xilinx/PYNQ.git <LOCAL PYNQ>
```

Set PYNQ git for branch: image_v2.3:

```shell
cd <LOCAL PYNQ>
git checkout origin/image_v2.3
```

To use the Ultra96 board file along with the new sdbuild flow, first do:

```shell
git clone https://github.com/Avnet/Ultra96-PYNQ.git <LOCAL ULTRA96>
```

Then download the Ultra96 BSP from [Xilinx website](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html). Copy it over to your local folder.

```shell
cp -f <DOWNLOADED_BSP> <LOCAL ULTRA96>/Ultra96
```

Then in your PYNQ repository (branch: image_v2.3) go to the folder `sdbuild` and make:

```shell
cd <LOCAL PYNQ>/sdbuild
make BOARDDIR=<LOCAL ULTRA96>
```
