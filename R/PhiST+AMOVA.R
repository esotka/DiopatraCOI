### PhiST 
# by population

rm(list=ls())
dat <- strataG::read.fasta("data/co1.out.aligned.fas")
meta <- data.frame(id=names(dat),pop=substr(names(dat),1,5),COI=names(dat))
meta$pop[meta$pop%in%c("SC.DN","SC.GB")] = "SC.CH"
meta$pop[meta$pop%in%c("NC.MV","NC.NR")] = "NC.BE"
tmp <- data.frame(pop=c("FL.AM","FL.CL","FL.FP","FL.ST","MA.BA","MA.DU","MA.WE","NC.BE","SC.BA","SC.CH","VA.WA"),
                num=c("04","03","02","01","09","11","10","07","05","06","08"))
tmp$numpop <- paste(tmp$num,tmp$pop,sep="_")
meta$pop <- tmp$numpop[match(meta$pop,tmp$pop)]
#reg=substr(meta$pop,1,2)
dat.g <- df2gtypes(meta[c("id","pop","COI")],ploidy=1,sequences=dat)

nucD <- nucleotideDivergence(dat.g)
print(nucD$within)
print(nucD$between)
print(ovl <- overallTest(dat.g))
pws <- pairwiseTest(dat.g)
pws.matrix <- pairwiseMatrix(pws,"PHIst")
#pws.matrix <- pws.matrix[c(4,3,2,1,10,9,8,11,5,7,6),c(4,3,2,1,10,9,8,11,5,7,6)] # reorder
write.csv(round(pws.matrix,3),"output/PHIst_pop.csv",quote=F)
pws.sum <- pairwiseSummary(pws)

# by region
tmp <- tmp[order(tmp$num),]
tmp$reg <- c("1FL-Gulf","2FL-Atlantic","2FL-Atlantic","3FL-SC-NC","3FL-SC-NC","3FL-SC-NC","3FL-SC-NC","3FL-SC-NC","4MA","4MA","4MA")
meta$reg <- tmp$reg[match(meta$pop,tmp$numpop)]

dat.g <- df2gtypes(meta[c("id","reg","COI")],ploidy=1,sequences=dat)
print(overallTest(dat.g))
pws <- pairwiseTest(dat.g)
pws.matrix <- pairwiseMatrix(pws,"PHIst")
write.csv(round(pws.matrix,3),"output/PHIst_reg.csv",quote=F)

