#!/bin/bash

if [ $(uname) == Darwin ]; then
  export CC=clang
  export CXX=clang++
  export MACOSX_DEPLOYMENT_TARGET="10.9"
  export CXXFLAGS="-stdlib=libc++ $CXXFLAGS"
  export LDFLAGS="$LDFLAGS -Wl,-rpath,$PREFIX/lib"
fi

./configure --help
./configure --prefix=$PREFIX CC=clang

make
# disabled make check: https://github.com/google/glog/issues/13
# make check
make install
