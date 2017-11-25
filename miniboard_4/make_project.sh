#!/bin/sh

rm -rf project
mkdir project
cp top.qsf project

echo "# This file can be empty, all the settings are in .qsf file" > project/top.qpf
