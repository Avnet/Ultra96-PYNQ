SRC_URI += "file://bsp.cfg"
# Original patch is mostly now in distributed driver code
#SRC_URI:append += " file://0001-Revert-Bluetooth-hci_ll-set-operational-frequency-ea.patch"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
