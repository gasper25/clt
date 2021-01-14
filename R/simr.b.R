
# This file is a generated template, your changes will not be overwritten

simrClass <- if (requireNamespace('jmvcore')) R6::R6Class(
    "simrClass",
    inherit = simrBase,
    private = list(.init = function() {
        if(self$options$scat)  {self$results$scat$setVisible(visible = TRUE)}
  		},
        .run = function() {
		
		r <- self$options$korel
		n <- self$options$numer
		v <- self$options$ci
		
		table <- self$results$izpis
		#test if we already ran the analysis
		if(! table$isFilled(rowNo=1)) {
		
		#create normally distributed sample
		a <- rnorm(n,mean=50,sd=10)
		
		# special case - if correlation is 0
		if(r == 0) {
		b <- rnorm(n,mean=50,sd=100)
		} else {
		#create normally distributed error variance
		e <- rnorm(n,mean=0,sd=sqrt((100/r^2)*(1-r^2)))
		if(r<0) {
			b <- 100-a+e
			} else {
			b <- a+e
			}
		}
		
		#this loop improves our simulation of correlation
		#tolerance is fixed
		tol <- .01
		#find p worst cases and improve them
		p <- max(50,n/10)
		for(i in 1:p){
		k <- cor(a,b)
		if((abs(r-k)>tol)) { #if we differ too much...
			#create pairs
			prs <- (a-mean(a))*(b-mean(b))
			if(abs(r)>abs(k)){ #if we have lower k
				if(r < 0) { #if we are nearing negative correlation...
					# take smallest negative product and increase one residual
					b[which(max(prs<0)==prs)] <- 1.03*b[which(max(prs<0)==prs)]
					} else {
					# take smallest positive product and increase one residual
					b[which(min(prs>0)==prs)] <- 1.03*b[which(min(prs>0)==prs)]
					}
			} else {
				if(r < 0) { #if we are nearing negative correlation...
					# take smallest negative product and decrease one residual
					b[which(min(prs<0)==prs)] <- b[which(min(prs<0)==prs)]/1.03
					} else {
					# take smallest positive product and decrease one residual
					b[which(max(prs>0)==prs)] <- b[which(max(prs>0)==prs)]/1.03
					}
			}
			
		}}
		
		k <- cor(a,b)

		

		
		
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

		if(v) {
		table$setRow(rowNo=1, values=list(numer=n,kor=k, ciL=cl, ciU=cu))
		} else {
		table$setRow(rowNo=1, values=list(numer=n,kor=k))
		}
		
		#save for situations 'out of the loop'
		
		table$setState(list(k,a,b))
		}	
		
		# 'restore' when not through the loop
		k <- table$state[[1]]
		a <- table$state[[2]]
		b <- table$state[[3]]	
		
		# slika   
		if(self$options$scat){
		plotData <- data.frame("a"=a,"b"=b)
		scatt <- self$results$scat
		scatt$setState(plotData)
		}
        },
		.scat = function(scatt,...){
		plotData <- scatt$state
		graphics::plot(plotData$a,plotData$b,pch=21,cex=1.5,bg="lightblue",xlab="A",ylab="B",las=1)
		graphics::abline(lsfit(plotData$a,plotData$b),col="blue",lwd=1.5)
		TRUE
		}
		) 
)
