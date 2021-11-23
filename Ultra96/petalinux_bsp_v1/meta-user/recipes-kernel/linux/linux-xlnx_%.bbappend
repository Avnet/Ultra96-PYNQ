SRC_URI += "file://bsp.cfg"
SRC_URI_append += " file://0001-Revert-Bluetooth-hci_ll-set-operational-frequency-ea.patch"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
