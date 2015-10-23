## The two following R functions allow us to evaluate a mathematical function at a particular value of its argument, store the result of this evaluation  and recuperate it when needed. 
 
## The first R function "makeCacheMatrix" uses the R function "solve" (instead of "mean").  
#The place where the result of solve (applied to some defined argument) will be stored is called "hueco", which in spanish means "hole". 
#The R rutine makeCacheMatrix returns a list of four R functions. 

makeCacheMatrix<- function(ma=numeric())
  { 
hueco<-NULL
set<-function(y) 
{
	
## In the next instruction ma is set as a variable whose definition will be assigned by a search through the parent environenment from wich it is called.
## In the global environment there is no need to set ma. This is why I puted the following line as a comment. 
   #ma <<- y 
## Idem for hueco: but is necessary to set hueco, because it is a free variable (it is not an argument of makeCacheMatrix ) 
## Notice the difference between "hueco<-NULL" and "hueco<<-NULL".
  hueco <<- NULL
}
  
get<-function()  ma

 ## I called invma the result of solve(ma), (inv= inverse, ma = matrix)

setinvma<-function (invma)   hueco <<- solve
    
getinvma<-  function () hueco
  list(set = set, get = get,
       setinvma = setinvma,
       getinvma = getinvma)
}


## If ma is a matrix. You can run
##          xx<-makeCacheMatrix(ma)   (once)
##          cacheSolve(xx)   (any time you need the value of solve(ma))
##The first time you run cacheSolve(xx) the message "getting cached data" does not appear, because this time solve(ma) must be calculated. The second time the message appears because solve(ma) value is already in the caché.

## ¿¿?? I do not see any advantage to do things that way. For me it looks simpler: invma<-solve(ma) and use invma any time we need solve(ma). 
 

cacheSolve<-function(invma, ...) {
  hueco <- invma$getinvma()
  if(!is.null(hueco)) {
    message("getting cached data")
    return(hueco)
  }
  data <- invma$get()
  hueco <- solve(data, ...)
  invma$setinvma(hueco)
  hueco
}

#EXAMPLE

# > xx<-makeCacheMatrix(matrix(1:4,2,2))
# > cacheSolve(xx)
#     [,1] [,2]
#[1,]   -2  1.5
#[2,]    1 -0.5
#> cacheSolve(xx)
#getting cached data
#     [,1] [,2]
#[1,]   -2  1.5
#[2,]    1 -0.5
