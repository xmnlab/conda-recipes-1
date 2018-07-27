#!/usr/bin/env bash

set -e
set -x

UNAME=`uname`
if [[ $UNAME == "Darwin" ]]; then
    source $PREFIX/bin/mapd-deps-osx.sh
fi
