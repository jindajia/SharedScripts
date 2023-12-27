## File structure
  - download_dataset.sh (slurm running script for download.py)
  - download.py (download dataset from huggingface, transfer it to jsonl format)
  - process_dataset_dist.sh (tokenize dataset, and store it with binary format which can be used by MegatronLM)

To create the pile dataset available for MegatronLM, you should **1) first run download_dataset.sh** to create josnl format the pile datset, then excute **process_dataset_dist.sh** to convert it to the format can be used by MegatronLM directly.


## Download

To download the pile dataset, you need to have a disk size bigger than 1.4T. By default, load_datasets() will download the dataset first to the  **~/.cache/huggingface/datasets** , so you need to change this path point to a directory with a bigger storage. You can accomplish this by 
1) export HF_DATASETS_CACHE="/path/to/another/directory" or 
2) load_dataset('LOADING_SCRIPT', cache_dir="PATH/TO/MY/CACHE/DIR") \
more information can be found here https://huggingface.co/docs/datasets/cache#cache-directory

(**Note**: load_dataset() and to_json() function can use multi processors to increase process speed, more info can be found here https://huggingface.co/docs/datasets/package_reference/loading_methods#datasets.load_dataset.num_proc and https://huggingface.co/docs/datasets/v2.15.0/en/package_reference/main_classes#datasets.Dataset.to_json)

## Preprocess

Because The pile is a huge dataset, using the preprocess tool provided by MegatronLM (https://github.com/NVIDIA/Megatron-LM/blob/main/tools/preprocess_data.py) is slow.

So I used a distributed preprocess tool provided by adammoody on (https://github.com/NVIDIA/Megatron-LM/issues/492).

I already copy it to my github repository in jinda/data_preprocess branch. Check it out here (https://github.com/jindajia/Megatron-LM/tree/jinda/data_preprocess). You can clone this branch and use the bash script(process_dataset_dist.sh) in this folder to process the pile dataset. 

## Package requirements

datasets (https://huggingface.co/docs/datasets/installation) \
transformers (https://huggingface.co/docs/transformers/installation) \
huggingface_hub (https://huggingface.co/docs/huggingface_hub/installation)
