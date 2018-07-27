#!/usr/bin/env bash

UNAME=`uname`
PWD=$(pwd)

if [[ $UNAME == "Linux" ]]; then
    cd linux
    source build.sh
    cd $PWD
else
   cp -R $RECIPE_DIR/osx/* $PREFIX/bin/
fi
