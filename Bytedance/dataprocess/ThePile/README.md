## Preprocess

Because The pile is a huge dataset, using the preprocess tool provided by MegatronLM (https://github.com/NVIDIA/Megatron-LM/blob/main/tools/preprocess_data.py) is slow.

So I used a distributed preprocess tool provided by adammoody on (https://github.com/NVIDIA/Megatron-LM/issues/492).

I already copy it to my github repository in jinda/data_preprocess branch. Check it out here (https://github.com/jindajia/Megatron-LM/tree/jinda/data_preprocess). You can clone this branch and use the bash script(process_dataset_dist.sh) in this folder to process the pile dataset. 

## Package requirements

datasets (https://huggingface.co/docs/datasets/installation)
transformers (https://huggingface.co/docs/transformers/installation)
