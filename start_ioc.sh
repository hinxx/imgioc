#!/bin/bash

source $HOME/bin/ng3esetup.sh
which caget >/dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "caget not found in PATH!"
	exit 1
fi

VERSION=master

cd $NG3E_IOCS/imgioc-$(VERSION)/iocBoot/iocImg || exit 1
../../bin/linux-x86_64/imgApp st.cmd
#gdb ../../bin/linux-x86_64/imgApp

