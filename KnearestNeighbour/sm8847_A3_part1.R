args <- commandArgs(trailingOnly = TRUE)
DataFile= args[1]
clusterIDs= args[2]
Output= args[3]



Data=read.table(file = DataFile , row.names = 1)
Data= t(Data)
Data= as.data.frame(Data)
clusters=read.table(file = clusterIDs )


Kmeans.Cost= function(df, centroids,clusters){
  n= nrow(df)
  k= nrow(centroids)  # each k represents one cluster 
  
  # Compute the distance between every data point and the associated centroid 
  distances= matrix(data= NA, nrow = n, ncol = 1)
  for (i in 1:k){
    select.i= which(clusters== i)
    samples= df[select.i,]
    centroid= centroids[i,]
    genes= matrix(data= NA, nrow =nrow(samples), ncol = 1)
    for (j in 1:nrow(samples)){
      x= rbind(samples[j,], centroid)
      dis= dist(x)
      #genes[j,]= sum((samples[j,]-centroid)^2)
      genes[j,]= dis
    }
    
    #print(genes)
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
  centroids= matrix(data= NA, nrow = k, ncol = ncol(Data))
  for (i in 1:k){
    
    select.i=which(init.clusters==i)
    samples= df[select.i,]
    centroids[i,]= colMeans(samples)
    
    
  }
  
  
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
      for (j in 1: k){
        x= rbind(df[i,], centroids[j,])
        dis[j,]= dist(x)
      }
      clusters[i,]= which.min(dis)
    }
    
    
    # Check for convergence
    if(all(clusters== previous)){
      converged= TRUE
    }
    
  }
  final= Kmeans.Cost(df, centroids,clusters)
  clusters$V1= as.integer(clusters$V1)
  
  # Return results, clusters and objective function value 
  results= rbind(clusters, final)
  
  return(results)
}

X= Kmeans(Data, clusters, 7)

write.table(X, file = Output, sep = "\t", quote= FALSE, row.names = FALSE, col.names = FALSE)

