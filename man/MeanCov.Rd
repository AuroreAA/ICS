\name{MeanCov}
\alias{MeanCov}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Mean Vector and Covariance Matrix}

\description{
Returns, for some multivariate data, the mean vector and covariance matrix.
}
\usage{
MeanCov(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{a numeric data matrix.}
}

\value{
A list containing:
  \item{locations}{The mean vector as computed by \code{\link{colMeans}}.}
  \item{scatter}{The covariance matrix as computed by \code{\link{cov}}.}
}


\author{Klaus Nordhausen}

\seealso{
\code{\link{colMeans}}, \code{\link{cov}}
}
\examples{
X <- rmvnorm(200, 1:3, diag(2:4))
MeanCov(X)
}

\keyword{ multivariate}% use one of  RShowDoc("KEYWORDS")
