#!/bin/sh

cd syn
quartus_pgm --no_banner -c USB-Blaster --mode=jtag -o "P;top.sof"
