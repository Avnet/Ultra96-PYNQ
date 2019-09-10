overlay_name := sensors96b
design_name := sensors96b

all: block_design bitstream check_timing dsa
	@echo
	@tput setaf 2 ; echo "Built $(overlay_name) successfully!"; tput sgr0;
	@echo

block_design:
	vivado -mode batch -source $(overlay_name).tcl -notrace

bitstream:
	vivado -mode batch -source build_bitstream.tcl -notrace

check_timing:
	vivado -mode batch -source check_$(overlay_name).tcl -notrace

dsa:
	vivado -mode batch -source build_$(overlay_name)_dsa.tcl -notrace

clean:
	rm -rf $(overlay_name) *.jou *.log NA

