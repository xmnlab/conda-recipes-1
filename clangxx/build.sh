#!/bin/bash 

set -ex

if [ $(uname) == Darwin ]; then
  export MACOSX_DEPLOYMENT_TARGET="10.9"
fi

VERS=$PKG_VERSION

PYTHON_INCLUDE_DIR=$($PYTHON -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")
PYTHON_LIBRARY=$($PYTHON -c "import distutils.sysconfig as sc;print('{LIBDIR}/{LDLIBRARY}'.format_map(sc.get_config_vars()))")

echo "PYTHON_INCLUDE_DIR=$PYTHON_INCLUDE_DIR"
echo "PYTHON_LIBRARY=$PYTHON_LIBRARY"

mkdir build.llvm-$VERS
pushd build.llvm-$VERS
  # todo: remove PYTHON_* variables:
  cmake --prefix=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_ENABLE_RTTI=on \
    -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE_DIR \
    -DPYTHON_LIBRARY=$PYTHON_LIBRARY \
    -DLLDB_DISABLE_PYTHON=1 \
    ../llvm-$VERS.src

  make -j 4
  make install
popd

