\encoding{latin1}

\name{covOrigin}
\alias{covOrigin}

\title{Covariance Matrix with Respect to the Origin}
\description{Estimates the covariance matrix with respect to the origin.
}
\usage{
covOrigin(X, location = NULL, na.action = na.fail)
}

\arguments{
  \item{X}{ a numeric data matrix or dataframe.}
  \item{location}{ optional location value which serves as the center instead of the origin.}
  \item{na.action}{ a function which indicates what should happen when the data
          contain 'NA's.  Default is to fail.}
}
\details{
  The covariance matrix \eqn{S_{0}}{S_0} with respect to origin is given for a matrix X with n observations by
  \deqn{S_{0}= \frac{1}{n}X'X.}{%
  S_0=X'X/n.}
}


\value{
  A matrix containing the estimated covariance matrix with respect to the origin.
}

\author{Klaus Nordhausen}
\seealso{ \code{\link{cov}}}
\examples{
set.seed(654321)
cov.matrix <- matrix(c(3,2,1,2,4,-0.5,1,-0.5,2), ncol=3)
X <- rmvnorm(100,c(0,0,0),cov.matrix)
covOrigin(X)
rm(.Random.seed)
}
\keyword{multivariate}

