## -----------------------------------------------------------------------------
seedN<-2022

n<-200 # 200 individuals
d<-10 # 10 variables
mat<-matrix(nrow=n,ncol=d) # the input of framework

#Simulate binary data from binomial distribution where the probability of value being 1 is 0.5.
for(i in seq(n))
{
  set.seed(seedN+i)
  mat[i,] <- rbinom(n=d, size=1, prob=0.5)
}

mat[,1]<-mat[,2] | mat[,3]  # 1 causes by 2 and 3
mat[,4] <-mat[,2] | mat[,5] # 4 causses by 2 and 5
mat[,6] <- mat[,1] | mat[,4] # 6 causes by 1 and 4


## -----------------------------------------------------------------------------
# Run the function
library(BiCausality)
resC<-BiCausality::CausalGraphInferMainFunc(mat = mat,CausalThs=0.1, nboot =50, IndpThs=0.05)

## -----------------------------------------------------------------------------
resC$CausalGRes$Ehat

## -----------------------------------------------------------------------------
library(igraph)
net <- graph_from_adjacency_matrix(resC$CausalGRes$Ehat ,weighted = NULL)
plot(net, edge.arrow.size = 0.3, vertex.size =20 , vertex.color = '#D4C8E9',layout=layout_with_kk)

## -----------------------------------------------------------------------------
resC$CausalGRes$causalInfo[['2,1']]

