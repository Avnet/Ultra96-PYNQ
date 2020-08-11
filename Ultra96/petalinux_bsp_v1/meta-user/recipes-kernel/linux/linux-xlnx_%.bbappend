SRC_URI += "file://bsp.cfg"
SRC_URI_append = " file://0001-Revert-tty-xilinx_uartps-Add-the-id-to-the-console.patch"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
