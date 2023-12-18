#!/bin/bash
#SBATCH -N 1
#SBATCH -p RM-shared
#SBATCH -t 00:10:00
#SBATCH --ntasks-per-node=4

# set huggingface dataset cache path
export HF_DATASETS_CACHE="/ocean/projects/asc200010p/jjia1/.cache/huggingface/datasets"

# set conda virtual environment
mamba init
source ~/.bashrc
mamba activate megatron
set -x

# move to dataset folder
cd /ocean/projects/asc200010p/jjia1/data/wikitext-103-v1

python /ocean/projects/asc200010p/jjia1/scripts/prepare_data/python_script/download_wikitext_103.py

