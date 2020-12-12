# function to compute the t statistic 
compute.y<-function(input.df, meanpop,varpop){

y<-list() 
    for (j in 1:nrow(input.df))
  {
    y[[j]]<-sum((as.numeric(input.df[j,-1])-meanpop)^2/varpop)
  }
y.unlist<- unlist(y)
y.labeled<-data.frame(input.df[,1], y.unlist)
colnames(y.labeled)<-c("true.pop","y.labeled")

return(y.labeled)
}

# function to estimate the distribution function of T statistic in training data
find.df<-function(train.y, Nmax)
{
df<-list()
for (j in 1:Nmax)
        {
         pop.size<-c(1:Nmax)
         statistics.subset<-subset(train.y, true.pop == pop.size[j])
         df[[j]]<-approxfun(density(statistics.subset$y))
         }
return(df)         
}

# function to perform maximum likelihood estimation using testing data
find.max.lik<-function (test.y, train.df.list)
{
max.lik<-list()
for (i in 1:nrow(test.y)) 
  {
  input<-test.y[i,2]
  prob.1.to.300<-vector(mode = "numeric", length = 300)
      for (j in 1:300)
      {
      prob.1.to.300[j]<-train.df.list[[j]](input)
      }
  max.lik[[i]]<-which.max(prob.1.to.300)
   }

results<-data.frame(test.y[,1], unlist(max.lik))
return(results)
}
