\name{fitted.ics}
\docType{methods}
\alias{fitted.ics}
\alias{fitted-method}
\alias{fitted,ics-method}

\title{Fitted Values of an ICS Object}
\description{
  Computes the fitted values of an \code{ics} object.
}
\usage{
\S4method{fitted}{ics}(object,index=NULL)
}

\arguments{
  \item{object}{ object of class \code{ics}.}
  \item{index}{A vector which defines which components should be used to compute the fitted values. The default NULL uses all components. }
}

\value{
  Returns a dataframe with the fitted values.
}

\author{Klaus Nordhausen}

\seealso{\code{\link{ics-class}} and \code{\link{ics}}}
\examples{
    set.seed(123456)
    X1 <- rmvnorm(250, rep(0,8), diag(c(rep(1,6),0.04,0.04)))
    X2 <- rmvnorm(50, c(rep(0,6),2,0), diag(c(rep(1,6),0.04,0.04)))
    X3 <- rmvnorm(200, c(rep(0,7),2), diag(c(rep(1,6),0.04,0.04)))

    X.comps <- rbind(X1,X2,X3)
    A <- matrix(rnorm(64),nrow=8)
    X <- X.comps \%*\% t(A)

    ics.X.1 <- ics(X)
    fitted(ics.X.1)
    fitted(ics.X.1,index=c(1,2,3,6,7,8))

    rm(.Random.seed)
}


\keyword{models}
