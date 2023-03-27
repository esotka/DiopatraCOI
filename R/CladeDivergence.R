## nucleotide divergence
dat <- read.FASTA("data/DiopatraClades_withMyClades_aligned.fas")
meta <- read.csv("data/HapCladeAssignment.csv")

dat2 <- dat[names(dat)%in%c("Hap_3","Hap_7","Hap_1","Hap_2","Hap_6")]
names(dat2) <- meta$HaplotypeSubgroups[match(names(dat2),meta$Hap)]
dat3 <- dat2[order(names(dat2))]
print(dist.dna(dat3))
write.csv(as.matrix(dist.dna(dat3)),"output/CladeDivergence.csv")
