\name{cov4.wt}
\alias{cov4.wt}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Weighted Scatter Matrix based on Fourth Moments}
\description{
 Estimates the weighted scatter matrix based on the 4th moments of the data.
}
\usage{
cov4.wt(x, wt = rep(1/nrow(x), nrow(x)), location = TRUE,
        method = "ML", na.action = na.fail)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{numeric data matrix or dataframe.}
  \item{wt}{numeric vector of non-negative weights. At least some weights must be larger than zero.}
  \item{location}{\code{TRUE} if the weighted location vector should be computed. \code{FALSE} when taken wrt to the origin.  If numeric
            the matrix is computed wrt to the given location.}
  \item{method}{Either \code{ML} or \code{unbiased}. Will be passed on to \code{\link{cov.wt}} when the Mahalanobis distance is computed.}
  \item{na.action}{a function which indicates what should happen when the data
          contain 'NA's.  Default is to fail.}
}
\details{
  If \code{location = TRUE}, then the scatter matrix is given for a \eqn{n \times p}{n x p} data matrix X by
  \deqn{\frac{1}{p+2} ave_{i}\{w_i[(x_{i}-\bar{x}_w)S_w^{-1}(x_{i}-\bar{x}_w)'](x_{i}-\bar{x}_w)'(x_{i}-\bar{x}_w)\},}{%
   1/(p+2) ave{w_i[(x_i-x_bar)S^{-1}(x_i-x_bar)'] (x_i-x_bar)'(x_i-x_bar)},}
  where \eqn{w_i}{w_i} are the weights standardized such that \eqn{\sum{w_i}=1}{sum(w_i)=1},
  \eqn{\bar{x}_w}{x_bar} is the weighted mean vector and \eqn{S_w}{S} the weighted covariance matrix.
  For details about the weighted mean vector and weighted covariance matrix see \code{\link{cov.wt}}.
}
\value{
  A matrix containing the estimated weighted fourth moments scatter.
}

\author{Klaus Nordhausen}

\seealso{\code{\link{cov4}}, \code{\link{cov.wt}}}
\examples{
cov.matrix.1 <- matrix(c(3,2,1,2,4,-0.5,1,-0.5,2), ncol=3)
X.1 <- rmvnorm(100, c(0,0,0), cov.matrix.1)
cov.matrix.2 <- diag(1,3)
X.2 <- rmvnorm(50, c(1,1,1), cov.matrix.2)
X <- rbind(X.1, X.2)

cov4.wt(X, rep(c(0,1), c(100,50)))
cov4.wt(X, rep(c(1,0), c(100,50)))
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{multivariate}
