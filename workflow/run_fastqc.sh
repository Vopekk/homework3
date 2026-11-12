#!/bin/bash
#SBATCH --job-name=fastqc
#SBATCH --partition=main
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G

cd ~/homework3
source ~/miniconda3/etc/profile.d/conda.sh
conda activate snakemake
snakemake -s workflow/Snakefile --cores 8
