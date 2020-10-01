SRC_URI += "file://bsp.cfg"
SRC_URI_append = " file://fix_u96v2_pwrseq_simple.patch"
SRC_URI_append = " file://0001-Revert-tty-xilinx_uartps-Fix-missing-id-assignment-t.patch"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
