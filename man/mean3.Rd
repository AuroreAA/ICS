\encoding{latin1}

\name{mean3}
\alias{mean3}

\title{ Location Estimate based on Third Moments}
\description{
  Estimates the location based on third moments.
}
\usage{
mean3(X, na.action = na.fail)
}
\arguments{
  \item{X}{numeric data matrix or dataframe with at least two columns.}
  \item{na.action}{a function which indicates what should happen when the data
          contain 'NA's.  Default is to fail. }
}
\details{
  This location estimate is defined for a \eqn{n \times p}{n x p} matrix X as
  \deqn{ \frac{1}{p} ave_{i}\{[(x_{i}-\bar{x})S^{-1}(x_{i}-\bar{x})'] x_{i}\},}{%
   1/p ave{[(x_i-x_bar)S^{-1}(x_i-x_bar)'] x_i},}
  where \eqn{\bar{x}}{x_bar} is the mean vector and \eqn{S}{S} the regular covariance matrix.
}
\value{
 A vector.
}
\references{\cite{Oja, H., \enc{Sirki?}{Sirkia}, S. and Eriksson, J. (2006), Scatter matrices and independent component analysis, \emph{Austrian Journal of Statistics}, \bold{35},  175--189.}}
\author{Klaus Nordhausen}

\examples{
set.seed(654321)
cov.matrix <- matrix(c(3,2,1,2,4,-0.5,1,-0.5,2), ncol=3)
X <- rmvnorm(100, c(0,0,0), cov.matrix)
mean3(X)
rm(.Random.seed)
}
\keyword{multivariate}

