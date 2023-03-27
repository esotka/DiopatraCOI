### phylogeny
rm(list=ls())
library(ape)
clade <- read.csv("data/HapCladeAssignment.csv")
tr <- read.nexus(file="data/DiopatraClades_withMyClades_aligned.nex.con.tre")
png("output/tr.png",width=6.5,height=5,units="in",res=500)
par(mar=c(0,0,0,0))
plot(root(tr,outgroup="Nothria_conchylega_HM473514"),cex=.5)
# clade IDs
segments(0.95,9,0.95,14,col="black",lwd=4); text(0.95,11,"cuprea A2",cex=1.5,pos=4)
segments(0.95,15,0.95,17,col="black",lwd=4); text(0.95,16,"cuprea A1",cex=1.5,pos=4)
segments(0.78,18,0.78,30,col="black",lwd=4); text(0.78,24,"cuprea B",cex=1.5,pos=4,col="black")
segments(0.78,31,0.78,32,col="black",lwd=4); text(0.78,31,"cuprea C",cex=1.5,pos=4,col="black")
segments(0.84,33,0.84,34,col="black",lwd=4); text(0.84,33.3,"cuprea D",cex=1.5,pos=4,col="black")
edgelabels("100",edge=c(1,2,7,8,11,14,18,19,28,33,48,51,61),frame = "none",adj = c(.5,-.3),cex=.7) # outgroup
edgelabels("*",edge=c(1,2,7,8,11,19,28,33,48,51,61),frame = "none",adj = c(.5,1),cex=1.5) # outgroup
edgelabels("93",edge=58,frame = "none",adj = c(.5,-.3),cex=.7) 
edgelabels("98",edge=3,frame = "none",adj = c(.5,-.3),cex=.7)
segments(0.1,18,0.182,18)
text(0.14,19,"0.05")
dev.off()
