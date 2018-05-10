#!/bin/bash

cd folly

autoreconf -ivf

export LIBGFLAGS_INCLUDE_DIR=$BUILD_PREFIX/include
export LD_LIBRARY_PATH=$BUILD_PREFIX/lib

./configure \
	PREFIX=$PREFIX \
	CPPFLAGS="-I/opt/local/include -I$BUILD_PREFIX/include" \
	LDFLAGS="-L/opt/local/lib -L$BUILD_PREFIX/lib"
make
sudo make install
