#!/bin/bash
################################################################################
#
# The following script should work if you have petalinux 2020.2 and Vivado
# 2020.2 in the path.  A few very common utilities are also used.  This will
# build PYNQ v2.7 for U96 v1 or v2
#
# Adjust file names and paths of shell variables if needed.
#
################################################################################

if [ "$#" -eq 1 ]; then
	if [ "$1" -eq 1 ]; then
		BOARD_TYPE=Ultra96v1
	else
		BOARD_TYPE=Ultra96v2
	fi
else
	echo "Usage: build96 <1 or 2>"
	echo "   1 -> build Ultra96v1 PYNQ"
	echo "   2 -> build Ultra96v2 PYNQ"
	exit -1
fi
	
##################################
# Various path and file settings #
##################################

START_DIR=$PWD
MAIN_DIR="$START_DIR/Ultra96"
PYNQ_GIT_LOCAL_PATH="$START_DIR/PYNQ-git"
SD_IMAGE_FILE="$START_DIR/$BOARD_TYPE-2.7.0.img"
PYNQ_IMAGE_FILE="$PYNQ_GIT_LOCAL_PATH/sdbuild/output/Ultra96-2.7.0.img"
PYNQ_GIT_TAG=v2.7.0
PYNQ_GIT_REPO_URL=https://github.com/Xilinx/PYNQ
ULTRA96_BOARDDIR=$START_DIR
SPEC_DIR=specs
SPEC_NAME=Ultra96.spec
OVERLAY_FILE_PATH="$MAIN_DIR/sensors96b"
OVERLAY_NAME=sensors96b
OVERLAY_SEMA_NAME="_""$BOARD_TYPE""_"
BSP_FILE_PATH=$MAIN_DIR
BSP_FILE_URL=https://github.com/Avnet/Ultra96-PYNQ/releases/download/v2.7.0
ROOTFS_TMP_DIR=rootfs_tmp
ROOTFS_ZIP_FILE=focal.aarch64.2.7.0_2021_11_17.tar.gz
ROOTFS_IMAGE_FILE=focal.aarch64.2.7.0_2021_11_17.tar
ROOTFS_IMAGE_FILE_URL=https://www.xilinx.com/bin/public/openDownload?filename=focal.aarch64.2.7.0_2021_11_17.tar.gz

##################################
# Fetching and compiling         #
##################################
echo "Status: building from location: $START_DIR"
echo "Status: creating dir "$ROOTFS_TMP_DIR" to store rootfs tarball"
mkdir -p $ROOTFS_TMP_DIR

# Board specific settings
rm -f "$MAIN_DIR/petalinux_bsp"
rm -f "$OVERLAY_FILE_PATH/sensors96b.tcl"
rm -f "$MAIN_DIR/$SPEC_NAME"
if [ $BOARD_TYPE = "Ultra96v2" ]; then
	BSP_FILE=sensors96b_v2.bsp
	ln -s $SPEC_DIR/Ultra96_v2.spec $MAIN_DIR/$SPEC_NAME
	ln -s petalinux_bsp_v2 $MAIN_DIR/petalinux_bsp
	if ! [ -f "$OVERLAY_FILE_PATH/$OVERLAY_SEMA_NAME" ]; then
		rm -f $OVERLAY_FILE_PATH/$OVERLAY_NAME.bit
		rm -f $OVERLAY_FILE_PATH/$OVERLAY_NAME.hwh
		rm -f $OVERLAY_FILE_PATH/$OVERLAY_NAME.xsa
		rm -f $OVERLAY_FILE_PATH/_Ultra96v1_
		echo "Status: Removing U96 v1 $OVERLAY_NAME bitstream"
	fi
	cp -f "$OVERLAY_FILE_PATH/sensors96b.tcl.v2" "$OVERLAY_FILE_PATH/sensors96b.tcl"
else
	BSP_FILE=sensors96b_v1.bsp
	ln -s $SPEC_DIR/Ultra96_v1.spec $MAIN_DIR/$SPEC_NAME
	ln -s petalinux_bsp_v1 $MAIN_DIR/petalinux_bsp
	if ! [ -f "$OVERLAY_FILE_PATH/$OVERLAY_SEMA_NAME" ]; then
		rm -f $OVERLAY_FILE_PATH/$OVERLAY_NAME.bit
		rm -f $OVERLAY_FILE_PATH/$OVERLAY_NAME.hwh
		rm -f $OVERLAY_FILE_PATH/$OVERLAY_NAME.xsa
		rm -f $OVERLAY_FILE_PATH/_Ultra96v2_
		echo "Status: Removing U96 v2 $OVERLAY_NAME bitstream"
	fi
	cp -f "$OVERLAY_FILE_PATH/sensors96b.tcl.v1" "$OVERLAY_FILE_PATH/sensors96b.tcl"
