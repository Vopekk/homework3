#!/bin/bash
set -e

BASE=https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_50

mkdir -p reference/genome reference/annotation reference/transcriptome

if [ ! -s reference/genome/GRCh38.primary_assembly.genome.fa ]; then
    wget -P reference/genome $BASE/GRCh38.primary_assembly.genome.fa.gz
    gunzip reference/genome/GRCh38.primary_assembly.genome.fa.gz
fi

if [ ! -s reference/annotation/gencode.v50.primary_assembly.annotation.gtf ]; then
    wget -P reference/annotation $BASE/gencode.v50.primary_assembly.annotation.gtf.gz
    gunzip reference/annotation/gencode.v50.primary_assembly.annotation.gtf.gz
fi

if [ ! -s reference/transcriptome/gencode.v50.transcripts.fa.gz ]; then
    wget -P reference/transcriptome $BASE/gencode.v50.transcripts.fa.gz
fi

# check that all files exist and are not empty
for f in reference/genome/GRCh38.primary_assembly.genome.fa \
         reference/annotation/gencode.v50.primary_assembly.annotation.gtf \
         reference/transcriptome/gencode.v50.transcripts.fa.gz
do
    if [ ! -s "$f" ]; then
        echo "ERROR: missing or empty file: $f"
        exit 1
    fi
done

echo "All reference files are ready."
