SRC_URI_append = " \
        file://0001-zynqmp_pmufw-Add-support-for-Ultra96-power-button.patch \
        "
 
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

YAML_COMPILER_FLAGS_append_ultra96-zynqmp = " -DBOARD_SHUTDOWN_PIN=2 -DBOARD_SHUTDOWN_PIN_STATE=0 -DENABLE_MOD_ULTRA96 -DENABLE_SCHEDULER"
 
EXTERNALXSCTSRC = ""
EXTERNALXSCTSRC_BUILD = ""
