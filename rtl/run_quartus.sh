#!/usr/bin/env bash

rm -rf db incremental_db
/cygdrive/c/intelFPGA_lite/16.1/quartus/bin64/quartus_sh -t quartus.tcl -project base_decoder
