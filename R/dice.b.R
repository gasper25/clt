
# This file is a generated template, your changes will not be overwritten

diceClass <- if (requireNamespace('jmvcore')) R6::R6Class(
    "diceClass",
    inherit = diceBase,
    private = list(.init = function() {
        if(self$options$slikak)  self$results$slikak$setVisible(visible = TRUE)
        },
        .run = function() {
			k <- self$options$trial
			n <- self$options$dice
			s <- self$options$sides
			
			#empirično
			rez <- vector(mode="numeric",length=k)
			for(i in 1:k){
			rez[i] <- sum(sample(1:s,n,replace=TRUE))
			}
			
		# populate tabelo izpis
		table <- self$results$izpis
		table$setRow(rowNo=1, values=list(trials=k,dic=n, side=s, samplespace=s^n))
		
        # slika   
		if(self$options$slikak){
		his1 <- self$results$slikak
		his1$setState(rez)}
		
        },
		.slikak = function(his1,...){
		nn <- his1$state
		k <- self$options$trial
		n <- self$options$dice
		s <- self$options$sides
		
					#teoretično

				pre <- "rep("
				sec <- "1:s"
				post <- ",each=s)"
				
				
				for(i in 1:n){
				tot <- ""
				gpre <- paste0(rep(pre,i-1),sep="",collapse="")
				gpost <- paste0(rep(post,i-1),sep="",collapse="")
				tot <- paste0(gpre,sec,gpost,sep="",collapse="")
				if(i<n){
				part <- paste(",s^(n-",i,"))",sep="")
				tot <- paste(pre,tot,part,sep="")
				}
				if(i==1){total <- tot} else {
				total <- paste(total,tot,sep=",")}
				}
				
				total <- paste("c(",total,")",sep="")
				eval(str2lang(total))
				
				#vse možne variacije
				zal <- matrix(eval(str2lang(total)),ncol=n,nrow=s^n,byrow=FALSE)
				#vse možne vsote
				vsota <- apply(zal,1,sum)
				rez2 <- as.data.frame(table(vsota))
				rez2$Freq <- rez2$Freq/sum(rez2$Freq)
		mi <- mean(vsota)
		sigma <- sd(vsota)		
		b <- graphics::hist(nn,br=(n:(s*n+1))-.5)
		visek <- max(k*rez2$Freq,k*dnorm(seq(n,(s*n),.2),mean=mi, sd=sigma),b$counts)
		graphics::plot(b,ylim=c(0,visek),main="",col="darkgreen",las=1, xlab="Sum", ylab="Frequency" )
		graphics::legend("topright",legend=c("expected","normal"),col=c("blue","red"),lty=1,lwd=3,bty="n")

		# .2, da je bolj zglajena
		graphics::lines(seq(n,(s*n),.2),k*dnorm(seq(n,(s*n),.2),mean=mi, sd=sigma),lwd=2,col="red",lty=1)
		graphics::lines(n:(s*n),k*rez2$Freq,lwd=2,col="blue",lty=2)
		TRUE
		})
)
