#!/bin/bash

# wget -c https://developer.nvidia.com/compute/cuda/9.2/Prod/local_installers/cuda_9.2.88_396.26_linux

chmod +x cuda_9.2.88_396.26_linux
./cuda_9.2.88_396.26_linux --silent --drive --toolkit --extract=$PREFIX/usr/local/

# =============
# FILES TO KEEP
# =============
# Component : CUDA Runtime
#   Linux   : libcudart.so, libcudart_static.a, libcudadevrt.a
# Component : CUDA FFT Library
#   Linux   : libcufft.so, libcufft_static.a, libcufftw.so, libcufftw_static.a
# Component : CUDA BLAS Library
#   Linux   : libcublas.so, libcublas_static.a, libcublas_device.a
# Component : NVIDIA "Drop-in" BLAS Library
#   Linux   : libnvblas.so
# Component : CUDA Sparse Matrix Library
#   Linux   : libcusparse.so, libcusparse_static.a
# Component : CUDA Linear Solver Library
#    Linux   : libcusolver.so, libcusolver_static.a
# Component : CUDA Random Number Generation Library
#   Linux   : libcurand.so, libcurand_static.a
# Component : CUDA Accelerated Graph Library
#   Linux   : libnvgraph.so, libnvgraph_static.a
# Component : NVIDIA Performance Primitives Library
#   Linux   : libnppc.so, libnppc_static.a, libnppial.so, libnppial_static.a, libnppicc.so, libnppicc_static.a, libnppicom.so, libnppicom_static.a, libnppidei.so, libnppidei_static.a, libnppif.so, libnppif_static.a, libnppig.so, libnppig_static.a, libnppim.so, libnppim_static.a, libnppist.so, libnppist_static.a, libnppisu.so, libnppisu_static.a, libnppitc.so, libnppitc_static.a, libnpps.so, libnpps_static.a
# Component : Internal common library required for statically linking to cuBLAS, cuSPARSE, cuFFT, cuRAND and NPP
#   Linux   : libculibos.a
# Component : NVIDIA Runtime Compilation Library
#   Linux   : libnvrtc.so, libnvrtc-builtins.so
# Component : NVIDIA Optimizing Compiler Library
#   Linux   : libnvvm.so
# Component : NVIDIA Common Device Math Functions Library
#   Linux   : libdevice.10.bc
# Component : CUDA Occupancy Calculation Header Library
#   All     : cuda_occupancy.h
# Component : CUDA Profiling Tools Interface (CUPTI) Library
#   Linux   : libcupti.so
# Component : NVIDIA Tools Extension Library
#   Linux   : libnvToolsExt.so
