#!/bin/bash
# check free ram
free -h
# check GPU (should be P100-PCIE-16GB)
nvidia-smi -L
# check CPU (should be Intel(R) Xeon(R) CPU @ 2.30 GHz)
lscpu | grep 'Model name'
# check number of cores per socket (should be Core(s) per socket: 2)
lscpu | grep 'Core(s) per socket'
# check number of threads per core (should be Thread(s) per core: 2)
lscpu | grep 'Thread(s) per core'
# utility for monitoring and managing GPU(s)
nvidia-smi
# check CUDA version in google colab
nvcc --version
