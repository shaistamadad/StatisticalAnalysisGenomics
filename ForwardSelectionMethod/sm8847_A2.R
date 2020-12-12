args <- commandArgs(trailingOnly = TRUE)
DataFile= args[1]
Output= args[2]

Data=read.table(file = DataFile, row.names = 1)
Data= t(Data)
Data= as.data.frame(Data)

if (row.names(Data)[1]=="CD14MONO_1"){
  Data$Y= ifelse(grepl("CD14MONO",rownames(Data)),'1','0')
}

if (row.names(Data)[1]=="Naive_16"){
  Data$Y= ifelse(grepl("Naive",rownames(Data)),'1','0')
}


Data$Y= as.factor(Data$Y)

compute.MSE = function(actual, predicted) {
  actual= as.numeric(actual)
  actual= actual-1
  MSE=mean((actual-predicted)^2)
  return(MSE)
}



forward.step= function(D, predictor){
  predictor_null= c("1")
  Label <- "Y"
  predictors  <- append(predictor_null, predictor)
  
  # This creates the appropriate string:
  formula=paste(Label, paste(predictors, collapse=" + "), sep=" ~ ")
  formula=as.formula(formula)
  model= glm(formula, family = binomial(), data= D)
  #print(formula)
  remaining= setdiff(colnames(D), c("Y", predictor))
  mse_list= rep(NA, length= length(remaining)) # will calculate mse for all possible models at each iteration 
  model_history= list(mse_list)  # population with glm models at each iteration 
  model_predictions= list(mse_list) # population with prediction probabilities for each model 
  
  for (i in 1:length(remaining)){
    model_history[[i]]= update(model, ~. + D[, remaining[i]])
    model_predictions[[i]]= predict.glm(model_history[[i]], data= D, type = "response")
    mse_list[i]= compute.MSE(D$Y, model_predictions[[i]])}
  
  index= which.min(mse_list)
  next.feature= remaining[index]
  return(next.feature)
}


feature= c()
iteration=50
for (k in 1: (iteration)){
  select.feature= forward.step(Data, feature)
  feature= append(feature, select.feature)
  
}


# Next write a function for calculating cross validation MSE 

Compute.cvMSE = function(Data, formula, nfolds){
  #Randomly shuffle the data
  Data<-Data[sample(nrow(Data)),]
  
  
  nfolds=nfolds
  
  #Create  n equally size folds
  folds <- cut(seq(1,nrow(Data)),breaks=nfolds,labels=FALSE)
  MSEs= vector("integer", nfolds)
  #Perform nfold  cross validation
  for(i in 1:nfolds){
    #Segment  data by fold using the which() function 
    testIndexes <- which(folds==i,arr.ind=TRUE)
    #print(testIndexes)
    testData <- Data[testIndexes, ]
    #print(testData)
    trainData <- Data[-testIndexes, ]
    #print(trainData)
    
    model.cv= glm(formula, family = binomial(), data = trainData)
    probs.test=predict.glm(model.cv, type= "response", newdata = testData)
    #print(probs.test)
    MSEs[i]=compute.MSE(testData$Y, probs.test)
  }
  
  return(mean(MSEs))
  
}

CV.Likelihood= c()
Label <- "Y"
predictors  <- feature     
for (i in 1:length(predictors)){
  predictors <- feature[1:i]
  # This creates the appropriate string:
  formula=paste(Label, paste(predictors, collapse=" + "), sep=" ~ ")
  formula=as.formula(formula)
  #print(formula)
  model= glm(formula, family = binomial(), data= Data)
  MSE.predictor= Compute.cvMSE(Data, formula, 5)
  CV.Likelihood= append(CV.Likelihood, MSE.predictor)
  
}


## Log likelihood calculation 

log.likelihood= function(predictors, df){
  Y <- "Y"
  formula=paste(Y, paste(predictors, collapse=" + "), sep=" ~ ")
  formula=as.formula(formula)
  model= glm(formula, family = binomial(), data= df)
  predictions= predict(model, type = "response")
  labels= as.numeric(df$Y)-1
  S=(predictions^(labels))* ((1-predictions)^(1-labels))
  S2= prod(S)
  S3= log(S2)
  return(S3)
}

Likelihood= c()
predictors  <- feature     
for (i in 1:length(predictors)){
  predictors <- feature[1:i]
  #print(predictors)
  likelihood.Pred= log.likelihood(predictors, Data)
  Likelihood= append(Likelihood, likelihood.Pred)
}


results.df= data.frame("Iteration" = 1:50, "Predictor"= feature, "CV"= CV.Likelihood, "Log-Likelihood"= Likelihood)

results.df2= results.df[1:50,]
write.table(results.df, file = Output, sep = "\t", quote= FALSE, row.names = FALSE)







