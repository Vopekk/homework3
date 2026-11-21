RNA-seq Analysis Project

Description:
	RNA-seq analysis of human airway smooth muscle cells using a reproducible
Snakemake workflow.

Organism:
	Homo sapiens

Reference genome:
	GRCh38 (GENCODE relese 50)

Samples:
	SRR1039512	GSM1275866	untreated	Control 
	SRR1039508	GSM1275862	untreated	Control
	SRR1039517	GSM1275871	Dexamethasone	Treatment
	SRR1039518	GSM1275872	Albuterol	Treatment

Publications:
	Authors: Blanca E. Himes et al.
	Publication date: 2014-06-13
	Journal: PLOS ONE, Volume 9, Issue 6, Article e99625
	Title: RNA-Seq Transcriptome Profiling Identifies CRISPLD2
		as a Glucocorticoid Responsive Gene that Modulates Cytokine
	Function in Airway Smooth Muscle Cells
	DOI: 10.1371/journal.pone.0099625

Project structure:
	config/config.yaml	samples, paths and parameters
	workflow/Snakefile	the worklow
	workflow/run_rnaseq.sh	SLURM script
	envs/			Conda environments
	raw_data/fastq		raw sequencing data
	reference/		genome, annotation, transcriptome and indexes
	results/		all results
	logs/			program logs

Workflow:
	1. Read preprocessing: FastQC, fastp, FASTQC
	2. Alignment-based quantification: HISAT2 index, HISAT2 alignment
		samtools sort/index, featureCounts
	3. Alignment-free quantification: kallisto index, kallisto quant
	4. Alignment quality assessent: RSeQC, deepTools
	5. Reporting: MultiQC report

Tools:
	Snakemake, Conda, Git, SLURM, FastQC, fastp, HISTA2, samtools,
	featureCOunts, kallisto, RSeQC, deepTools, MultiQC, IGV

Reference files:
	Downloaded from GENCODE (human, release 50, GRCh38) with:
		bash scripts/download_references.sh
	This creates:
		reference/genome/GRCh38.primary_assembly.genome.fa
		reference/annotation/gencode.v50.primary_assembly.annotation.gtf
 		reference/transcriptome/gencode.v50.transcripts.fa.gz
	The genome and GIF are unzipped.


Configuration:
	All settings are in config/config.yaml, so the Snakefile does not
	need to be changed. The file contains:
		1. The list of sample names
		2. The paths to the FASTQ files
		3. The paths to the reference files and indexes
		4. The paths to the reference files nd indexes
		5. The strandedness setting for featureCounts

How to run:
	1. conda activate snakemake
	2. Dry run:
		snakemake -s workflow/Snakefile --cores 8 --use-conda -n
	3. Run on SLURM
		sbatch workflow/run_rnaseq.sh

Main outputs:
	results/featurecounts/counts.txt	gene counts
	results/kallisto/<sample>abundance.tsv	transcript bundances
	results/rseqc/				RSeQC results
	results/deeptools/			correlation and PCA
	results/multiqc/multiqc_report.html	combined report

Notes:
	Gene body coverage and inner distance use a random subset
	 of bed_subset_size transcripts (fixed seed), because the full
	 gene model was too slow

