
# This file is a generated template, your changes will not be overwritten

coinClass <- if (requireNamespace('jmvcore')) R6::R6Class(
    "coinClass",
    inherit = coinBase,
    private = list(		
        .run = function() {
			k <- self$options$trial
			n <- as.numeric(substring(self$options$coins,3,5))
			p <- self$options$prob
			rez <- vector(mode="numeric",length=k)
			for(i in 1:k){
			rez[i] <- sum(sample(c(rep(0,1000*(1-p)),rep(1,1000*p)),n,replace=TRUE))
			}
			
		# populate table izpis
		table <- self$results$izpis
		table$setRow(rowNo=1, values=list(trials=k,koins=n, verjet=p, np=n*p,np1=n*(1-p)))
		
        # slika   
		his <- self$results$slika
		his$setState(rez)
		
        },
		.slika = function(his,ggtheme,theme,...){
		
		nn <- data.frame("x"=his$state)
		k <- self$options$trial
		n <- as.numeric(substring(self$options$coins,3,5))
		p <- self$options$prob
		
		mi <- n*p
		sigma <- sqrt(n*p*(1-p))

		start <- floor(min(nn$x))
		stop <- ceiling(max(nn$x))
		brk <- (start:(stop+1))-.5
		brk2 <- seq(start,stop,length.out=100)
		df2 <- data.frame("a"=brk2,"b"=dnorm(brk2,mi,sigma)*k)
		df3 <- data.frame("m"=brk+.5,"j"=dbinom(brk+.5,n,p)*k)

		
		plot <- ggplot2::ggplot(data=nn)+
		ggplot2::geom_histogram(col=theme$color[2],fill=theme$fill[2],alpha = .8,breaks=brk, ggplot2::aes(x=x))+ 
		ggplot2::geom_line(data=df2,size=1, ggplot2::aes(x=a, y=b, colour="normal"))+ 
		ggplot2::xlab("Sum")+ 
		ggplot2::ylab("Count")+
		ggplot2::geom_line(data=df3,size=1, ggplot2::aes(x=m, y=j, colour="binomial")) + ggtheme +
		ggplot2::scale_colour_manual(name="",values=c(normal="#E69F00",binomial="#56B4E9"))+
		ggplot2::theme(legend.title=ggplot2::element_blank())
		
		
		return(plot)
		})  
)
