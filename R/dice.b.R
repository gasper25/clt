
# This file is a generated template, your changes will not be overwritten

diceClass <- if (requireNamespace('jmvcore')) R6::R6Class(
    "diceClass",
    inherit = diceBase,
    private = list(
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
		his1 <- self$results$slikak
		his1$setState(rez)
		
        },
		.slikak = function(his1, ggtheme, theme,...){
		nn <- data.frame("x"=as.numeric(his1$state))
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
		brk <- (n:(s*n+1))-.5
		brk2 <- seq(min(brk),max(brk),length.out=100)
		df2 <- data.frame("a"=brk2,"b"=dnorm(brk2,mi,sigma)*k)
		df3 <- data.frame("m"=n:(s*n),"j"=rez2$Freq*k)
		
		b <- graphics::hist(nn$x,br=brk) #samo za maksimum - visek
		visek <- max(df3$j,df2$b,b$counts)
		
		plot <- ggplot2::ggplot(data=nn)+
		ggplot2::geom_histogram(col=theme$color[2],fill=theme$fill[2],alpha = .8,breaks=brk, ggplot2::aes(x=x))+ 
		ggplot2::geom_line(data=df2,size=1, ggplot2::aes(x=a, y=b, colour="normal"))+
		ggplot2::geom_line(data=df3,size=1, ggplot2::aes(x=m, y=j, colour="expected"))+ ggtheme +
		ggplot2::scale_colour_manual(values=c(normal="#E69F00",expected="#56B4E9"))+ 
		ggplot2::ylim(0,visek) + ggplot2::xlab("Sum") + ggplot2::ylab("Count")+ 
		ggplot2::theme(legend.title=ggplot2::element_blank())  
		
		return(plot)

		})
)
