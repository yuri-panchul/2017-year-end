#!/bin/sh
# clean.sh

. ./setup.sh

guarded rm -rf $SIM_DIR $SYN_DIR
