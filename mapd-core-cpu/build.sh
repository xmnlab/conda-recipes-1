#!/usr/bin/env bash

set -ex

mkdir -p build
cd build

if [ $(uname) == Darwin ]; then
  export CC=clang
  export CXX=clang++
  export MACOSX_DEPLOYMENT_TARGET="10.9"
fi

# export LIBGFLAGS_INCLUDE_DIR=$PREFIX/lib
# export LIBGLOG_INCLUDE_DIR=$PREFIX/lib
export LD_LIBRARY_PATH=$PREFIX/lib
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
export GDAL_LIBRARY=$PREFIX
export GDAL_INCLUDE_DIR=$PREFIX/include

# export CPPFLAGS="-std=c++14 -I$PREFIX/include"
# export CXXFLAGS="-std=c++14"
# cmake -E env LDFLAGS="-rpath=-L$LD_LIBRARY_PATH" cmake ..

CUDA_ROOT=$(ls -d /Developer/NVIDIA/CUDA-* | tail -n 1)
DYLD_LIBRARY_PATH=$CUDA_ROOT/lib:$DYLD_LIBRARY_PATH
PATH=$CUDA_ROOT/bin:$PATH
PATH=$HOME/bin:$PATH

cmake \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=release \
    -DENABLE_CUDA=off \
    -DMAPD_IMMERSE_DOWNLOAD=off \
    -DMAPD_DOCS_DOWNLOAD=off \
    -DPREFER_STATIC_LIBS=on \
    -DENABLE_AWS_S3=off \
    -DENABLE_TESTS=on  \
    -DCMAKE_C_COMPILER=$CC \
    -DCMAKE_CXX_COMPILER=$CXX ..
make -j 4

