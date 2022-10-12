ARCH_Ultra96 := aarch64
BSP_Ultra96 := sensors96b_v2.bsp
BITSTREAM_Ultra96 := sensors96b/sensors96b.bit
FPGA_MANAGER_Ultra96 := 1

# Note: for PYNQ v3.0 mraa & ump packages are out of date and deprecated (not installed)
STAGE4_PACKAGES_Ultra96 := pynq usbgadget usb-eth0 pynq_selftest
STAGE4_PACKAGES_Ultra96 += xrt sensorconf-v2 python_pmbus wilc3000
