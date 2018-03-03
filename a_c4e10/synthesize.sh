#!/bin/sh

. ./setup.sh

rm -rf syn
mkdir -p syn
cp top.qsf syn
echo "# This file can be empty, all the settings are in .qsf file" > syn/top.qpf
cd syn

quartus_sh  --no_banner --flow compile top

./configure.sh
