
# This file is a generated template, your changes will not be overwritten

coinClass <- if (requireNamespace('jmvcore')) R6::R6Class(
    "coinClass",
    inherit = coinBase,
    private = list(		.init = function() {
        if(self$options$slika)  self$results$slika$setVisible(visible = TRUE)
        },
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
		if(self$options$slika){
		his <- self$results$slika
		his$setState(rez)}
		
        },
		.slika = function(his,...){
		nn <- his$state
		k <- self$options$trial
		n <- as.numeric(substring(self$options$coins,3,5))
		p <- self$options$prob
		
		slikca <- hist(nn,br=(min(nn):(max(nn)+1))-.5)
		mi <- n*p
		sigma <- sqrt(n*p*(1-p))
		#maksimum za graf		
		mak <- max(slikca$counts,k*dnorm(seq(0,n,.2),mean=mi, sd=sigma),k*dbinom(0:n,n,p))
		
		plot(slikca, ylim=c(0,mak),main="",col="orange",las=1, xlab="Sum", ylab="Frequency")
		legend("topright",legend=c("binomial","normal"),col=c("blue","red"),lty=1,lwd=3,bty="n")
		#lines(0:100,400*dnorm(seq(-10,10,.2)))
		# n - number of trials, p= prob of success
		#The normal approximation for our binomial variable is 
		# a mean of np and a standard deviation of sqrt(np(1 - p))
		
		lines(seq(0,n,.2),k*dnorm(seq(0,n,.2),mean=mi, sd=sigma),lwd=2,col="red",lty=1)
		lines(0:n,k*dbinom(0:n,n,p),lwd=2,col="blue",lty=2)
		TRUE
		})  
)
