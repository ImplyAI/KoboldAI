#!/usr/bin/env bash

export PYTHONNOUSERSITE=1

git submodule update --init --recursive

micromamba_version='1.0.0' # https://github.com/mamba-org/boa-forge/releases

if [[ $1 = "cuda" || $1 = "CUDA" ]]; then
  # https://mamba.readthedocs.io/en/latest/installation.html#linux-and-macos
  wget -qO- "https://micromamba.snakepit.net/api/micromamba/linux-64/${micromamba_version}" | tar -xvj bin/micromamba

  bin/micromamba create -f environments/huggingface.yml -r runtime -n koboldai -y
  # Weird micromamba bug causes it to fail the first time, running it twice just to be safe, the second time is much faster
  bin/micromamba create -f environments/huggingface.yml -r runtime -n koboldai -y

  exit
fi

if [[ $1 = "rocm" || $1 = "ROCM" ]]; then
  # https://mamba.readthedocs.io/en/latest/installation.html#linux-and-macos
  wget -qO- "https://micromamba.snakepit.net/api/micromamba/linux-64/${micromamba_version}" | tar -xvj bin/micromamba

  bin/micromamba create -f environments/rocm.yml -r runtime -n koboldai-rocm -y
  # Weird micromamba bug causes it to fail the first time, running it twice just to be safe, the second time is much faster
  bin/micromamba create -f environments/rocm.yml -r runtime -n koboldai-rocm -y

  exit
fi

echo 'Please specify either CUDA or ROCM.'
