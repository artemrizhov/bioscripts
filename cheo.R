#https://cran.r-project.org/web/packages/VennDiagram/VennDiagram.pdf
setwd("~/Desktop/project_cheo/variant_calls/omim")
setwd("~/Desktop/project_cheo/variant_calls/omim/snps")
setwd("~/Desktop/project_cheo/variant_calls/omim/indels")
library("VennDiagram")
venn.plot=draw.pairwise.venn(945+4958,132+4958,4958,
              c("BCBIO","Jacek"),fill=c("blue","red"),lty="blank",
              cex = 2, cat.cex=2, cat.just = list(c(-1,-1),c(1,1)),
              ext.length = 0.3,  ext.line.lwd=2,
              ext.text = F, main="Sdf"
              )
venn.plot=draw.pairwise.venn(46807953, 54328695, 44991414,
                             c("Nimblegen.capture","Agilent"),
                             fill=c("blue","red"),cex=2,cat.cex=2)

venn.plot3=draw.triple.venn(54328695,46807953,65824553,
                            39517373,43777891,44991414,
                            37679751,
                            c("Agilent","Nimblegen.capture","Nimblegen.empirical")
)

venn.plot3=draw.triple.venn(1,2,3,12,23,13,123,
  c("Agilent","Nimblegen.capture","Nimblegen.empirical")
)

#example
for (pipeline in c("genap","bcbio","jacek","cpipe"))
{
  for (sample in c("S1","S2","S4","S5","S6","S7","S8"))
  {
    agilent=unlist(read.table(paste0("S1.",pipeline,".agilent.omim.variants.indels")))
    nimblegen=unlist(read.table(paste0("S1.",pipeline,".nimblegen.omim.variants.indels")))
    #illumina=unlist(read.table(paste0("S1.",pipeline,".illumina.txt")))

    x=list(agilent,nimblegen)
    names=list("Agilent","Nimblegen")
    png(paste0(sample,".",pipeline,".png"))
    grid.draw(venn.diagram(x,NULL,category.names=names))
    dev.off()
  }
}

for (platform in c("agilent","nimblegen"))
{
  for (sample in c("S1","S2","S4","S5","S6","S7","S8"))
  {
    
  #sample="S3"
  #platform="illumina"
  jacek=unlist(read.table(paste0(sample,".jacek.",platform,".omim.variants.indels")))
  cpipe=unlist(read.table(paste0(sample,".cpipe.",platform,".omim.variants.indels")))
  bcbio=unlist(read.table(paste0(sample,".bcbio.",platform,".omim.variants.indels")))
  genap=unlist(read.table(paste0(sample,".genap.",platform,".omim.variants.indels")))

  x=list(jacek,cpipe,bcbio,genap)
  names=list("jacek","cpipe","bcbio","genap")

  png(paste0(sample,".",platform,".png"))
  grid.draw(venn.diagram(x,NULL,category.names=names))
  dev.off()
  }
}

# intersect bed files
# http://davetang.org/muse/2013/01/02/iranges-and-genomicranges/
source("http://bioconductor.org/biocLite.R")
biocLite("GenomicRanges")
library("GenomicRanges")
setwd("coverage/nimblegen")
capture=read.table("nimblegen.capture",header=F)
colnames(capture)=c('chr','start','end')
capture.bed = with(capture, GRanges(chr, IRanges(start+1, end)))

empirical=read.table("nimblegen.empirical",header=F)
colnames(empirical)=c('chr','start','end')
empirical.bed = with(capture, GRanges(chr, IRanges(start+1, end)))

omim=read.table("omim.orphanet.goodnames.v2.bed",header=F)
colnames(empirical)=c('chr','start','end')
omim.bed = with(capture, GRanges(chr, IRanges(start+1, end)))

bed.intersect = intersect(omim.bed,capture.bed)


#bed files
setwd("venn_diagrams/bed_intersection/")
omim=unlist(read.table("omim.orphanet.goodnames.v2.bed.exons"))
agilent=unlist(read.table("omim_vs_agilent.50percent.wo.exons"))
nimblegen=unlist(read.table("omim_vs_nimblegen.capture.50percent.wo.exons"))
illumina=unlist(read.table("omim_vs_illumina.50percent.wo.exons"))

x=list(omim,agilent,nimblegen,illumina)
names=list("omim","agilent","nimblegen","illumina")

grid.draw(venn.diagram(x,NULL,category.names=names))

#variants parameters
type="snps"
type="indels"
for (platform in c("agilent","nimblegen"))
{
  for (sample in c("S1","S2","S4","S5","S6","S7","S8"))
  {
    
    sample="S1"
    platform="agilent"
    cpipe.hom=read.table(paste0(sample,".cpipe.",platform,".omim.",type,".hom.AD"))
    cpipe.het=read.table(paste0(sample,".cpipe.",platform,".omim.",type,".het.AD"))
    
    bcbio.hom=read.table(paste0(sample,".bcbio.",platform,".omim.",type,".hom.AD"))
    bcbio.het=read.table(paste0(sample,".bcbio.",platform,".omim.",type,".het.AD"))
    
    genap.hom=read.table(paste0(sample,".genap.",platform,".omim.",type,".hom.AD"))
    genap.het=read.table(paste0(sample,".genap.",platform,".omim.",type,".het.AD"))

    genap.only = read.table("S1.genap.only.recode.vcf.AD")
    v=c(genap.hom,genap.het,genap.only)
    names=c("genap.hom","genap.het","genap.only")
    
    #indels
    v=c(cpipe.het,bcbio.het,genap.het)
    names=c("cpipe.het","bcbio.het","genap.het")
    
    png(paste0(sample,".",platform,".",type,".png"),width=1000)
    boxplot(v,names=names)
    dev.off()
  }
}

setwd("~/cluster/dorin_test")
b1=read.table("UNIQUE_to_BCBIO_1496461.vcf.AD")
b2=read.table("UNIQUE_to_BCBIO_1496462.vcf.AD")
b3=read.table("UNIQUE_to_BCBIO_1496463.vcf.AD")
g1=read.table("UNIQUE_to_DNASEQ_1496461.vcf.AD")
g2=read.table("UNIQUE_to_DNASEQ_1496462.vcf.AD")
g3=read.table("UNIQUE_to_DNASEQ_1496463.vcf.AD")

v=c(b1,b2,b3,g1,g2,g3)
names=c("b1","b2","b3","g1","g2","g3")

png(paste0(sample,".",platform,".",type,".png"),width=1000)
boxplot(v,names=names)
