args <- commandArgs(trailingOnly = TRUE)
DataFile= args[1]
Vector= args[2]
OutputVariance= args[3]
OutputPC1= args[4]


Data=read.table(DataFile)
EigenVector= read.table(Vector)


# Write a function that returns the variance
PCAVariance= function(Data, EigenVector){
 # Projected Matrix will be populated with projected PC scores
    ProjectedMatrix= matrix(NA, nrow= nrow(Data), ncol=ncol(Data))

  for (i in 1:nrow(Data)){
    X=as.matrix(Data[i,])%*% as.matrix(EigenVector)
    Y=as.matrix(t(EigenVector)) %*% as.matrix(EigenVector)
    Z= as.numeric(X/Y)
    ProjectedMatrix[i,]= Z*t(EigenVector)
  }
  ProjectedMatrix2= ProjectedMatrix^2
  Variance= (colSums(ProjectedMatrix2))
  VarianceFinal=sum(Variance)/(nrow(Data-1))
  return(VarianceFinal)
}



#The best way to overcome the “minimizer-default” of R is to reverse the function down,
#so that the original minimizer becomes now a maximizer. This is done by changing the sign of the value
#corresponding to the parameter “fnscale”
#t(as.matrix(EigenVector)) %*% as.matrix(EigenVector)


X=optim(par = EigenVector$V1, fn= PCAVariance, Data= Data,control=list(fnscale=-1))



scaling=sqrt(sum(X$par^2))
PC1Final= -X$par/scaling
PC1_DF=as.data.frame(PC1Final)
row.names(PC1_DF)= colnames(Data)
colnames(PC1_DF)=  "PC1"
lengthVector=t(as.matrix(PC1Final))%*% as.matrix(PC1Final) # it is 1
VariancePC1= PCAVariance(Data, PC1Final )

## Write output to file
write.table(VariancePC1, OutputVariance, quote = F,col.names = F, row.names = F)
write.table(PC1_DF, file= OutputPC1,quote = F,col.names = T, row.names = T)
