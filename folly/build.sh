#!/bin/bash

cd folly
autoreconf -ivf
./configure \
	PREFIX=$PREFIX \
	CPPFLAGS="-I/opt/local/include" \
	LDFLAGS="-L/opt/local/lib" 
make
sudo make install
