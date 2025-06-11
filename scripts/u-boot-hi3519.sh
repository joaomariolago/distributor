#!/bin/bash

export CROSS_COMPILE=arm-linux-gnueabi-
mkdir -p output

make clean
make hi3519_config
make -j8

cp u-boot.bin output/u-boot-hi3519-universal.bin
