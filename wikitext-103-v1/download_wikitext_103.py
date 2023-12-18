from datasets import load_dataset
from datasets import disable_caching
from huggingface_hub import hf_hub_download

disable_caching()

train_data = load_dataset('wikitext', name='wikitext-103-v1', split='train')
train_data.to_json("wikitext-103-v1.json", lines=True)  

hf_hub_download(repo_id="gpt2", filename="merges.txt", local_dir='./')
hf_hub_download(repo_id="gpt2", filename="vocab.json", local_dir='./')