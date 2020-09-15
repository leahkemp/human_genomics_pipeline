#!/bin/bash -x

snakemake \
-j 4 \
--resources gpu=2 \
--use-conda \
--conda-frontend mamba \
--configfile ../config/config.yaml