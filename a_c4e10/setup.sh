#!/bin/sh

set -e

#export QUARTUS_ROOTDIR=${HOME}/altera/13.0sp1/quartus
export QUARTUS_ROOTDIR=${HOME}/intelFPGA_lite/17.1/quartus

export PATH=${PATH}:${QUARTUS_ROOTDIR}

SYN_DIR=${PWD}/syn
