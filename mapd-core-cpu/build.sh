#!/usr/bin/env bash

set -ex

mkdir -p build
cd build

if [ $(uname) == Darwin ]; then
  export CC=clang
  export CXX=clang++
  export MACOSX_DEPLOYMENT_TARGET="10.9"
fi

export CPPFLAGS="-std=c++14 -I$PREFIX/include $CPPFLAGS"
export CXXFLAGS="-std=c++14 -I$PREFIX/include $CXXFLAGS"

# export CPPFLAGS=""
# export CXXFLAGS=""

export CONDA_LIB=$PREFIX/lib
export LD_LIBRARY_PATH=$CONDA_LIB:$LD_LIBRARY_PATH
export DYLD_LIBARY_PATH=$CONDA_LIB:$DYLD_LIBRARY_PATH
export BOOST_INCLUDEDIR=$PREFIX/include

# cudda
# CUDA_ROOT=$(ls -d /Developer/NVIDIA/CUDA-* | tail -n 1)
# DYLD_LIBRARY_PATH=$CUDA_ROOT/lib:$DYLD_LIBRARY_PATH
# PATH=$CUDA_ROOT/bin:$PATH
# PATH=$HOME/bin:$PATH
# export DYLD_LIBRARY_PATH PATH

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

make
