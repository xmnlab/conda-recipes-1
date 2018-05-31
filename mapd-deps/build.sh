#!/bin/bash

#env

# Useful environment variables
# PREFIX - installation prefix
# RECIPE_DIR - path to recipe directory

SYSTEM_PREFIX=/usr

LOCAL_PREFIX=$PREFIX
LOCAL_PREFIX=$RECIPE_DIR/local  # temporary, to cache succesful installations
mkdir -p $LOCAL_PREFIX

export PATH=$LOCAL_PREFIX/bin:$PREFIX/bin:$PATH
export LD_LIBRARY_PATH=$SYSTEM_PREFIX/lib64:$SYSTEM_PREFIX/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LOCAL_PREFIX/lib64:$LOCAL_PREFIX/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$PREFIX/lib64:$PREFIX/lib:$LD_LIBRARY_PATH

#
# Install system packages
#

# Installing system packages requires sudo
SUDO=
if [ ! -w $(dirname $SYSTEM_PREFIX) ] ; then
    SUDO=sudo
fi

TARGET=`lsb_release -i -s`-`lsb_release -c -s`
echo "TARGET=$TARGET" # Ubuntu-xenial, CentOS-Core

COMMON_SYSTEM_PACKAGES="wget make git"

case $TARGET in
CentOS*)
  SYSTEM_INSTALL_COMMAND="$SUDO yum install --assumeyes"
  BOOST_PREFIX=$SYSTEM_PREFIX
  BOOST_PACKAGES="boost-context \
                  boost-thread \
                  boost-program-options \
                  boost-regex \
                  boost-system \
                  boost-chrono \
                  boost-filesystem"
  SYSTEM_PACKAGES="$COMMON_SYSTEM_PACKAGES $BOOST_PACKAGES \
                   zlib-devel \
                   gmp-devel mpfr-devel libmpc-devel \
                   openssl-devel \
                   libcurl-devel \
                   "
  ;;
Ubuntu*)
  SYSTEM_INSTALL_COMMAND="$SUDO apt install --assume-yes"
  BOOST_PREFIX=$SYSTEM_PREFIX
  BOOST_PACKAGES="libboost-context-dev \
                   libboost-thread-dev libboost-program-options-dev \
                   libboost-regex-dev \
                   libboost-system-dev libboost-chrono-dev \
                   libboost-filesystem-dev"
  SYSTEM_PACKAGES="$COMMON_SYSTEM_PACKAGES $BOOST_PACKAGES \
                   zlib1g-dev \
                   cmake \
                   gcc-5 g++-5 \
                   curl libcurl4-openssl-dev \
                   "
  ;;
*)
  echo "NOTIMPL TARGET=$TARGET"
  exit 1

esac

$SYSTEM_INSTALL_COMMAND $SYSTEM_PACKAGES 

#
# Install packages from source
#


AWSCPP_VERSION=1.3.10
GCC_VERSION=5.5.0
THRIFT_VERSION=0.10.0

source $RECIPE_DIR/packages.sh

case $TARGET in
CentOS*)
  # CentOS gcc-4.8 is too old:
  $SYSTEM_INSTALL_COMMAND gcc-c++ gcc
  install_gcc $LOCAL_PREFIX $LOCAL_PREFIX/bin/gcc
  $SUDO yum remove -y gcc-c++ gcc # to make sure that gcc-5 is used   
  export CC=$LOCAL_PREFIX/bin/gcc
  export CXX=$LOCAL_PREFIX/bin/g++

  # CentOS cmake-2.8 is too old:
  download_make_install_local https://internal-dependencies.mapd.com/thirdparty/cmake-3.7.2.tar.gz "" "" $LOCAL_PREFIX/bin/cmake
  CMAKE=$LOCAL_PREFIX/bin/cmake

  #download_make_install_local https://www.openssl.org/source/openssl-1.0.2n.tar.gz "" "linux-$(uname -m) no-shared no-dso -fPIC"

  ;;
Ubuntu*)
  export CC=gcc-5
  export CXX=g++-5
  export CMAKE=cmake
  ;;
*)
esac

install_awscpp $LOCAL_PREFIX $LOCAL_PREFIX/lib/libaws-cpp-sdk-core.a # works on ubuntu, centos
install_thrift $LOCAL_PREFIX $LOCAL_PREFIX/bin/thrift             # works on ubuntu, centos
