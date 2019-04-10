#!/bin/bash
# simulate.bash

. ./setup.sh

#-----------------------------------------------------------------------------

guarded rm    -rf $SIM_DIR
guarded mkdir -p  $SIM_DIR
guarded cd        $SIM_DIR

#-----------------------------------------------------------------------------

iverilog_available=0
gtkwave_available=0
vsim_available=0

is_command_available iverilog && iverilog_available=1
is_command_available gtkwave  && gtkwave_available=1
is_command_available vsim     && vsim_available=1

#-----------------------------------------------------------------------------

if [ $iverilog_available = 1 ] && [ $vsim_available = 1 ]
then
    printf "Two Verilog simulators are available to run: Icarus Verilog and Mentor ModelSim\n"
    printf "Which do you want to run?\n"

    options="Icarus ModelSim Both"
    PS3="Your choice: "

    select simulator in $options
    do
        case $simulator in
        Icarus)   vsim_available=0     ; break ;;
        ModelSim) iverilog_available=0 ; break ;;
        Both)                            break ;;
        esac
    done
fi

#-----------------------------------------------------------------------------

#iverilog_available=$(is_command_available iverilog)
#gtkwave_available=$(is_command_available gtkwave)
#vsim_available=$(is_command_available vsim)

#-----------------------------------------------------------------------------

echo "1$iverilog_available"
echo "2$gtkwave_available"
echo "3$vsim_available"
exit


guarded vsim -do ../modelsim_script.tcl
