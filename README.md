# bioscripts - scripts I am using on a daily basis

## Differential expression

* dexpression.katie.R - edgeR DE, batch effect correction, pheatmap, GO, pathways
* star.mapping.sh - 2PASS STAR alignment

## Gemini staff - for CHEO, MH, and Muscular projects

* gemini.decompose.sh - decompose and normalize variants with vt
* gemini.vep.sh - annotate vcf file with VEP
* gemini.vep2gemini.sh - load VEP annotated vcf to the GEMINI database
* gemini.gemini2txt.sh - dump a gemini database into txt file with decompressed genotypes
* gemini.gemini2report.R  - create a nice report for import to excel from the gemini.txt dump

## Variants

* vcf.validate.sh - validate variant calls with Genome in a bottle callset using RTG vcfeval tool
* [VT: biallelic sites decomposition](https://github.com/atks/vt)
* [RTG: accurate vcf comparison](https://github.com/RealTimeGenomics/rtg-tools)

## Alignments

* alignment.av_pw_dist.pl - average pairwise distances between sequences in an alignment, and distance matrix

* alignment.check_3x.sh

* alignment.consensus.2seq.pl

* alignment.consensus.pl

* alignment.count_nongappy_columns.sh

* alignment.detect_stops.pl

* alignment.fa2fasta.pl

* alignment.sort_by_id.pl