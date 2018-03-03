#!/bin/sh

. ./setup.sh

CABLE_NAME=`quartus_pgm -l | grep "1) " | sed -e 's/1) //'`

if [ "$CABLE_NAME" ]
then
    cd syn
    quartus_pgm --no_banner -c "$CABLE_NAME" --mode=jtag -o "P;top.sof"
else
    echo "Cannot detect a USB-Blaster cable connected"
    exit 1
fi
