# MAP and haplotype pie charts
rm(list=ls())
library(maps); library(mapdata); library(readxl); library(plotrix);library(colorRamps)
meta <- read_xlsx("data/meta.pop.xlsx")
dat <- read.csv("data/co1.out.uniq.csv")
clade <- read.csv("data/HapCladeAssignment.csv")
dat$clade <- clade$HaplotypeSubgroups[match(dat$hap,clade$Hap)]
dat$pop <- substr(dat$ind,1,5)  
dat$pop[dat$pop%in%c("SC.DN","SC.GB")] = "SC.CH"
dat$pop[dat$pop%in%c("NC.MV","NC.NR")] = "NC.BE"
out <- table(dat$pop,dat$clade)
write.csv(out,"data/HapClade_summary.csv",quote=F)
latlon <- meta[match(rownames(out),meta$ID),c("Latitude","Longitude")]

lon.pie <- c(
  -79,
  -78.11834,     
  -77.38851, 
  -86.5,
  -68.63052,
  -65.71119,
  -65.60693,
  -70.71575,
  -75.5,
  -76.65868,
  -70.29871)
lat.pie <- c(
  30.3,
  28.55638, 
  26.71164,
  27.61921, 
  39.80249,
  42.95480, 
  41,
  35.03141,
  33.5,
  31.70870,
  37.16136
)

png('output/Map+HaplotypePies.png',width=6,height=5,units="in",res=500)
map(database = 'state',xlim=c(-88,-60),ylim=c(26,45),bg="lightsteelblue1",fill=T,col="white",cex=.2)
map("worldHires","Canada",add=TRUE,col="white",fill=TRUE)
box()
points(latlon$Longitude,latlon$Latitude,cex=2,pch=20)
cols.to.use <- grey.colors(5,start = 1,end=0)#blue2red(5)#c("red","black","darkgrey","lightgrey","white")
for (i in 1:dim(out)[1])
{
  segments(lon.pie[i],lat.pie[i],latlon$Longitude[i],latlon$Latitude[i])
  floating.pie(lon.pie[i],lat.pie[i],out[i,],radius=1,col=cols.to.use)
}
text(x=lon.pie+.5,y=lat.pie,rownames(out),cex=.6,pos=4)
legend(x=-68,y=33,fill=cols.to.use,legend = c("A1","A2","B","C","D"))

dev.off()
