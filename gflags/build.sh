#!/bin/bash

mkdir build_release
cd build_release

export CXXFLAGS="-fPIC ${CXXFLAGS}"
export CFLAGS="-fPIC ${CFLAGS}"

if [ $(uname) == Darwin ]; then
  export CC=clang
  export CXX=clang++
  export MACOSX_DEPLOYMENT_TARGET="10.9"
  export CXXFLAGS="-stdlib=libc++ $CXXFLAGS"
  export LDFLAGS="$LDFLAGS -Wl,-rpath,$PREFIX/lib"
fi

cmake ..  \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DINSTALL_HEADERS=on \
    -DBUILD_SHARED_LIBS=on \
    -DBUILD_STATIC_LIBS=on \
    -DBUILD_TESTING=on
make
ctest
make install
