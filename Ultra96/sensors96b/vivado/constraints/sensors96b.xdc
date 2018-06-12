##############################################################################
#  Copyright (c) 2016, Xilinx, Inc.
#  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are met:
#
#  1.  Redistributions of source code must retain the above copyright notice,
#     this list of conditions and the following disclaimer.
#
#  2.  Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#
#  3.  Neither the name of the copyright holder nor the names of its
#      contributors may be used to endorse or promote products derived from
#      this software without specific prior written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
#  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
#  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
#  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION). HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
###############################################################################

set_property IOSTANDARD LVCMOS18 [get_ports uart*]
set_property IOSTANDARD LVCMOS18 [get_ports gpio_sensors_tri_io*]

## HD_GPIO_2 on FPGA / Connector pin 7 / uart0_rxd
set_property PACKAGE_PIN F7 [get_ports uart0_rxd]
## HD_GPIO_1 on FPGA / Connector pin 5 / uart0_txd
set_property PACKAGE_PIN F8 [get_ports uart0_txd]
## HD_GPIO_3 on FPGA / Connector pin 9 / uart0_rts
set_property PACKAGE_PIN G7 [get_ports uart0_rtsn]
## HD_GPIO_0 on FPGA / Connector pin 3 / uart0_cts
set_property PACKAGE_PIN D7 [get_ports uart0_ctsn]
## HD_GPIO_5 on FPGA / Connector pin 13 / uart1_rxd
set_property PACKAGE_PIN G5 [get_ports uart1_rxd]
## HD_GPIO_4 on FPGA / Connector pin 11 / uart1_txd
set_property PACKAGE_PIN F6 [get_ports uart1_txd]
## HD_GPIO_6 on FPGA / Connector pin 29 / GPIO-G on 96Boards 
set_property PACKAGE_PIN A6 [get_ports {gpio_sensors_tri_io[0]}] 
## HD_GPIO_13 on FPGA/ Connector pin 30 / GPIO-H on 96Boards                                                             
set_property PACKAGE_PIN C7 [get_ports {gpio_sensors_tri_io[1]}] 
## HD_GPIO_7 on FPGA / Connector pin 31 / GPIO-I on 96Boards
set_property PACKAGE_PIN A7 [get_ports {gpio_sensors_tri_io[2]}]
## HD_GPIO_14 on FPGA/ Connector pin 32 / GPIO-J on 96Boards 
set_property PACKAGE_PIN B6 [get_ports {gpio_sensors_tri_io[3]}]
## HD_GPIO_8 on FPGA / Connector pin 33 / GPIO-K on 96Boards 
set_property PACKAGE_PIN G6 [get_ports {gpio_sensors_tri_io[4]}] 
## HD_GPIO_15 on FPGA/ Connector pin 34 / GPIO-L on 96Boards                                                             
set_property PACKAGE_PIN C5 [get_ports {gpio_sensors_tri_io[5]}] 

set_property IOSTANDARD LVCMOS18 [get_ports bt*]

## BT_HCI_RTS on FPGA /  emio_uart0_ctsn connect to 
set_property PACKAGE_PIN B7 [get_ports bt_ctsn]
## BT_HCI_CTS on FPGA / emio_uart0_rtsn
set_property PACKAGE_PIN B5 [get_ports bt_rtsn]
