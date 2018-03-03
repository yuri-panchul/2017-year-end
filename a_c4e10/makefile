#!/bin/sh

rm -rf syn
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
#!/bin/sh

#export QUARTUS_ROOTDIR=${HOME}/altera/13.0sp1/quartus
export QUARTUS_ROOTDIR=${HOME}/intelFPGA_lite/17.1/quartus

export PATH=${PATH}:${QUARTUS_ROOTDIR}
#!/bin/sh

. ./setup.sh

rm -rf syn
mkdir -p syn
cp top.qsf syn
echo "# This file can be empty, all the settings are in .qsf file" > syn/top.qpf
cd syn

quartus_sh  --no_banner --flow compile top

./configure.sh
