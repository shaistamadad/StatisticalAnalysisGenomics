args <- commandArgs(trailingOnly = TRUE)
DataFile= args[1]
Output= args[2]

Data=read.table(file = DataFile, row.names = 1)
Data= t(Data)
Data= as.data.frame(Data)
Kmeans.Cost= function(df, centroids,clusters){
  n= nrow(df)
  k= nrow(centroids)  # each k represents one cluster
  # in case no point is assigned to a cluster, set a very high value for all features means for that centroid so euclidean distance for each point will be too high, hence this centroid won't be chosen 
  for (i in 1:nrow(centroids))
    if(is.na(centroids[i,][1])){
      centroids[i,]= 100
    }
  
  # Compute the distance between every data point and the associated centroid 
  distances= matrix(data= NA, nrow = n, ncol = 1)
  for (i in 1:k){
    select.i= which(clusters== i)
    if(is.na(select.i[1])){
      samples= matrix(data= 100, nrow = 1,ncol = ncol(df))
      samples= as.data.frame(samples)
      colnames(samples)= colnames(df)
    }
    else{
      samples= df[select.i,]}
    centroid= centroids[i,]
    genes= matrix(data= NA, nrow =nrow(samples), ncol = 1)
    for (j in 1:nrow(samples)){
      x= rbind(samples[j,], centroid)
      distance= dist(x)
      genes[j,]= distance
    }
    
    # distance to centroids
    distances[select.i,]= genes
  }
  #print(distances)
  
  return(mean(distances))
}



#Kmeans.Cost(Data, centroids, clusters)


### K-means Function 

Kmeans= function(df,init.clusters,k){
  # Define the number of samples (n) and features (p)
  n= nrow(df)
  p= ncol(df)
  
  # Start with given initial clustering 
  clusters= init.clusters
  
  
  # initialize centroids 
  centroids= matrix(data= NA, nrow = k, ncol = ncol(df))
 # for (i in 1:k){
    
    #select.i=which(init.clusters==i)
    #samples= df[select.i,]
    #centroids[i,]= colMeans(samples)
    
    
  #}
  
  
  # # Repeat until convergence 
  converged= FALSE
  while(!converged){
    # keep track of clusters from last iteration 
    previous= clusters
    # Compute the cluster centroid (average of each feature for each cluster)
    for (i in 1:k){
      
      select.i=which(clusters==i)
      samples= df[select.i,]
      centroids[i,]= colMeans(samples)
          }
    
    # Assign data points to clusters based on nearest centroid 
    for ( i in 1:nrow(df)){
      dis= matrix(NA, nrow = k, ncol = 1)
      for (j in 1:k){
        if(is.na(centroids[j,][1])){
          dis[j,]= 100
        }
        else{
          x= rbind(df[i,], centroids[j,])
          
          dis[j,]= dist(x)}
      }
      #print(dis)
      clusters[i]= which.min(dis)
    }
    
    
    # Check for convergence
    if(all(clusters== previous)){
      converged= TRUE
    }
    
  }
  final= Kmeans.Cost(df, centroids,clusters)
  
  # Return results, clusters and objective function value 
  results= c(clusters, final)
  
  return(results)
}

# intiliase two matrices: one for 25 random clusterlabelling, one to record the final labels and objective function for each of the 25 random initialisations 
clusterLables <- matrix(nrow = 25, ncol = nrow(Data))
finalLabels_CF <- matrix(nrow = 25 , ncol = nrow(Data) + 1)

#labels= sample(x = 1:7,replace = T, size = nrow(Data))
#Kmeans(Data, labels,7)
# get 25 random cluster labels 

for (i in 1:nrow(clusterLables)){
  clusterLables[i,] <- sample(x = 1:7,replace = T, size = nrow(Data))
  
 
}

# Get final cluster labels and objective cost function 

for (i in 1:nrow(clusterLables)){
 finalLabels_CF[i,]=Kmeans(Data, clusterLables[i,], 7)
}

X=finalLabels_CF[which.min(finalLabels_CF[,ncol(finalLabels_CF)]),]



write.table(X, file = Output, sep = "\t", quote= FALSE, row.names = FALSE, col.names = FALSE)


