#!/bin/bash
#SBATCH --job-name=fastqc
#SBATCH --partition=main
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --output=workflow/fastqc_%j.log
#SBATCH --error=workflow/fastqc_%j.err

cd ~/homework3
source ~/my_bashrc
source ~/miniconda3/etc/profile.d/conda.sh
conda activate snakemake
snakemake -s workflow/Snakefile --cores 8
