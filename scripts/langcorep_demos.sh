#!/bin/bash

set -e

DATA_DIR=${HOME}/var/datasets/cliport/raw
DISP=False

echo "Generating dataset... Folder: $DATA_DIR"

# You can parallelize these depending on how much resources you have

#############################
## Language-Conditioned Tasks

# LANG_TASKS='align-rope assembling-kits-seq-seen-colors assembling-kits-seq-unseen-colors packing-shapes packing-boxes-pairs-seen-colors packing-boxes-pairs-unseen-colors packing-seen-google-objects-seq packing-unseen-google-objects-seq packing-seen-google-objects-group packing-unseen-google-objects-group put-block-in-bowl-seen-colors put-block-in-bowl-unseen-colors stack-block-pyramid-seq-seen-colors stack-block-pyramid-seq-unseen-colors separating-piles-seen-colors separating-piles-unseen-colors towers-of-hanoi-seq-seen-colors towers-of-hanoi-seq-unseen-colors'
LANG_TASKS='packing-seen-google-objects-group'
MODE='train val test'

for task in $LANG_TASKS; do
    for mode in $MODE; do
        python ${CLIPORT_ROOT}/cliport/demos.py n=10  \
            task=$task mode=$mode data_dir=$DATA_DIR disp=$DISP \
            record.save_video="True" record.fps=10 record.add_text="True"
    done
done

echo "Finished Language Tasks."
