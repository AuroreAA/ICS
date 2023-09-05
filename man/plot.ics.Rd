\name{plot.ics}
\docType{methods}
\alias{plot-ics}
\alias{plot.ics}
\alias{plot-method}
\alias{plot,ics,missing-method}
\title{Scatterplot for a ICS Object}
\description{
  Scatterplot matrix for an \code{ics} object.
}
\usage{
\S4method{plot}{ics,missing}(x, index = NULL, ...)
}

\arguments{
  \item{x}{object of class \code{ics}}
  \item{index}{index vector of which components should be plotted. See details for further information}
  \item{\dots}{other arguments for \code{plot}}
}
\details{
  If no index vector is given the function plots the full scatterplots matrix only if there are less than seven components.
  Otherwise the three first and three last components will be plotted.
  This is because the components with extreme kurtosis are the most interesting ones.
}


\author{Klaus Nordhausen}

\seealso{\code{\link{screeplot.ics}}, \code{\link{ics-class}} and \code{\link{ics}}}

\examples{
    set.seed(123456)
    X1 <- rmvnorm(250, rep(0,8), diag(c(rep(1,6),0.04,0.04)))
    X2 <- rmvnorm(50, c(rep(0,6),2,0), diag(c(rep(1,6),0.04,0.04)))
    X3 <- rmvnorm(200, c(rep(0,7),2), diag(c(rep(1,6),0.04,0.04)))

    X.comps <- rbind(X1,X2,X3)
    A <- matrix(rnorm(64),nrow=8)
    X <- X.comps \%*\% t(A)

    ics.X.1 <- ics(X)
    plot(ics.X.1)
    plot(ics.X.1,index=1:8)
    rm(.Random.seed)
}


\keyword{hplot}
\keyword{methods}
