
# This file is a generated template, your changes will not be overwritten

simhClass <- if (requireNamespace('jmvcore')) R6::R6Class(
    "simhClass",
    inherit = simhBase,
    private = list(.init = function() {
        if(self$options$his)  {self$results$his$setVisible(visible = TRUE)}
		if(self$options$plotci)  {self$results$plotci$setVisible(visible = TRUE)}
        },
        .run = function() {

		dif <- self$options$dif
		sam <- self$options$sam
		numer <- self$options$numer
		pval <- self$options$pval

		# populate tabelo izpis
		table <- self$results$izpis		
		
		if(! table$isFilled(rowNo=1)){
		
			#create population first
			a <- rnorm(5000,50,10)
			
			#run a bunch of t tests
			#simulating normally distributed population, mean=50, sd=10
				rez <- data.frame("r"=rep(0,numer),"p"=rep(0,numer),"c1"=rep(0,numer),"c2"=rep(0,numer),"se"=rep(0,numer))
				
				for(i in 1:numer){
					y <- sample(a,sam,replace=TRUE)
					x <- sample(a+dif,sam,replace=TRUE)
					tt <- t.test(x, y, mu = dif, paired = FALSE, var.equal = TRUE, conf.level = (1-pval))
					rez$r[i] <- tt$estimate[1]-tt$estimate[2]
					rez$p[i] <- tt$p.value
					rez$c1[i] <- tt$conf.int[1]
					rez$c2[i] <- tt$conf.int[2]
					rez$se[i] <- tt$stderr
				}
			
			
			#SE of sample mean diff = sqrt((sd^2/n1)+(sd^2/n2))
			# CI = SE*critical value of t
	
			
			table$setRow(rowNo=1, values=list(raz=dif,dej=mean(rez$r), sam=sam,pon=numer, del=sum(rez$p<(pval+.0001))/numer, pval=pval))
			table$setState(rez)
		}
		rez <- table$state
	
        # slika his  
		if(self$options$his){
			his1 <- self$results$his
			his1$setState(rez)
		}
        # slika plotci 
		if(self$options$plotci){
			his2 <- self$results$plotci
			his2$setState(rez)
		}

        },
		.his = function(his1,...){
		rez <- his1$state
		pval <- self$options$pval
		dif <- self$options$dif
		sam <- self$options$sam
		#try to make intervals coincide with critical values
		# that way red cases will equal actual number of sig. cases
		# 10 is true SD, sterr is sd*sqrt(1/n1+1/n2), t = dif/sterr
		# df=n1+n2-2
		#crit value of r
		#  r1 <- dif+stats::qt(pval/2,2*sam-2)*10*sqrt(2/sam)
		#  r2 <- dif+stats::qt(1-pval/2,2*sam-2)*10*sqrt(2/sam)
		#  	#calculating breaks by hand...:)
		#  	jump <- diff(seq(r1,r2,length.out=25))[1]
		#  	brks <- c(sort(seq(r1-jump,min(rez$r)-jump, by=jump*-1)),
		#  	seq(r1,r2,length.out=25),
		#  	seq(r2+jump,max(rez$r)+jump, by=jump))
		#  	
		#  b <- graphics::hist(rez$r,br=brks,plot=FALSE)
		b <- graphics::hist(rez$r,br=99,plot=FALSE)
		#rr <- min(diff(b$mids[2:5]))/2-.001
		#najmanjša pozitvna stat.pomebna in največja negativna stat.pomembna
		c1 <- max(rez$r[(rez$p < (pval+.0001))&(rez$r < dif)])
		c2 <- min(rez$r[(rez$p < (pval+.0001))&(rez$r > dif)])
		barve <- ifelse(((b$mids) < c1)|((b$mids) > c2),"red","lightblue")
		graphics::plot(b,main="",col=barve,las=1, xlab="Diff in means", ylab="Frequency",sub="Red columns can differ from number of significant tests.")
		#graphics::legend("topright",legend=c("expected","normal"),col=c("blue","red"),lty=1,lwd=3,bty="n")
		#hist(rez$r,br=50,main="",col="lightblue",las=1, xlab="Razlika AS", ylab="Frekvenca")
		TRUE
		},

		.plotci = function(his2,...){
		rez <- his2$state
		v1 <- min(rez$c1)
		v2 <- max(rez$c2)
		dif <- self$options$dif
		sam <- self$options$sam
		pval <- self$options$pval
		#ser <- sqrt(mean(rez$se^2,na.rm=TRUE))
		#ser <- sqrt(100/sam + 100/sam)
		#s1 <- min(rez$r[rez$p>(pval+.0001)])
		#s2 <- max(rez$r[rez$p>(pval+.0001)])
		graphics::plot(rez$r,ylim=c(v1,v2),pch=21,main="",bg="darkred",las=1, xlab="Trials", ylab="Difference")
		graphics::segments(1:nrow(rez),rez$c1,1:nrow(rez),rez$c2,col=c("darkgray","red")[ifelse(rez$p<(pval+.0001),2,1)])
		graphics::abline(h=dif,lwd=2,col="red")
		#graphics::abline(h=dif-ser,lwd=2,col="red",lty=3)
		#graphics::abline(h=dif+ser,lwd=2,col="red",lty=3)
		#graphics::abline(h=s1,lwd=2,col="red",lty=3)
		#graphics::abline(h=s2,lwd=2,col="red",lty=3)		
		TRUE
		}	
		
		
		
		)
)
