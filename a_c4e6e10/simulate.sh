#!/bin/sh
# simulate.sh

. ./setup.sh

guarded rm    -rf $SIM_DIR
guarded mkdir -p  $SIM_DIR
guarded cd        $SIM_DIR

is_command_available iverilog && iverilog_available=1
is_command_available gtkwave  && gtkwave_available=1
is_command_available vsim     && vsim_available=1

if [ $iverilog_available = 1 ] && [ $vsim_available = 1 ]
then

fi


#iverilog_available=$(is_command_available iverilog)
#gtkwave_available=$(is_command_available gtkwave)
#vsim_available=$(is_command_available vsim)

echo "1$iverilog_available"
echo "2$gtkwave_available"
echo "3$vsim_available"
exit


guarded vsim -do ../modelsim_script.tcl
