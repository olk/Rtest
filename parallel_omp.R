dyn.load("mutlinks_omp.so")

Sys.setenv(OMP_NUM_THREADS=32)
n <- 1000
m <- matrix(sample(0:1, n^2, replace=TRUE), nrow=n)
system.time(z <- .C("mutlinks", as.integer(m), as.integer(n), result=double(1)))
z$result
