#!/usr/bin/env bash

export PYTHONNOUSERSITE=1

if [[ $1 = "cuda" || $1 = "CUDA" ]]; then
  bin/micromamba create -f environments/huggingface.yml -r runtime -n koboldai -y
  # Weird micromamba bug causes it to fail the first time, running it twice just to be safe, the second time is much faster
  bin/micromamba create -f environments/huggingface.yml -r runtime -n koboldai -y

  exit
fi

if [[ $1 = "rocm" || $1 = "ROCM" ]]; then
  bin/micromamba create -f environments/rocm.yml -r runtime -n koboldai-rocm -y
  # Weird micromamba bug causes it to fail the first time, running it twice just to be safe, the second time is much faster
  bin/micromamba create -f environments/rocm.yml -r runtime -n koboldai-rocm -y

  exit
fi

echo 'Please specify either CUDA or ROCM.'
