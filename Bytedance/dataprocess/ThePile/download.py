from datasets import load_dataset
from datasets import disable_caching
from datasets import load_dataset_builder
from huggingface_hub import hf_hub_download
import os
import json
import time

# directory you want to save the pile.jsonl (e.g. /data/thepile)
save_path = "..path"
# specify the file name you want to use (e.g. pile.jsonl)
dataset_output_name = 'pile.jsonl'

train_data = load_dataset('EleutherAI/the_pile_deduplicated', split='train', num_proc=16)

start_time = time.time()

train_data.to_json(os.path.join(save_path, dataset_output_name),  lines=True)

end_time = time.time()
print(f"Save as jsonl finished. Elapsed time: {end_time - start_time:.4f} seconds")

# download merges.txt and vocab.json from gpt2 repository in huggingface (https://huggingface.co/gpt2)
hf_hub_download(repo_id="gpt2", filename="merges.txt", local_dir=os.path.join(save_path, 'c4'))
hf_hub_download(repo_id="gpt2", filename="vocab.json", local_dir=os.path.join(save_path, 'c4'))