#!/bin/sh

rm -rf syn
mkdir syn
cp top.qsf syn
echo "# This file can be empty, all the settings are in .qsf file" > syn/top.qpf
cd syn

quartus_sh --flow compile top

exit



quartus_sh --determine_smart_action top > log
quartus_map --read_settings_files=on --family="Cyclone IV E" --source=../top.v top
quartus_fit --part=EP4CE6E22C8 --read_settings_files=on top
quartus_asm top
quartus_sta top 
quartus_pgm --no_banner -c USB-Blaster --mode=jtag -o "P;top.sof"
