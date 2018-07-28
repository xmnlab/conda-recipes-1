#!/usr/bin/env bash

mkdir build
cd build

export LIBGFLAGS_INCLUDE_DIR=$BUILD_PREFIX/include
export LD_LIBRARY_PATH=$BUILD_PREFIX/lib
export PKG_CONFIG_PATH=$BUILD_PREFIX/lib/pkgconfig

#export CPPFLAGS="-std=c++14 -I$BUILD_PREFIX/include"
#export CXXFLAGS="-std=c++14"
#cmake -E env LDFLAGS="-rpath=-L$LD_LIBRARY_PATH" cmake ..

cmake \
    -DCMAKE_INSTALL_PREFIX=$BUILD_PREFIX \
    -DCMAKE_BUILD_TYPE=release \
    -DENABLE_CUDA=off \
    -DMAPD_IMMERSE_DOWNLOAD=on \
    -DMAPD_DOCS_DOWNLOAD=off \
    -DPREFER_STATIC_LIBS=on \
    -DENABLE_AWS_S3=on \
    -DENABLE_TESTS=on  \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang ..
make -j 4

