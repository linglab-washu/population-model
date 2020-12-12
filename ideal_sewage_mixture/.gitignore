library(dplyr)

bootstrap.popsize<-function(SubjectsDataframe, population.array){
sample.at.pop.size<-list()
for (i in 1:length(population.array)){
N=population.array[i]
sample.at.pop.size[[i]]<-colMeans(dplyr::sample_n(SubjectsDataframe,N, replace=TRUE))
}
sample.at.pop.range<-data.frame(do.call("rbind",sample.at.pop.size))
population.size<-population.array
sample.at.pop.range.labeled<-cbind(population.size,sample.at.pop.range)
return(sample.at.pop.range.labeled)
}

# repeated sampling
bootstrap.sampling<-function(SubjectsDataframe, population.array, n_rep){
replicated.samples.list<-replicate(n=n_rep,bootstrap.popsize(SubjectsDataframe, population.array), simplify=FALSE)
replicated.samples.df<-data.frame(do.call("rbind",replicated.samples.list))
sim.id<-sprintf("sim%s",seq(1:(length(population.array)*n_rep)))
rownames(replicated.samples.df)<-sim.id
return(replicated.samples.df)
}

# set random number and parameters in bootstrap
set.seed(12)
n_rep<-10000
population.array<-c(1:300)
# deploy the bootstrap.sampling function
population.sim.df<-bootstrap.sampling(as.data.frame(training.subjects), population.array,n_rep)
