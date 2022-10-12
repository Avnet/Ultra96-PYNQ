SRC_URI += "file://bsp.cfg"
SRC_URI:append = " file://fix_u96v2_pwrseq_simple.patch"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
