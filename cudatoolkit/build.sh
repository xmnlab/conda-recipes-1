#!/bin/bash

# sha256=8d02cc2a82f35b456d447df463148ac4cc823891be8820948109ad6186f2667c
filename="cuda_${PKG_VERSION}_linux"
# download_url=https://developer.nvidia.com/compute/cuda/$PKG_VERSION/Prod/local_installers/$filename
# download_dir=$CONDA_PREFIX/conda-bld/src_cache
install_dir=$CONDA_PREFIX/tmp/cuda

mkdir -p $install_dir
mkdir -p $PREFIX/{lib,include}

# wget -c -o $download_dir/$filename $download_url

# TODO: check sha256

chmod +x $filename
sh $filename --silent --toolkit --toolkitpath=$install_dir --override

# remove unnecessary folders
excluded_dirs="bin doc extras jre libnsight libnvvp nsightee_plugins nvml pkgconfig samples tools"
for f in $excluded_dirs
do
    rm -rf $install_dir/$f
done

cuda_libs="libcudart.so libcudart_static.a libcudadevrt.a"
cuda_libs+=" libcufft.so libcufft_static.a libcufftw.so libcufftw_static.a"
cuda_libs+=" libcublas.so libcublas_static.a libcublas_device.a"
cuda_libs+=" libnvblas.so"
cuda_libs+=" libcusparse.so libcusparse_static.a"
cuda_libs+=" libcusolver.so libcusolver_static.a"
cuda_libs+=" libcurand.so libcurand_static.a"
cuda_libs+=" libnvgraph.so libnvgraph_static.a"
cuda_libs+=" libnppc.so libnppc_static.a libnppial.so libnppial_static.a"
cuda_libs+=" libnppicc.so libnppicc_static.a libnppicom.so"
cuda_libs+=" libnppicom_static.a libnppidei.so libnppidei_static.a" 
cuda_libs+=" libnppif.so libnppif_static.a libnppig.so libnppig_static.a"
cuda_libs+=" libnppim.so libnppim_static.a libnppist.so libnppist_static.a"
cuda_libs+=" libnppisu.so libnppisu_static.a libnppitc.so"
cuda_libs+=" libnppitc_static.a libnpps.so libnpps_static.a"
cuda_libs+=" libculibos.a"
cuda_libs+=" libnvrtc.so libnvrtc-builtins.so"
cuda_libs+=" libnvvm.so"
cuda_libs+=" libdevice.10.bc"
cuda_libs+=" libcupti.so"
cuda_libs+=" libnvToolsExt.so"

cuda_h="cuda_occupancy.h"

echo "Copying lib files:"
for f in $cuda_libs
do
    echo "- $f ..."
    find $install_dir -name "${f}*"  -exec cp -a {} $PREFIX/lib \;
done

echo "Copying header files:"
for f in $cuda_h
do
    echo "- $f ..."
    find $install_dir -name "${f}*"  -exec cp -a {} $PREFIX/include \;
done

rm -rf $install_dir
