
# This file is a generated template, your changes will not be overwritten

cttClass <- if (requireNamespace('jmvcore')) R6::R6Class(
    "cttClass",
    inherit = cttBase,
    private = list(.init = function() {
        if(self$options$pic)  {
		self$results$picp$setVisible(visible = TRUE)
		self$results$pics$setVisible(visible = TRUE)
		}
        },
        .run = function() {

			d <- self$options$dist
			s <- self$options$sample
			r <- self$options$repeats
			
			#create simulated distribution N=10000
			if(d == "normal"){pop <- rnorm(10000)
			pop <- pop[(pop < 3.5)&(pop > -3.5)]}
			if(d == "uniform"){pop <- runif(10000)}
			if(d == "lognormal"){pop <- rlnorm(10000)
			pop <- pop[pop<10]}
			if(d == "geometric"){pop <- rgeom(10000,.5)
			pop <- pop[pop<8]}
			if(d == "binomial"){pop <- rbinom(10000,100,.5)
			pop <- pop[(pop < 70)&(pop > 30)]}
			
			#sample...
			rez <- vector(mode="numeric",length=r)
			for(i in 1:r){
			rez[i] <- mean(sample(pop,s,replace=FALSE))
			}
			
		# populate tabelo izpis
		table <- self$results$izpis
		table$setRow(rowNo=1, values=list(distrib=d,meanp=mean(pop), sdp=sd(pop)))
		
		# populate tabelo izpis2
		table2 <- self$results$izpis2
		table2$setRow(rowNo=1, values=list(size=s,repeats=r, means=mean(rez), sds=sd(rez), serror=sd(pop)/sqrt(s)))
				
        # slika   
		if(self$options$pic){
		hisp <- self$results$picp
		xl <- c(min(pop),max(pop))
		plotData1 <- list(pop,xl)
		hisp$setState(plotData1)
		hiss <- self$results$pics
		plotData2 <- list(rez,xl)
		hiss$setState(plotData2)	
		}
	        },
				.picp = function(hisp,...){
		plotData1 <- hisp$state
		pop <- plotData1[[1]]
		xl <- plotData1[[2]]
		
		b <- graphics::hist(pop,xlim=xl,main="",col="goldenrod1",las=1, xlab="Value", ylab="Frequency",br=70)
		#graphics::legend("topright",legend=c("expected","normal"),col=c("blue","red"),lty=1,lwd=3,bty="n")
		TRUE
		},

				.pics = function(hiss,xl,...){
		plotData2 <- hiss$state
		rez <- plotData2[[1]]
		xl <- plotData2[[2]]
		s <- self$options$sample
		#rez <- hiss$state
		mi <- mean(rez,na.rm=TRUE)
		sigma <- sd(rez, na.rm=TRUE) 
		nn <- length(rez)
		inter <- ifelse(nn<200,20,round(nn/10,0))
		inter <- min(inter,length(unique(rez)))
		#interval <- ifelse(nn<200,10,round(nn^.5,0))
		#inter <- ifelse(s<10,inter,inter*15/s)
		b <- graphics::hist(rez,br=inter,plot=FALSE)
		#small hack for sizes s>10 to get normal curve on track...
		v <- max(nn*dnorm(seq(min(b$mids),max(b$mids),length.out=inter),mean=mi, sd=sigma)/inter)
		z <- quantile(b$counts,.975) #new height for normal curve
		v1 <- z/v
		visek <- max(v1*nn*dnorm(seq(min(b$mids),max(b$mids),length.out=inter),mean=mi, sd=sigma)/inter, b$counts)
		graphics::plot(b,xlim=xl,ylim=c(0,visek),main="",col="darkred",las=1, xlab="Value", ylab="Frequency")
		graphics::legend("topright",legend=c("normal"),col=c("red"),lty=1,lwd=3,bty="n")
		graphics::lines(seq(min(b$mids),max(b$mids),length.out=inter),v1*nn*dnorm(seq(min(b$mids),max(b$mids),length.out=inter),mean=mi, sd=sigma)/inter,lwd=2,col="red",lty=1)
		
		TRUE
		}		
		) 
)
