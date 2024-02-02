#!/bin/bash
#SBATCH --job-name=nccl-test-build
#SBATCH --partition=gpuA100x4
#SBATCH --nodes=1
#SBATCH --gpus-per-node=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=60g
#SBATCH -t 02:00:00
#SBATCH --output=nccl-build-%j.txt
#SBATCH --account=bcev-delta-gpu

module purge
module load gcc openmpi/4.1.6 cuda/11.8.0

# git clone --branch v2.19.4-1 git@github.com:NVIDIA/nccl.git
cd /projects/bcev/jjia1/TOOLS/nccl
make clean
make src.build CUDA_HOME=/sw/spack/deltas11-2023-03/apps/linux-rhel8-zen3/gcc-11.4.0/cuda-11.8.0-vfixfmc \
 NVCC_GENCODE="-gencode=arch=compute_80,code=sm_80"

cd /projects/bcev/jjia1/TOOLS/nccl-tests
make clean

make MPI=1 MPI_HOME=/sw/spack/deltas11-2023-03/apps/linux-rhel8-zen3/gcc-11.4.0/openmpi-4.1.6-lranp74 \
 CUDA_HOME=/sw/spack/deltas11-2023-03/apps/linux-rhel8-zen3/gcc-11.4.0/cuda-11.8.0-vfixfmc \
 NCCL_HOME=/projects/bcev/jjia1/TOOLS/nccl/build

