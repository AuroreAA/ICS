\name{Mean3Cov4}
\alias{Mean3Cov4}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Location Vector Based on 3rd Moments and Scatter Matrix Based on 4th Moments
}
\description{
Returns, for some multivariate data, the location vector based on 3rd moments and the scatter matrix based on 4th moments.
}
\usage{
Mean3Cov4(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{a numeric data matrix.}
}
\details{
Note that the scatter matrix of 4th moments is computed with respect to the mean vector and not with respect to the location vector
based on 3rd moments.
}
\value{
A list containing:
  \item{locations}{The location vector based on 3rd moments as computed by \code{\link{mean3}}.}
  \item{scatter}{The scatter matrix based on 4th moments as computed by \code{\link{cov4}}.}
}

\author{Klaus Nordhausen}

\seealso{
\code{\link{mean3}}, \code{\link{cov4}}
}
\examples{
X <- rmvnorm(200, 1:3, diag(2:4))
Mean3Cov4(X)
}

\keyword{ multivariate}% use one of  RShowDoc("KEYWORDS")
