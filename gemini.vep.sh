#/bin/bash

#gemini.vcf2vep - annotate vcf with vep before loading gemini database
#based on  bcbio.log

#PBS -l walltime=2:00:00,nodes=1:ppn=16
#PBS -joe .
#PBS -d .
#PBS -l vmem=50g,mem=50g

bname=`echo $1 | sed s/.vcf.gz//`

unset PERL5LIB && export PATH=/hpf/largeprojects/ccmbio/naumenko/tools/bcbio/anaconda/bin:$PATH && /home/naumenko/work/tools/bcbio/anaconda/bin/variant_effect_predictor.pl --vcf -o stdout \
    -i $1 --species homo_sapiens --no_stats --cache --offline --dir /hpf/largeprojects/ccmbio/naumenko/tools/bcbio/genomes/Hsapiens/GRCh37/vep --symbol --numbers --biotype --total_length \
    --canonical --gene_phenotype --ccds --fields Consequence,Codons,Amino_acids,Gene,SYMBOL,Feature,EXON,PolyPhen,SIFT,Protein_position,BIOTYPE,CANONICAL,CCDS,HGVSc,HGVSp \
    --plugin LoF,human_ancestor_fa:/hpf/largeprojects/ccmbio/naumenko/tools/bcbio/genomes/Hsapiens/GRCh37/variation/human_ancestor.fa.gz --sift b --polyphen b --hgvs --shift_hgvs 1 \
    --fasta /hpf/largeprojects/ccmbio/naumenko/tools/bcbio/genomes/Hsapiens/GRCh37/seq/GRCh37.fa --pick | sed '/^#/! s/;;/;/g' | bgzip -c > $bname.vepeffects.vcf.gz

tabix $bname.vepeffects.vcf.gz