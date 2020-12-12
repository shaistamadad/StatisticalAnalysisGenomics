args <- commandArgs(trailingOnly = TRUE)
DataFile= args[1]
Vector= args[2]
Output= args[3]

Data=read.table(DataFile)
EigenVector= read.table(Vector)


X=as.matrix(Data[1,])%*% as.matrix(EigenVector)
Y=as.matrix(t(EigenVector)) %*% as.matrix(EigenVector)
Z= as.numeric(X/Y)

#Z*as.matrix(t(EigenVector))
Final=Z*t(EigenVector)
#dim(Final)
ProjectedMatrix= matrix(NA, nrow= nrow(Data), ncol=ncol(Data))

for (i in 1:nrow(Data)){
  X=as.matrix(Data[i,])%*% as.matrix(EigenVector)
  Y=as.matrix(t(EigenVector)) %*% as.matrix(EigenVector)
  Z= as.numeric(X/Y)
  ProjectedMatrix[i,]= Z*t(EigenVector)
}
ProjectedMatrix2= ProjectedMatrix^2
Variance= (colSums(ProjectedMatrix2))
VarianceFinal=sum(Variance)/(nrow(Data)-1)
write.table(VarianceFinal,Output, quote = F,col.names = F, row.names = F)


