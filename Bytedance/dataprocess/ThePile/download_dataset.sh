#!/bin/bash
#SBATCH -J download_c4_dataset
#SBATCH -p general
#SBATCH -o download_c4_dataset_%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=64
#SBATCH --time=20:00:00

export HF_DATASETS_CACHE="/N/scratch/jindjia/.cache/huggingface/datasets"

# load virtual environment, require transformers and dataset https://huggingface.co/docs/transformers/installation , https://huggingface.co/docs/datasets/installation
conda init
source ~/.bashrc
set -x

python download.py