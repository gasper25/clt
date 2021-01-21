
# This file is a generated template, your changes will not be overwritten

simhClass <- if (requireNamespace('jmvcore')) R6::R6Class(
    "simhClass",
    inherit = simhBase,
    private = list(
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
	
        # slika plotci 
			his2 <- self$results$plotci
			his2$setState(rez)
		},
		.plotci = function(his2, ggtheme, theme,...){
		rez <- his2$state
		rez <- cbind("z"=1:nrow(rez),rez)
		v1 <- min(rez$c1)
		v2 <- max(rez$c2)
		dif <- self$options$dif
		sam <- self$options$sam
		pval <- self$options$pval
		#ser <- sqrt(mean(rez$se^2,na.rm=TRUE))
		#ser <- sqrt(100/sam + 100/sam)
		#s1 <- min(rez$r[rez$p>(pval+.0001)])
		#s2 <- max(rez$r[rez$p>(pval+.0001)])
		
		#     graphics::plot(rez$r,ylim=c(v1,v2),pch=21,main="",bg="darkred",las=1, xlab="Trials", ylab="Difference")
		#     graphics::segments(1:nrow(rez),rez$c1,1:nrow(rez),rez$c2,col=c("darkgray","red")[ifelse(rez$p<(pval+.0001),2,1)])
		#     graphics::abline(h=dif,lwd=2,col="red")
		#     TRUE
		
		plot <- ggplot2::ggplot(data=rez) + 
		ggplot2::geom_point(size=2, pch=21, fill="darkred", ggplot2::aes(x=z,y=r)) + 
		ggplot2::geom_segment(ggplot2::aes(x=z,y=c1,xend=z,yend=c2),size=.5, col=c("darkgray","red")[ifelse(rez$p<(pval+.0001),2,1)]) + 
		ggplot2::geom_hline(yintercept=dif,size=1, col="blue") +
		ggplot2::xlab("Trials") + 
		ggplot2::ylab("Difference") + ggtheme
		
		return(plot)
		}	
		
		
		
		)
)
