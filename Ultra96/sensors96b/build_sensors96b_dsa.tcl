set overlay_name "sensors96b"
set design_name "sensors96b"

# open project and block design
open_project -quiet ./${overlay_name}/${overlay_name}.xpr
open_bd_design ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/${design_name}/${design_name}.bd

# set sdx platform properties
set_property PFM_NAME "xilinx.com:xd:${overlay_name}:2.0" \
        [get_files ./${overlay_name}/${overlay_name}.srcs/sources_1/bd/${design_name}/${design_name}.bd]
set_property PFM.CLOCK { \
    pl_clk0 {id "0" is_default "true" proc_sys_reset "proc_sys_reset_0" } \
    } [get_bd_cells /zynq_ultra_ps_e_0]
set_property PFM.AXI_PORT { \
    S_AXI_HPC0_FPD {memport "S_AXI_HPC"} \
    S_AXI_HPC1_FPD {memport "S_AXI_HPC"} \
    S_AXI_HP0_FPD {memport "S_AXI_HP"} \
    S_AXI_HP1_FPD {memport "S_AXI_HP"} \
    S_AXI_HP2_FPD {memport "S_AXI_HP"} \
    S_AXI_HP3_FPD {memport "S_AXI_HP"} \
    S_AXI_LPD {memport "S_AXI_HP"} \
    } [get_bd_cells /zynq_ultra_ps_e_0]
set intVar []
for {set i 1} {$i < 8} {incr i} {
    lappend intVar In$i {}
}
set_property PFM.IRQ $intVar [get_bd_cells /xlconcat_0]

# generate dsa
write_dsa -force ./${overlay_name}.dsa
validate_dsa ./${overlay_name}.dsa
