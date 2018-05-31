#!/bin/bash

#env

# Useful environment variables
# PREFIX - installation prefix
# RECIPE_DIR - path to recipe directory


#
# Install system packages
#

# Installing system packages requires sudo
SYSTEM_PREFIX=/usr
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
                   gcc-c++ gcc \
                   "
  ;;
Ubuntu*)
  SYSTEM_INSTALL_COMMAND="$SUDO apt install --assume-yes"
  BOOST_PACKAGES="libboost-context-dev \
                   libboost-thread-dev libboost-program-options-dev \
                   libboost-regex-dev \
                   libboost-system-dev libboost-chrono-dev \
                   libboost-filesystem-dev"
  SYSTEM_PACKAGES="$COMMON_SYSTEM_PACKAGES $BOOST_PACKAGES \
                   zlib1g-dev \
                   cmake \
                   gcc-5 g++-5 \
                   "
  ;;
*)
  echo "NOTIMPL TARGET=$TARGET"
  exit 1

esac

echo "$SYSTEM_INSTALL_COMMAND $SYSTEM_PACKAGES" 
$SYSTEM_INSTALL_COMMAND $SYSTEM_PACKAGES 

#
# Install packages from source
#

LOCAL_PREFIX=$PREFIX
LOCAL_PREFIX=$RECIPE_DIR/local  # temporary
mkdir -p $LOCAL_PREFIX

AWSCPP_VERSION=1.3.10
GCC_VERSION=5.5.0

source $RECIPE_DIR/packages.sh

case $TARGET in
CentOS*)
  # CentOS gcc-4.8 is too old:
  install_gcc 
  export CC=$GCC_PREFIX/bin/gcc
  export CXX=$GCC_PREFIX/bin/g++
  $SUDO yum remove -y gcc-c++ gcc # to make sure that gcc-5 is used

  # CentOS cmake-2.8 is too old:
  #download_make_install https://internal-dependencies.mapd.com/thirdparty/cmake-3.7.2.tar.gz
  ;;
Ubuntu*)
  export CC=gcc-5
  export CXX=g++-5
  ;;
*)
esac

#install_awscpp
