\encoding{latin1}

\name{cov4}
\alias{cov4}

\title{Scatter Matrix based on Fourth Moments}
\description{
  Estimates the scatter matrix based on the 4th moments of the data.
}
\usage{
cov4(X, location = "Mean", na.action = na.fail)
}

\arguments{
  \item{X}{numeric data matrix or dataframe, missing values are not allowed. }
  \item{location}{can be either \code{Mean}, \code{Origin} or numeric. If numeric
            the matrix is computed wrt to the given location.}
  \item{na.action}{ a function which indicates what should happen when the data
          contain 'NA's.  Default is to fail.}
}
\details{
  If location is \code{Mean} the scatter matrix of 4th moments is computed wrt to the sample mean.
  For location = \code{Origin} it is the scatter matrix of 4th moments wrt to the origin.
  The scatter matrix is standardized in such a way to be consistent for the regular covariance matrix at the multinormal model.
  It is given for \eqn{n \times p}{n x p} matrix X by
  \deqn{\frac{1}{p+2} ave_{i}\{[(x_{i}-\bar{x})S^{-1}(x_{i}-\bar{x})'](x_{i}-\bar{x})'(x_{i}-\bar{x})\},}{%
   1/(p+2) ave{[(x_i-x_bar)S^{-1}(x_i-x_bar)'] (x_i-x_bar)'(x_i-x_bar)},}
  where \eqn{\bar{x}}{x_bar} is the mean vector and \eqn{S}{S} the regular covariance matrix.
}
\value{
  A matrix containing the estimated fourth moments scatter.
}
\references{
   Cardoso, J.F. (1989), Source separation using higher order moments, in \emph{Proc. IEEE Conf. on Acoustics, Speech and Signal Processing (ICASSP'89)}, 2109--2112. <doi:10.1109/ICASSP.1989.266878>.

   Oja, H., \enc{Sirki?}{Sirkia}, S. and Eriksson, J. (2006), Scatter matrices and independent component analysis, \emph{Austrian Journal of Statistics}, \bold{35},  175--189.
}
\author{Klaus Nordhausen}
\examples{
set.seed(654321)
cov.matrix <- matrix(c(3,2,1,2,4,-0.5,1,-0.5,2), ncol=3)
X <- rmvnorm(100, c(0,0,0), cov.matrix)
cov4(X)
cov4(X, location="Origin")
rm(.Random.seed)
}
\keyword{multivariate}

