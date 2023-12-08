#!/bin/bash
#SBATCH -J data_process
#SBATCH -p general
#SBATCH -A r00114
#SBATCH -o data_process_%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH --time=10:15:00

mamba init
source ~/.bashrc
mamba activate megatron
set -x

cd /N/slate/jindjia/LLM/data/codeparrot
ls 

python ....../Megatron-LM/tools/preprocess_data.py \
       --input codeparrot_data.json \
       --output-prefix codeparrot \
       --vocab-file gpt2-vocab.json \
       --dataset-impl mmap \
       --tokenizer-type GPT2BPETokenizer \
       --merge-file gpt2-merges.txt \
       --json-keys content \
       --append-eod \
       --chunk-size 50 \
       --workers 10