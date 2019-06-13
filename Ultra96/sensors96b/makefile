overlay_name := sensors96b
design_name := sensors96b

all: bitstream check_timing dsa
	@echo
	@tput setaf 2 ; echo "Built $(overlay_name) successfully!"; tput sgr0;
	@echo

u96v2: bitstream2 check_timing dsa
	@echo
	@tput setaf 2 ; echo "Built $(overlay_name) successfully!"; tput sgr0;
	@echo

bitstream:
	vivado -mode batch -source $(overlay_name).tcl -notrace

bitstream2:
	vivado -mode batch -source $(overlay_name)_v2.tcl -notrace

check_timing:
	vivado -mode batch -source check_$(overlay_name).tcl -notrace

dsa:
	vivado -mode batch -source build_$(overlay_name)_dsa.tcl -notrace
	unzip -qo $(overlay_name).dsa -d .dsa
	cp -rf .dsa/$(design_name).hwh ./$(overlay_name).hwh

clean:
	rm -rf $(overlay_name) *.jou *.log
	rm -rf .dsa
	rm $(overlay_name).bit $(overlay_name).hwh $(overlay_name).hdf $(overlay_name).dsa
