#!/bin/bash

ln -s $BUILD_PREFIX/bin/bison++ $BUILD_PREFIX/bin/yacc

./configure \
    --prefix=$PREFIX \
    flex++-2.3.8
 
make firstflex
make test
make install
