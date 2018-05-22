# scan(), reading file (default sep=<whitespace>)
scan("data/txt1") # [1]  125    2   10   11 5125
scan("data/txt2") # [1] 4213424.000       3.145       4.000       3.124
scan("data/txt3", what="") # [1] "abc" "uvw" "kl"  "m"
scan("data/txt3", what="", sep="\n") # [1] "abc"    "uvw kl" "m"

# print()/cat()
print("abc") # [1] "abc"
cat("abc\n") # abc
x <- 1:3
cat(x, "xyz", "de\n") # 1 2 3 xyz de
cat(x, "xyz", "de\n", sep="") # 123xyzde
cat(x, "xyz", "de\n", sep=c(".", ".", " ")) # 1.2.3 xyz.de

# reading matrix from file
m <- matrix(scan("data/m"), nrow=5, byrow=TRUE)
m
read.matrix <- function(path) {
    as.matrix(read.table(path))
}
m <- read.matrix("data/m")
m

## read complete text file at once
z <- readLines("data/z") # retruns vector of strings (each vector element corresponds to one line)
z

# connections (== file descriptors) with file()
cz <- file("data/z", "r")
readLines(cz, n=1)
readLines(cz, n=1)
readLines(cz, n=1)
readLines(cz, n=1)

# seek(), rewind to beginning of the file
seek(con=cz, where=0) # `where=0` position pointer to zero chars from the start of the file

# read EOF
while(TRUE) {
    l <- readLines(cz, n=1)
    if (0==length(l)) {
        print("EOF")
        break
    } else {
        print(l)
    }
}

# close(), cloe conenction (file descriptor)
close(cz)

# writing to files
cu <- file("data/u")
writeLines(c("xyz 123", "de", 3), cu)
close(cu) # required to flush the buffer

# get meta infos
ctmp <- file("/tmp")
file.exists("/tmp")
file.info("/tmp")
# pipe, using command line tools
readLines(pipe("ls -1"))
scan(pipe("sed -e s/,$// ./data/m"), sep = "")
fn <- function(path) {
    total <- 0
    lst <- dir(path, recursive=TRUE)
    for (f in lst) {
        f <- file.path(path, f)
        if (!file.info(f)$isdir) {
            total <- total + file.info(f)$size
        }
    }
    return(total)
}
fn("/tmp")
