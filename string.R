# grep(), returns index of matching entries
grep("pol", c("Äquator", "Nordpol", "Südpol")) # [1] 2 3 
grep("Pol", c("Äquator", "Nordpol", "Südpol")) # integer(0)

# nchar(), length of string
nchar("Äquator") # [1] 7 , no NULL pointer
nchar(NA) # NA

# paste(), concatenates several strings
paste("Nord", "pol") # [1] "Nord pol"
paste("Nord", "pol", sep="") # [1] "Nordpol"

# sprintf(), assemble a string from parts
i <- 8
s <- sprintf("das Quadrat von %d ist %d", i, i^2)
s # [1] "das Quadrat von 8 ist 64"

# substr(), returns substring
substring("Äquator", 3, 5) # [1] "uat"

# strsplit(), splits a string
strsplit("01-01-1970", split="-") # 1] "01"   "01"   "1970"

# regexpr(), regular expressions
regexpr("uat", "Äquator") # [1] 3, position of the first occurence

# gregexpr(), finds all instacnes of the pattern
gregexpr("iss", "Mississippi") # [1] 3 3

grep("[aü]", c("Äquator", "Nordpol", "Südpol")) # [1] 1 3
grep("p.l", c("Äquator", "Nordpol", "Südpol")) # [1] 2 3
grep("N..d", c("Äquator", "Nordpol", "Südpol")) # [1] 2
grep("\\.", c("xyz", ".de", "heise.de")) # [1] 2 3

testext <- function(path, suffix) {
    # path is a one-element vector!
    p <- strsplit(path, ".", fixed=TRUE) # `fixed=TRUE` means `.` is not interpreted as regex, `p` is a list of consisting of one element
    n <- length(p[[1]]) # calcluate the length of the vector contained in list `p`
    return(p[[1]][n]==suffix) # compare the last element in the vector with the suffix
}
testext("x.y.abc", "abc")
testext("x.y.abc", "bc")
testext <- function(path, suffix) {
    n <- nchar(path) # length of the file name
    pos <- n - nchar(suffix) + 1
    return(substring(path, pos, n)==suffix)
}
testext("x.y.abc", "abc")
testext("x.y.abc", "bc") # returns `TRUE` because no search for `.` in file name
