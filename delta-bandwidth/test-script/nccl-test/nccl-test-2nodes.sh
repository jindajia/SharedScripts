#!/bin/bash
#SBATCH --job-name=nccl-test
#SBATCH --partition=gpuA100x8
#SBATCH --nodes=2
#SBATCH --gpus-per-node=8
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=240g
#SBATCH -t 00:10:00
#SBATCH --output=nccl-test-result-2nodes-%j.txt
#SBATCH --account=bcev-delta-gpu

module purge
module load gcc openmpi/4.1.6 cuda/11.8.0

set -x

module list

route
nvidia-smi

export LD_LIBRARY_PATH=/projects/bcev/jjia1/TOOLS/nccl/build/lib:/sw/spack/deltas11-2023-03/apps/linux-rhel8-zen3/gcc-11.4.0/openmpi-4.1.6-lranp74/lib:/sw/spack/deltas11-2023-03/apps/linux-rhel8-zen3/gcc-11.4.0/cuda-11.8.0-vfixfmc/lib64:$LD_LIBRARY_PATH

NNODES=2
GPUS_PER_NODE=8
DATA_BYTES=1073741824
# export NCCL_DEBUG=INFO

# Get the hostnames
HOSTNAMES=$(scontrol show hostnames | sort -u)
HOSTLIST=""
for HOST in $HOSTNAMES; do
  HOSTLIST="${HOSTLIST}${HOST},"
done

HOSTLIST=${HOSTLIST%,}

cd /projects/bcev/jjia1/TOOLS/nccl-tests/build

srun ./reduce_scatter_perf -b $DATA_BYTES -e $DATA_BYTES -g $GPUS_PER_NODE -d half
srun ./all_gather_perf -b $DATA_BYTES -e $DATA_BYTES -g $GPUS_PER_NODE -d half
srun ./alltoall_perf -b $DATA_BYTES -e $DATA_BYTES -g $GPUS_PER_NODE -d half