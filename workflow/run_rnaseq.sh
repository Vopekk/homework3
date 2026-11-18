#!/bin/bash
#SBATCH --job-name=rnaseq
#SBATCH --partition=main
#SBATCH --cpus-per-task=8
#SBATCH --mem=48G
#SBATCH --time=04:00:00
#SBATCH --output=workflow/rnaseq_%j.log
#SBATCH --error=workflow/rnaseq_%j.err

cd ~/homework3
source ~/my_bashrc
source ~/miniconda3/etc/profile.d/conda.sh
conda activate snakemake
snakemake -s workflow/Snakefile --cores 8 --use-conda