fi

if [ -d "$PYNQ_GIT_LOCAL_PATH" ]; then
	echo "Status: PYNQ repo -> already cloned $PYNQ_GIT_LOCAL_PATH"
else
	echo "Status: Fetching PYNQ git $PYNQ_GIT_LOCAL_PATH"
	git clone --branch $PYNQ_GIT_TAG $PYNQ_GIT_REPO_URL $PYNQ_GIT_LOCAL_PATH --single-branch
	echo "Status: PYNQ repo cloned tag: $PYNQ_GIT_TAG"
fi

if [ -d "$PYNQ_GIT_LOCAL_PATH/boards/Pynq-Z1" ]; then
	echo "Status: Removing boards to speed up build time and eliminate needing hdmi license"
	cd $PYNQ_GIT_LOCAL_PATH
	echo "" > build.sh
	# The changes must be committed because PYNQ clones local when it builds
	git commit -am 'remove boards'
	echo "Status: Removed other boards"
	cd $START_DIR
else
	echo "Status: Unused board dirs -> removed prior"
fi

if [ -f "$ROOTFS_TMP_DIR/$ROOTFS_IMAGE_FILE" ]; then 
	echo "Status: Image file $ROOTFS_TMP_DIR/$ROOTFS_IMAGE_FILE -> already exists"
else
	echo "Status: Fetching pre-built rootfs"
	if [ -f "$ROOTFS_TMP_DIR/$ROOTFS_ZIP_FILE" ]; then
		echo "Status: zip file -> already exists"
	else
		wget "$ROOTFS_IMAGE_FILE_URL" -O "$ROOTFS_TMP_DIR/$ROOTFS_ZIP_FILE"
	fi
	if [ -s $ROOTFS_TMP_DIR/$ROOTFS_ZIP_FILE ]; then
		gzip -d "$ROOTFS_TMP_DIR/$ROOTFS_ZIP_FILE" 
		echo "Status: rootfs unzipped"
	else
		rm "$ROOTFS_TMP_DIR/$ROOTFS_ZIP_FILE"
		echo "Error: Failed to fetch rootfs zip file!"
		exit -1
	fi
fi

if [ -f "$BSP_FILE_PATH/$BSP_FILE" ]; then 
	echo "Status: $BSP_FILE -> already exists"
else
	echo "Status: Fetching pre-built BSP"
	wget "$BSP_FILE_URL/$BSP_FILE" -O "$BSP_FILE_PATH/$BSP_FILE"
	if ! [ -s "$BSP_FILE_PATH/$BSP_FILE" ]; then
		rm "$BSP_FILE_PATH/$BSP_FILE"
		echo "Error: Failed to fetch bsp file!"
		exit -1
	fi
fi

if [ -f "$OVERLAY_FILE_PATH/$OVERLAY_NAME.bit" -a -f "$OVERLAY_FILE_PATH/$OVERLAY_NAME.hwh" ] ; then
	echo "Status: $OVERLAY_NAME -> .bit and .hwh already exists"
else
	echo "Status: Building default $OVERLAY_NAME Overlay"
	cd "$OVERLAY_FILE_PATH"
	make clean
	make
	if [ -f "$OVERLAY_NAME.bit" -a -f "$OVERLAY_NAME.hwh" ]; then
	touch "$OVERLAY_FILE_PATH/$OVERLAY_SEMA_NAME"
		echo "Status: Overlay build SUCCESS but did not verify timing, manually check build log!"
	else
		echo "Status: Overlay build FAILURE"
		exit -1
	fi
fi

cd "$PYNQ_GIT_LOCAL_PATH/sdbuild"
sudo make clean
echo "Status: Building PYNQ SD Image & removed prior PYNQ build (if it existed)"
make PREBUILT="$START_DIR/$ROOTFS_TMP_DIR/$ROOTFS_IMAGE_FILE" BOARDDIR="$ULTRA96_BOARDDIR"

if [ -f "$PYNQ_IMAGE_FILE" ]; then
	mv -f "$PYNQ_IMAGE_FILE" "$SD_IMAGE_FILE"
	echo "Status: Done building PYNQ image: $SD_IMAGE_FILE"
else
	echo "Status: PYNQ build FAILED"
	exit -1
fi

exit 0
