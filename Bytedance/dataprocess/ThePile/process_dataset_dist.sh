#!/bin/bash
#SBATCH -J data_process
#SBATCH -p general
#SBATCH -o data_process_%j.txt
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=32
#SBATCH --cpus-per-task=4
#SBATCH --time=04:00:00

# load virtual environment required by megatron
conda init
source ~/.bashrc
conda activate megatron
# load mpi 
module load openmpi/4.0.5
set -x

export HF_DATASETS_OFFLINE=0
export HF_DATASETS_CACHE="/N/scratch/jindjia/.cache/huggingface/datasets"
MASTER_PORT=6000
NODE_RANK=$SLURM_NODEID
NNODES=1
PROC_PER_NODE=64

echo "data process start"
date

srun -n $PROC_PER_NODE python Megatron-LM-zeropp/tools/preprocess_data_dist.py \
       --input pile.jsonl \
       --split train \
       --columns text \
       --output-prefix pile \
       --vocab-file vocab.json \
       --merge-file merges.txt \
       --dataset-impl mmap \
       --tokenizer-type GPT2BPETokenizer \
       --append-eod \
       --torch-backend mpi

echo "data process finish"
date