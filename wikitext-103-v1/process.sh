#!/bin/bash
#SBATCH -N 1
#SBATCH -p RM-shared
#SBATCH -t 00:40:00
#SBATCH --ntasks-per-node=10
#SBATCH -J data_process
#SBATCH -o data_process_%j.txt

mamba init
source ~/.bashrc
mamba activate megatron
set -x

cd /ocean/projects/asc200010p/jjia1/data/wikitext-103-v1

python /ocean/projects/asc200010p/jjia1/Developer/Megatron-LM/tools/preprocess_data.py \
       --input wikitext-103-v1.json \
       --output-prefix wikitext_103_v1 \
       --vocab-file vocab.json \
       --dataset-impl mmap \
       --tokenizer-type GPT2BPETokenizer \
       --merge-file merges.txt \
       --json-keys text \
       --append-eod \
       --workers 10