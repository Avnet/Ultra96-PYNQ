## Ultra96 Board Files

This repository provides the board files for the 
[Ultra96 board](http://zedboard.org/product/ultra96).

## Quick Start

To use the board file along with the new sdbuild flow, first do:

```shell
git clone https://github.com/Avnet/Ultra96-PYNQ.git <LOCAL>
```

Then download the Ultra96 BSP from [Xilinx website](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html). Copy it over to your local folder.

```shell
cp -f <DOWNLOADED_BSP> <LOCAL>/Ultra96
```

Then in your PYNQ repository (image v2.3), go to folder `sdbuild` and do:

```shell
make BOARDDIR=<LOCAL>
```
