
# This file is a generated template, your changes will not be overwritten

cttClass <- if (requireNamespace('jmvcore')) R6::R6Class(
    "cttClass",
    inherit = cttBase,
    private = list(
        .run = function() {

			d <- self$options$dist
			s <- self$options$sample
			r <- self$options$repeats
			
			#sample...
			rez <- vector(mode="numeric",length=r)
			for(i in 1:r){		
			
				if(d == "normal"){rez[i] <- mean(rnorm(s))}
				if(d == "uniform"){rez[i] <- mean(runif(s))}
				if(d == "lognormal"){rez[i] <- mean(rlnorm(s))}
				if(d == "geometric"){rez[i] <- mean(rgeom(s,.5))}
				if(d == "binomial"){rez[i] <- mean(rbinom(s,100,.5))}
				}
			
		# calculate serror
				if(d == "normal"){serror <- 1/sqrt(s)}
				if(d == "uniform"){serror <- sqrt((1/12)/s)} #var=1/12*(b-a)^2 (b=1, a=0)
				if(d == "lognormal"){serror <- sqrt(exp(1)*(exp(1)-1)/s)} #var=exp(1)*(exp(1)-1)
				if(d == "geometric"){serror <- sqrt(2/s)} # var=(1-p)/p^2
				if(d == "binomial"){serror <- sqrt(25/s)} #var= np(1-p)
		
		# populate tabelo izpis2
		table2 <- self$results$izpis2
		table2$setRow(rowNo=1, values=list(size=s,repeats=r, means=mean(rez), sds=sd(rez), serror=serror))
				
        # slika   
		hiss <- self$results$pics
		hisp <- self$results$picp
		hiss$setState(rez)	
		hisp$setState(rez)
	        },
				.picp = function(hisp, ggtheme, theme,...){
			pop <- data.frame("x"=hisp$state)
				rez <- data.frame("x"=as.numeric(hisp$state))
				s <- self$options$sample
				mi <- mean(rez$x,na.rm=TRUE)
				sigma <- sd(rez$x, na.rm=TRUE) 
				nn <- nrow(rez)
				inter <- ifelse(nn<200,20,round(nn/10,0))
				b <- graphics::hist(rez$x,br=inter,plot=FALSE)
				# #small hack for sizes s>10 to get normal curve on track...
				dd <- nn*dnorm(seq(min(b$mids),max(b$mids),length.out=inter),mean=mi, sd=sigma)/inter
				v <- max(dd)
				z <- quantile(b$counts,.975) #new height for normal curve
				v1 <- z/v
				visek <- max(v1*dd, b$counts)
			
			d <- self$options$dist
				if(d == "normal"){dtf <- data.frame("a"=seq(-4,4,length.out=100), "b"=2*visek*dnorm(seq(-4,4,length.out=100),0,1))}
				if(d == "uniform"){dtf <- data.frame("a"=seq(0,1,length.out=100), "b"=visek*.7*dunif(seq(0,1,length.out=100)))}
				if(d == "lognormal"){dtf <- data.frame("a"=seq(0,30,length.out=100), "b"=visek*dlnorm(seq(0,30,length.out=100)))}
				if(d == "geometric"){dtf <- data.frame("a"=0:15, "b"=visek*dgeom(0:15,.5))}
				if(d == "binomial"){dtf <- data.frame("a"=25:75, "b"=visek*15*dbinom(25:75,100,.5))}
		
		plot <- ggplot2::ggplot(data=rez) +
		ggplot2::geom_histogram(col=theme$color[2],fill=theme$fill[2],alpha = .8, breaks=b$breaks, ggplot2::aes(x=x)) +
		ggplot2::geom_line(data=dtf, size=1, ggplot2::aes(x=a,y=b, colour="distribution")) + 
		ggplot2::xlab("Value") +
		ggplot2::ylab("Count") + ggtheme +
		ggplot2::scale_colour_manual(values=c(distribution="#E69F00")) + 
		ggplot2::theme(legend.title=ggplot2::element_blank())
		
		return(plot)
		},

		.pics = function(hiss, ggtheme, theme,...){
		rez <- data.frame("x"=as.numeric(hiss$state))
		s <- self$options$sample
		mi <- mean(rez$x,na.rm=TRUE)
		sigma <- sd(rez$x, na.rm=TRUE) 
		nn <- nrow(rez)
		inter <- ifelse(nn<200,20,round(nn/10,0))
		# #inter <- min(inter,length(unique(rez$x)))
		# #interval <- ifelse(nn<200,10,round(nn^.5,0))
		# #inter <- ifelse(s<10,inter,inter*15/s)
		# #inter <- ifelse(s<10,inter,inter*15/s)
		b <- graphics::hist(rez$x,br=inter,plot=FALSE)
		# #small hack for sizes s>10 to get normal curve on track...
		dd <- nn*dnorm(seq(min(b$mids),max(b$mids),length.out=inter),mean=mi, sd=sigma)/inter
		v <- max(dd)
		z <- quantile(b$counts,.975) #new height for normal curve
		v1 <- z/v
		visek <- max(v1*dd, b$counts)
		
		dtf <- data.frame("a"=seq(min(b$mids),max(b$mids),length.out=inter),"b"=v1*nn*dnorm(seq(min(b$mids),max(b$mids),length.out=inter),mean=mi, sd=sigma)/inter)
		# 
		#  graphics::plot(b,ylim=c(0,visek),main="",col="darkred",las=1, xlab="Value", ylab="Frequency")
		#  graphics::legend("topright",legend=c("normal"),col=c("red"),lty=1,lwd=3,bty="n")
		#  graphics::lines(seq(min(b$mids),max(b$mids),length.out=inter),v1*nn*dnorm(seq(min(b$mids),max(b$mids),length.out=inter),mean=mi, sd=sigma)/inter,lwd=2,col="red",lty=1)
		#  # 
		#  TRUE
		
		plot <- ggplot2::ggplot(data=rez) +
		ggplot2::geom_histogram(col=theme$color[2], fill=theme$fill[2],alpha = .8, breaks=b$breaks, ggplot2::aes(x=x)) +
		ggplot2::geom_line(data=dtf, size=1, ggplot2::aes(x=a,y=b, colour="normal")) + 
		ggplot2::xlab("Value") +
		ggplot2::ylab("Count") + ggtheme +
		ggplot2::scale_colour_manual(values=c(normal="#E69F00")) +	
		ggplot2::theme(legend.title=ggplot2::element_blank())
	
		
		return(plot)
		
		}		
		) 
)
