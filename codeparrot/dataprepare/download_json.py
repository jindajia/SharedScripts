from datasets import load_dataset
from datasets import disable_caching

disable_caching()

train_data = load_dataset('codeparrot/codeparrot-clean-train', split='train')
train_data.to_json("codeparrot_data.json", lines=True)  