#!/bin/bash 

set -ex

VERS=$PKG_VERSION

PYTHON=$SYS_PYTHON
PYTHON_INCLUDE_DIR=$($PYTHON -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")
PYTHON_LIBRARY=$($PYTHON -c "import distutils.sysconfig as sc;print('{LIBDIR}/{LDLIBRARY}'.format_map(sc.get_config_vars()))")

echo "PYTHON_INCLUDE_DIR=$PYTHON_INCLUDE_DIR"
echo "PYTHON_LIBRARY=$PYTHON_LIBRARY"

# tar xf llvm.tar.xz
# tar xf cfe.tar.xz
# tar xf compiler-rt.tar.xz
# tar xf lld.tar.xz
# tar xf lldb.tar.xz
# tar xf libcxx.tar.xz
# tar xf libcxxabi.tar.xz

mv cfe-$VERS.src llvm-$VERS.src/tools/clang
mv compiler-rt-$VERS.src llvm-$VERS.src/projects/compiler-rt
mv lld-$VERS.src llvm-$VERS.src/tools/lld
mv lldb-$VERS.src llvm-$VERS.src/tools/lldb
mv libcxx-$VERS.src llvm-$VERS.src/projects/libcxx
mv libcxxabi-$VERS.src llvm-$VERS.src/projects/libcxxabi

# fix missing include discovered by gcc-7 (todo: prepare a patch)
FN=llvm-$VERS.src/tools/lldb/include/lldb/Utility/TaskPool.h
sed -i "/#include <vector>/a#include <functional>" $FN
mkdir build.llvm-$VERS

pushd build.llvm-$VERS
  # todo: remove PYTHON_* variables:
  cmake -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DLLVM_ENABLE_RTTI=on \
    -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE_DIR \
    -DPYTHON_LIBRARY=$PYTHON_LIBRARY \
    -DLLDB_DISABLE_PYTHON=1 \
    ../llvm-$VERS.src

  makej
  make install
popd

