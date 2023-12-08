#!/bin/bash

set -x
MASTER_PORT=6000
WORLD_SIZE=$(($GPUS_PER_NODE*$NNODES))
NODE_RANK=$SLURM_NODEID

VOCAB_FILE=/ocean/projects/asc200010p/jjia1/data/codeparrot_copy/gpt2-vocab.json
MERGE_FILE=/ocean/projects/asc200010p/jjia1/data/codeparrot_copy/gpt2-merges.txt
DATA_PATH=/ocean/projects/asc200010p/jjia1/data/codeparrot_copy/codeparrot_content_document
TENSORBOARD_DIR=$BASE_DIR/tensorboard
CHECKPOINT_PATH=$BASE_DIR/checkpoint
COLLECTIVE_PATH=$BASE_DIR/collective

DISTRIBUTED_ARGS="
    --nproc_per_node $GPUS_PER_NODE \
    --nnodes $NNODES \
    --node_rank $NODE_RANK \
    --master_addr $MASTER_ADDR \
    --master_port $MASTER_PORT
"

GPT_ARGS="
    --tensor-model-parallel-size 4 \
    --pipeline-model-parallel-size 1 \
    --num-layers 12 \
    --hidden-size 768 \
    --num-attention-heads 12 \
    --seq-length 1024 \
    --max-position-embeddings 1024 \
    --micro-batch-size 24 \
    --global-batch-size 192 \
    --lr 0.0005 \
    --train-iters 150000 \
    --lr-decay-iters 150000 \
    --lr-decay-style cosine \
    --weight-decay .1 \
    --lr-warmup-iters 2000 \
    --clip-grad 1.0 \
    --fp16
"

DATA_ARGS="
    --data-path $DATA_PATH \
    --vocab-file $VOCAB_FILE \
    --merge-file $MERGE_FILE
"

OUTPUT_ARGS="
    --log-interval 20 \
    --timing-log-level 2 \
    --save-interval 1000 \
    --eval-interval 500 \
    --eval-iters 10 \
    --log-timers-to-tensorboard \
    --tensorboard-dir ${TENSORBOARD_DIR} \
    --tensorboard-log-interval 1
"


cd /ocean/projects/asc200010p/jjia1/Developer/Megatron-tp-compression/Megatron-LM

torchrun $DISTRIBUTED_ARGS pretrain_gpt.py \
    $GPT_ARGS \
    $DATA_ARGS \
    $OUTPUT_ARGS \
    --distributed-backend nccl \
    --save $CHECKPOINT_PATH \
    --load $CHECKPOINT_PATH