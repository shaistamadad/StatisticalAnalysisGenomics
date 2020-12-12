args <- commandArgs(trailingOnly = TRUE)
DataFile= args[1]
Vector= args[2]
OutputVariance= args[3]
OutputPC= args[4]


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
  VarianceFinal=sum(Variance)/(nrow(Data)-1)
  return(VarianceFinal)
}



#The best way to overcome the “minimizer-default” of R is to reverse the function down,
#so that the original minimizer becomes now a maximizer. This is done by changing the sign of the value
#corresponding to the parameter “fnscale”
#t(as.matrix(EigenVector)) %*% as.matrix(EigenVector)

X=optim(par = EigenVector$V1, fn= PCAVariance, Data= Data,control=list(fnscale=-1))

scaling=sqrt(sum(X$par^2))
PC1= -X$par/scaling
PCs_DF=as.data.frame(PC1)
row.names(PCs_DF)= colnames(Data)
lengthVector=t(as.matrix(PC1))%*% as.matrix(PC1) # it is 1
VariancePC1= PCAVariance(Data, PC1 )
DF_Variances= as.data.frame(VariancePC1)


## To get PC2
## Project the PC1 vector onto the orginal dataset

Data_PC1= matrix(NA, nrow= nrow(Data), ncol=ncol(Data))

for (i in 1:nrow(Data)){
  X=as.matrix(Data[i,])%*% as.matrix(PC1)
  Y=as.matrix(t(PC1)) %*% as.matrix(PC1)
  Z= as.numeric(X/Y)
  Data_PC1[i,]= Z*t(PC1)
}

## Now substract this PC1 projection from original data

DataforPC2= Data- Data_PC1

## Now find the PC2 variance and vector
XX=optim(par = EigenVector$V1, fn= PCAVariance, Data= DataforPC2,control=list(fnscale=-1))

scaling2=sqrt(sum(XX$par^2))
PC2Final= -XX$par/scaling2
lengthVector2=t(as.matrix(PC2Final))%*% as.matrix(PC2Final) # it is 1
VariancePC2= PCAVariance(Data, PC2Final )

## Add the PC2 variance and vector to the variance and PCs_DF dataframes respectively
PCs_DF$PC2= PC2Final
DF_Variances$VariancePC2= VariancePC2

### Calculation for PC3######
##first project the PC2 onto the original dataset

Data_PC2= matrix(NA, nrow= nrow(Data), ncol=ncol(Data))

for (i in 1:nrow(Data)){
  X=as.matrix(Data[i,])%*% as.matrix(PC2Final)
  Y=as.matrix(t(PC2Final)) %*% as.matrix(PC2Final)
  Z= as.numeric(X/Y)
  Data_PC2[i,]= Z*t(PC2Final)
}

## Substract PC1 and PC2 projected data from the original data
DataforPC3= Data- Data_PC1- Data_PC2

## Now find the PC2 variance and vector
XXX=optim(par = EigenVector$V1, fn= PCAVariance, Data= DataforPC3,control=list(fnscale=-1))

scaling3=sqrt(sum(XXX$par^2))
PC3Final= XXX$par/scaling3
lengthVector3=t(as.matrix(PC3Final))%*% as.matrix(PC3Final) # it is 1
VariancePC3= PCAVariance(Data, PC3Final )

## Add the PC2 variance and vector to the variance and PCs_DF dataframes respectively
PCs_DF$PC3= PC3Final
DF_Variances$VariancePC3= VariancePC3

PC= prcomp(Data)
#PC$sdev^2   variances match


## Write out to output files

## Write output to file
write.table(DF_Variances, file= OutputVariance, quote = F,col.names = F, row.names = F)
write.table(PCs_DF, file=OutputPC ,quote = F,col.names = T, row.names = T)

