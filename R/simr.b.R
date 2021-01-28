
# This file is a generated template, your changes will not be overwritten

simrClass <- if (requireNamespace('jmvcore')) R6::R6Class(
    "simrClass",
    inherit = simrBase,
    private = list(.run = function() {
		
		r <- self$options$korel
		n <- self$options$numer
		
		
		#create normally distributed sample
		a <- rnorm(n,mean=50,sd=10)
		
		# special case - if correlation is 0
		if(r == 0) {
		b <- rnorm(n,mean=50,sd=10)
		} else {
		#create normally distributed error variance
		e <- rnorm(n,mean=0,sd=sqrt((100/r^2)*(1-r^2)))
		if(r<0) {
			b <- 100-a+e
			} else {
			b <- a+e
			}
		}
		#make variances same size
		b <- scale(b)*10+50
	
		k <- stats::cor(a,b, use="pair")[1]

		
		#obtain CI through Fisher's z transformation
		# z <- log(sqrz((1+r)/(1-r)))
		# se <- 1/sqrt(N-3)
		z <- log((1+k)/(1-k))*.5
		se <- 1.96/sqrt(n-3)
		zl <- z - se
		zu <- z + se
		cl <- (exp(2*zl)-1)/(exp(2*zl)+1)
		cu <- (exp(2*zu)-1)/(exp(2*zu)+1)
		
		
		# populate tabelo izpis
		
		table <- self$results$izpis
		table$setRow(rowNo=1, values=list(numer=n ,kor=k, ciL=cl, ciU=cu))
				

		# slika   
		plotData <- data.frame("a"=a,"b"=b)
		scatt <- self$results$scat
		scatt$setState(plotData)
        },
		.scat = function(scatt, ggtheme, theme,...){
		plotData <- scatt$state
		koef <- lsfit(x=plotData$a,y=plotData$b)$coef
		#graphics::plot(plotData$a,plotData$b,pch=21,cex=1.5,bg="lightblue",xlab="A",ylab="B",las=1)
		#graphics::abline(lsfit(plotData$a,plotData$b),col="blue",lwd=1.5)
		#TRUE
		plot <- ggplot2::ggplot(data=plotData, ggplot2::aes(x=a, y=b)) + 
		ggplot2::geom_point(pch=21, size=4,fill=theme$color[2], alpha= .4) + ggtheme + 
		ggplot2::geom_abline(intercept=koef[1], slope=koef[2], col = "darkred", size = 1)
		
		
		return(plot)
		}
		) 
)
