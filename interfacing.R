dyn.load("subdiag.so")

m <- rbind(1:5, 6:10, 11:15, 16:20, 21:25)
k <- 2
x <- .C("subdiag", as.double(m), as.integer(dim(m)[1]), as.integer(k), result=double(dim(m)[1]-k))
x
