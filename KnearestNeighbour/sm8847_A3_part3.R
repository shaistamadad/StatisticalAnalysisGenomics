args <- commandArgs(trailingOnly = TRUE)
DataFile= args[1]
Output= args[2]


Data=read.table(file = DataFile, row.names = 1)
Data= t(Data)
Data= as.data.frame(Data)



Kmeans.Cost= function(df, centroids,clusters){
  n= nrow(df)
  k= nrow(centroids)  # each k represents one cluster
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
      #print(distance)
      #genes[j,]= sum((samples[j,]-centroid)^2)
      genes[j,]= distance
    }
    
    #print(genes)
    # distance to centroids
    distances[select.i,]= genes
  }
  #print(distances)
  
  return(mean(distances))
}


labels= sample(1:7, 50, replace = TRUE)

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
  
  
  
  # # Repeat until convergence 
  converged= FALSE
  while(!converged){
    # keep track of clusters from last iteration 
    previous= clusters
    # Compute the cluster centroid (average of each feature for each cluster)
    for (i in 1:k){
      
      select.i=which(clusters==i)
      #print(select.i)
      samples= df[select.i,]
      centroids[i,]= colMeans(samples)
      #print(centroids)
      
      
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
    
    #print(clusters)
    # Check for convergence
    if(all(clusters== previous)){
      converged= TRUE
    }
    
  }
  final= Kmeans.Cost(df, centroids,clusters)
  #clusters$V1= as.integer(clusters$V1)
  
  # Return results, clusters and objective function value 
  results= c(clusters, final)
  
  return(results)
}


## Initial centroid
initial_centroid <- rep(1,nrow(Data))

## to get clusters at k=4, will run three iterations

for (i in 1:3){
  # a matrix to store the final cluster labels and objective funtion 
  # for each iteration in which each data point acts as a centroid
  labels_CF <- matrix(data = NA, nrow = nrow(Data), ncol = nrow(Data)+1)
  
  for (j in 1:nrow(Data)){
    
    new_centroid <- initial_centroid
    new_centroid[j] <- i + 1  # in each iteration of the inner loop, each data point j becomes the second centroid
    labels_CF[j,] <-(Kmeans(Data,  new_centroid,i+1))
  }
  
  # update the initial centroid
  initial_centroid= labels_CF[order( labels_CF[,ncol( labels_CF)])[1], 1:(ncol(labels_CF) - 1) ]
}


# Finally choose the cluster labels based on lowest objective function from all 50 points used as centroid for k=4

X=labels_CF[which.min(labels_CF[,ncol(labels_CF)]),]


write.table(X, file = Output, sep = "\t", quote= FALSE, row.names = FALSE, col.names = FALSE)

