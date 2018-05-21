#!/bin/bash

cd folly

autoreconf -ivf

export LIBGFLAGS_INCLUDE_DIR=$BUILD_PREFIX/include
export LD_LIBRARY_PATH=$BUILD_PREFIX/lib:$BUILD_PREFIX/lib64

# export OPENSSL_LDFLAGS=$BUILD_PREFIX/bin
# export OPENSSL_LIBS=-L$BUILD_PREFIX/lib
# export OPENSSL_INCLUDES=-I$BUILD_PREFIX/include/openssl

export PKG_CONFIG_PATH=$BUILD_PREFIX/lib/pkgconfig

export CPPFLAGS="-std=c++14 -I$BUILD_PREFIX/include"
export CXXFLAGS="-std=c++14"

./configure \
   --prefix=$PREFIX \
   --with-boost=$BUILD_PREFIX \
   LDFLAGS="-L$BUILD_PREFIX/lib -L$BUILD_PREFIX/lib64" \
   CC=$GCC CXX=$CXX

make
make install
