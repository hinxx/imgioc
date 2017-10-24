#!/bin/bash

export NG3E_TOP=$HOME/git/ng3e
export NG3E_BASE=$NG3E_TOP/root/R3.15.4/base
export NG3E_MODULES=$NG3E_TOP/root/R3.15.4/modules
export NG3E_IOCS=$NG3E_TOP/root/R3.15.4/iocs

# for EPICS tools
export PATH=$PATH:$NG3E_BASE/bin/linux-x86_64
# for aravis lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
# for pyepics
export PYEPICS_LIBCA=$NG3E_BASE/lib/linux-x86_64/libca.so
