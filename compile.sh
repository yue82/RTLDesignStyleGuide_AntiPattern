#!/usr/bin/env bash

RTL_DIR="./rtl"

if [ ! -e ./work ]; then
    vlib ./work
fi

sim_name=$1
echo "Test Scenario=" $sim_name

vlog \
    +notimingchecks \
    -sv \
    -y ${RTL_DIR} \
    +incdir+${RTL_DIR}/+ \
    +libext+.v+ \
    sim/test_${sim_name}.v

vsim -c -keepstdout test_${sim_name} <<EOF
run -all

EOF
