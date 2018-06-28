data=matrix(0,nrow=6, ncol=5)
data[,1]=c(0,5,20,5,0,0)
data[,2]=c(2,6,10,12,0,0)
data[,3]=c(3,7,7,5,4,4)
data[,4]=c(4,0,0,13,7,7)
data[,5]=c(8,0,0,0,11,11)

colnames(data)=c("A","B", "C","D","E")
row.names(data)=c("OTU1", "OTU2", "OTU3", "OTU4", "OTU5", "OTU6")

library(vegan)
library(calibrate)

data.bc=vegdist(t(data), method="bray")
data.pcoa=cmdscale(data.bc, eig=TRUE)
#calculate percent variance explained, then add to plot
ax1.v=data.pcoa$eig[1]/sum(data.pcoa$eig)
ax2.v=data.pcoa$eig[2]/sum(data.pcoa$eig)
plot(data.pcoa$points[,1],data.pcoa$points[,2] ,cex=1.5,pch=21,main="Bray-Curtis M&M PCoA",xlab= paste("PCoA1: ",100*round(ax1.v,3),"% var. explained",sep=""), ylab= paste("PCoA2: ",100* round(ax2.v,3),"% var. explained",sep=""))
textxy(X=data.pcoa$points[,1], Y=data.pcoa$points[,2],labs=colnames(data), cex=1)

