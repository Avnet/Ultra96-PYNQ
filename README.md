## Ultra96 Board Files

This repository provides the board files for the 
[Ultra96 board](http://zedboard.org/product/ultra96).

## Quick Start

To use the board file along with the new sdbuild flow, simply do:

```shell
git clone https://gitenterprise.xilinx.com/yunq/Ultra96.git <LOCAL>
```

Then in your PYNQ repository (image v2.3), go to folder `/sdbuild` and do:

```shell
make BOARDDIR=<LOCAL>
```
