#!/bin/bash

muscle -in $1 -out _tmp.fa;
align2fasta.pl _tmp.fa > $1.aln;
rm _tmp.fa;

python ~/bioscripts/muscle.stabilize.py $1 $1.aln > $1.stab

rm $1.aln
mv $1.stab `echo $1 | sed s/fasta/align.fasta/`;