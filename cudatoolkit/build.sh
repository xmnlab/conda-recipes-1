#!/bin/bash

# wget -c https://developer.nvidia.com/compute/cuda/9.2/Prod/local_installers/cuda_9.2.88_396.26_linux

chmod +x cuda_9.2.88_396.26_linux
./cuda_9.2.88_396.26_linux --silent --toolkit --toolkitpath=$BUILD_PREFIX/cuda/

mkdir $PREFIX/lib
mkdir $PREFIX/include

# Component : CUDA Runtime
#   Linux   : libcudart.so, libcudart_static.a, libcudadevrt.a
find $BUILD_PREFIX/cuda -type f -name "libcudart.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libcudart_static.a*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libcudadevrt.a*"  -exec cp {} find $PREFIX/lib \;
# Component : CUDA FFT Library
#   Linux   : libcufft.so, libcufft_static.a, libcufftw.so, libcufftw_static.a
find $BUILD_PREFIX/cuda -type f -name "libcufft.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libcufft_static.a*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libcufftw.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libcufftw_static.a*"  -exec cp {} find $PREFIX/lib \;
# Component : CUDA BLAS Library
#   Linux   : libcublas.so, libcublas_static.a, libcublas_device.a
find $BUILD_PREFIX/cuda -type f -name "libcublas.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libcublas_static.a*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libcublas_device.a*"  -exec cp {} find $PREFIX/lib \;
# Component : NVIDIA "Drop-in" BLAS Library
#   Linux   : libnvblas.so
find $BUILD_PREFIX/cuda -type f -name "libnvblas.so*"  -exec cp {} find $PREFIX/lib \;
# Component : CUDA Sparse Matrix Library
#   Linux   : libcusparse.so, libcusparse_static.a
find $BUILD_PREFIX/cuda -type f -name "libcusparse.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libcusparse_static.a*"  -exec cp {} find $PREFIX/lib \;
# Component : CUDA Linear Solver Library
#    Linux   : libcusolver.so, libcusolver_static.a
find $BUILD_PREFIX/cuda -type f -name "libcusolver.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libcusolver_static.a*"  -exec cp {} find $PREFIX/lib \;
# Component : CUDA Random Number Generation Library
#   Linux   : libcurand.so, libcurand_static.a
find $BUILD_PREFIX/cuda -type f -name "libcurand.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name " libcurand_static.a*"  -exec cp {} find $PREFIX/lib \;
# Component : CUDA Accelerated Graph Library
#   Linux   : libnvgraph.so, libnvgraph_static.a
find $BUILD_PREFIX/cuda -type f -name "libnvgraph.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnvgraph_static.a*"  -exec cp {} find $PREFIX/lib \;
# Component : NVIDIA Performance Primitives Library
#   Linux   : 
# libnppc.so, libnppc_static.a, libnppial.so, libnppial_static.a, libnppicc.so, 
find $BUILD_PREFIX/cuda -type f -name "libnppc.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnppc_static.a*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnppial.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnppial_static.a*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnppicc.so*"  -exec cp {} find $PREFIX/lib \;
# libnppicc_static.a, libnppicom.so, libnppicom_static.a, libnppidei.so, libnppidei_static.a,
find $BUILD_PREFIX/cuda -type f -name "libnppicc_static.a*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnppicom.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnppicom_static.a*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnppidei.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnppidei_static.a*"  -exec cp {} find $PREFIX/lib \;
# libnppif.so, libnppif_static.a, libnppig.so, libnppig_static.a, libnppim.so, libnppim_static.a,
find $BUILD_PREFIX/cuda -type f -name "libnppif.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnppif_static.a*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnppig.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnppig_static.a*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnppim.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnppim_static.a*"  -exec cp {} find $PREFIX/lib \;
# libnppist.so, libnppist_static.a, libnppisu.so, libnppisu_static.a, libnppitc.so, 
find $BUILD_PREFIX/cuda -type f -name "libnppist.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnppist_static.a*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnppisu.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnppisu_static.a*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnppitc.so*"  -exec cp {} find $PREFIX/lib \;
# libnppitc_static.a, libnpps.so, libnpps_static.a
find $BUILD_PREFIX/cuda -type f -name "libnppitc_static.a*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnpps.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnpps_static.a*"  -exec cp {} find $PREFIX/lib \;
# Component : Internal common library required for statically linking to cuBLAS, cuSPARSE, cuFFT, cuRAND and NPP
#   Linux   : libculibos.a
find $BUILD_PREFIX/cuda -type f -name "libculibos.a*"  -exec cp {} find $PREFIX/lib \;
# Component : NVIDIA Runtime Compilation Library
#   Linux   : libnvrtc.so, libnvrtc-builtins.so
find $BUILD_PREFIX/cuda -type f -name "libnvrtc.so*"  -exec cp {} find $PREFIX/lib \;
find $BUILD_PREFIX/cuda -type f -name "libnvrtc-builtins.so*"  -exec cp {} find $PREFIX/lib \;
# Component : NVIDIA Optimizing Compiler Library
#   Linux   : libnvvm.so
find $BUILD_PREFIX/cuda -type f -name "libnvvm.so*"  -exec cp {} find $PREFIX/lib \;
# Component : NVIDIA Common Device Math Functions Library
#   Linux   : libdevice.10.bc
find $BUILD_PREFIX/cuda -type f -name "libdevice.10.bc*"  -exec cp {} find $PREFIX/lib \;
# Component : CUDA Occupancy Calculation Header Library
#   All     : cuda_occupancy.h
find $BUILD_PREFIX/cuda -type f -name "cuda_occupancy.h*"  -exec cp {} find $PREFIX/include \;
# Component : CUDA Profiling Tools Interface (CUPTI) Library
#   Linux   : libcupti.so
find $BUILD_PREFIX/cuda -type f -name "libcupti.so*"  -exec cp {} find $PREFIX/lib \;
# Component : NVIDIA Tools Extension Library
#   Linux   : libnvToolsExt.so
find $BUILD_PREFIX/cuda -type f -name "libnvToolsExt.so*"  -exec cp {} find $PREFIX/lib \;
