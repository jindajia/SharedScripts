#!/bin/bash
#SBATCH --job-name=codeparrot_debug
#SBATCH -p GPU-shared
#SBATCH -N 1
#SBATCH -t 24:00:00
#SBATCH --gpus=v100-32:4
#SBATCH --output=codeparrot_debug_%j.txt

module load cuda
mamba init
source ~/.bashrc
mamba activate megatron

export CUDA_DEVICE_MAX_CONNECTIONS=1
export LD_LIBRARY_PATH=/ocean/projects/asc200010p/jjia1/Developer/nccl/build/lib/:$LD_LIBRARY_PATH


set -x

declare -a HOST_ARRAY
route

HOSTNAMES=$(scontrol show hostnames | sort -u)
HOSTLIST=""
FIRST_HOST=""
for HOST in $HOSTNAMES; do
  if [ -z "$FIRST_HOST" ]; then
    FIRST_HOST=$HOST
  fi
  HOST_ARRAY+=($HOST)
  HOSTLIST="${HOSTLIST}${HOST},"
done
HOSTLIST=${HOSTLIST%,}
MASTER_ADDR=$FIRST_HOST


# UPDATE IT FOR TRAINING
NNODES=1
GPUS_PER_NODE=4
export BASE_DIR=/ocean/projects/asc200010p/jjia1/scripts/gpt_result/codeparrot/quantize_training/baseline

srun --nodes=$NNODES --gres=gpu:$GPUS_PER_NODE --export=ALL,GPUS_PER_NODE=$GPUS_PER_NODE,MASTER_ADDR=$MASTER_ADDR,NNODES=$NNODES bash -c "./run.sh"