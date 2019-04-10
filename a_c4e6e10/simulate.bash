#!/bin/bash
# simulate.bash

. ./setup.bash

#-----------------------------------------------------------------------------

guarded rm    -rf $SIM_DIR
guarded mkdir -p  $SIM_DIR
guarded cd        $SIM_DIR

#-----------------------------------------------------------------------------

run_iverilog=0
run_gtkwave=0
run_vsim=0

is_command_available iverilog && run_iverilog=1
is_command_available gtkwave  && run_gtkwave=1
is_command_available vsim     && run_vsim=1

#-----------------------------------------------------------------------------

if [ $run_iverilog = 1 ] && [ $run_vsim = 1 ]
then
    printf "Two Verilog simulators are available to run:"
    printf " Icarus Verilog and Mentor ModelSim\n"
    printf "Which do you want to run?\n"

    options="Icarus ModelSim Both"
    PS3="Your choice: "

    select simulator in $options
    do
        case $simulator in
        Icarus)   run_vsim=0     ; break ;;
        ModelSim) run_iverilog=0 ; break ;;
        Both)                      break ;;
        esac
    done
fi

if [ $run_iverilog = 0 ] && [ $run_gtkwave = 1 ]
then
    run_gtkwave=0
fi

[ $run_iverilog = 0 ] && [ $run_vsim = 0 ] && \
    error 1 "No Verilog simulator is available to run." \
            "You need to install either Icarus Verilog" \
            "or Mentor Questa / ModelSim."

#-----------------------------------------------------------------------------

if [ $run_iverilog = 1 ]
then
    iverilog -g2005 -I .. ../*.v &> icarus.compile.log 
    ec=$?

    if [ $ec != 0 ]
    then
        grep -i -A 5 error icarus.compile.log 2>&1
        error $ec Icarus Verilog compiler errors
    fi

    vvp a.out &> icarus.simulate.log

    ec=$?

    if [ $ec != 0 ]
    then
        grep -i -A 5 error icarus.simulate.log 2>&1
        tail -n 5 icarus.simulate.log 2>&1
        error $ec Icarus Verilog simulator errors
    fi

    info Icarus Verilog simulation successfull
    tail -n 5 icarus.simulate.log
fi

#-----------------------------------------------------------------------------

echo "1$run_iverilog"
echo "2$run_gtkwave"
echo "3$run_vsim"
exit


guarded vsim -do ../modelsim_script.tcl

exit 0
