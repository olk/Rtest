dim1 <- c("a1", "a2")
dim2 <- c("b1", "b2", "b3")
dim3 <- c("c1", "c2", "c3", "c4")
t <- array(1:24, c(2, 3 ,4), dimnames = list(dim1, dim2, dim3))
print("t")
t
print("t[1,,]")
t[1,,]
print("t[,i2,]")
t[,2,]
print("t[2,2,]")
t[2,2,]
print("t[1,2,3]")
t[1, 2, 3]

# array == tensor
t1 <- matrix(1:6, nrow=3)
t1
t2 <- matrix(10:15, nrow=3)
t2
tens <- array(data=c(t1,t2), dim=c(3,2,2))
attributes(tens)
tens
