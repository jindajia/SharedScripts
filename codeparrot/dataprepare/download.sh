#!/bin/bash
#SBATCH -J download_codeparrot
#SBATCH -p general
#SBATCH -A r00114
#SBATCH -o download_codeparrot_%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --time=00:60:00

export HF_DATASETS_CACHE="/N/slate/jindjia/.cache/huggingface/datasets"

cd /N/slate/jindjia/LLM/data/codeparrot

python download_json.py