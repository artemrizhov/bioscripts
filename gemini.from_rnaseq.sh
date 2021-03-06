#!/bin/bash
#PBS -l walltime=2:00:00,nodes=1:ppn=16
#PBS -joe .
#PBS -d .
#PBS -l vmem=50g,mem=50g

#generated gemini database and text file from bcbio rna-seq pipeline output

if [ -z $sample ]
then
    sample=$1
fi

#gunzip -c combinedrnaedit-annotated.vcf.gz | grep "^#"  > $sample.vcf
#gunzip -c combinedrnaedit-annotated.vcf.gz | grep -v "^#" | grep PASS | grep -v possible_rnaedit  >> $sample.vcf

#bgzip $sample.vcf
#tabix $sample.vcf.gz

#gemini.decompose.sh $sample.vcf.gz
#gemini.vep.sh $sample.decomposed.vcf.gz 
gemini.vep2gemini.sh $sample.decomposed.vepeffects.vcf.gz
gemini.gemini2txt.sh $sample.decomposed.vepeffects.db