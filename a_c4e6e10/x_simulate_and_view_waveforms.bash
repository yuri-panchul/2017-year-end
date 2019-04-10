#!/bin/bash

. ./x_setup.bash

#-----------------------------------------------------------------------------

prepare_simulation_directory ()
{
    if ! { rm -rf sim && mkdir sim && cd sim ; }; then
        echo $script: Cannot prepare simulation directory
        exit 1
    fi
}

#-----------------------------------------------------------------------------

is_icarus_verilog_available ()
{
    command -v iverilog &> /dev/null
}

#-----------------------------------------------------------------------------

simulate_icarus_verilog ()
{
    if ! iverilog -g2005 -I .. ../*.v &> compile.log ; then
        echo $script: Verilog compiler returned error code
        grep -i -A 5 error compile.log
        exit 1
    fi

    if ! vvp a.out &> simulate.log; then
        echo $script: Verilog simulator returned error code
        grep -i -A 5 error simulate.log
        tail -n 5 simulate.log
        exit 1
    fi

    echo $script: Simulation successfull
    tail -n 5 simulate.log
}

#-----------------------------------------------------------------------------

is_gtkwave_viewer_available ()
{
    command -v gtkwave &> /dev/null
}

#-----------------------------------------------------------------------------

run_gtkwave_viewer ()
{
    if    [ "$OSTYPE" = "linux-gnu" ]  \
       || [ "$OSTYPE" = "cygwin"    ]  \
       || [ "$OSTYPE" = "msys"      ]
    then
        gtkwave                                 \
            --dump dump.vcd                     \
            --script ../script_for_gtkwave.tcl  \
            &> waveform.log

    elif [ ${OSTYPE/[0-9]*/} = "darwin" ]
    # elif [[ "$OSTYPE" = "darwin"* ]]  # Alternative way
    then
        # For some reason the following way of opening the application
        # does not read the script file:
        #
        # open -a gtkwave dump.vcd --args --script $PWD/../script_for_gtkwave.tcl
        #
        # This way works:

        /Applications/gtkwave.app/Contents/MacOS/gtkwave-bin    \
            --dump dump.vcd --script ../script_for_gtkwave.tcl  \
            &> waveform.log
    else
        echo "Don't know how to run GTKWave on your OS $OSTYPE"
        exit 1
    fi

    rc=$?

    if [ $rc -ne 0 ]
    then
        echo $script: Waveform viewer returned error code $rc
        grep -i -A 5 error waveform.log
        exit 1
    fi
}

#-----------------------------------------------------------------------------

is_modelsim_available ()
{
    command -v vsim &> /dev/null
}

#-----------------------------------------------------------------------------

run_modelsim ()
{
    if    [ "$OSTYPE" = "linux-gnu" ]  \
       || [ "$OSTYPE" = "cygwin"    ]  \
       || [ "$OSTYPE" = "msys"      ]
    then
        vsim -do ../script_for_modelsim.tcl &> modelsim.log
    else
        echo "Don't know how to run GTKWave on your OS $OSTYPE"
        exit 1
    fi

    rc=$?

    if [ $rc -ne 0 ]
    then
        echo $script: Modelsim returned error code $rc
        grep -i -A 5 error modelsim.log
        exit 1
    fi
}

#-----------------------------------------------------------------------------

cleanup ()
{
    cd .. && rm -rf sim
}

#-----------------------------------------------------------------------------

prepare_simulation_directory

if is_icarus_verilog_available
then
    simulate_icarus_verilog
fi

if is_gtkwave_viewer_available
then
    run_gtkwave_viewer
fi

if is_modelsim_available ; then
    run_modelsim
fi

cleanup
