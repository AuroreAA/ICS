\name{tM}
\alias{tM}

\title{ Joint M-estimation of Location and Scatter for a Multivariate t-distribution }
\description{
  Implements three EM algorithms to M-estimate the location vector and scatter matrix of a multivariate t-distribution.
}
\usage{
tM(X, df = 1, alg = "alg3", mu.init = NULL, V.init = NULL,
        gamma.init = NULL, eps = 1e-06, maxiter = 100,
        na.action = na.fail)
}

\arguments{
  \item{X}{numeric data matrix or dataframe. }
  \item{df}{ assumed degrees of freedom of the t-distribution. Default is \code{1} which corresponds to the Cauchy distribution.}
  \item{alg}{specifies which algorithm to use. Options are \code{alg1}, \code{alg2} or \code{alg3}. \code{alg3} is the default.}
  \item{mu.init}{initial value for the location vector if available.}
  \item{V.init}{initial value for the scatter matrix if available.}
  \item{gamma.init}{ initial value for gamma if available. Only needed for \code{alg2}.}
  \item{eps}{convergence tolerance.}
  \item{maxiter}{maximum number of iterations.}
  \item{na.action}{a function which indicates what should happen when the data
          contain 'NA's.  Default is to fail.}
}
\details{
  This function implements the EM algorithms described in Kent et al. (1994). The norm used to define convergence is as in Arslan et al. (1995).

  Algorithm 1 is valid for all degrees of freedom \code{df} > 0. Algorithm 2 is well defined only for degrees of freedom \code{df} > 1.
  Algorithm 3 is the limiting case of Algorithm 2 with degrees of freedom \code{df} = 1.

  The performance of the algorithms are compared in Arslan et al. (1995).

  Note that \code{\link[MASS]{cov.trob}} in the MASS package implements also a covariance estimate for a multivariate t-distribution.
  That function provides for example also the possibility to fix the location. It requires however that the degrees of freedom exceeds 2.
}
\value{
 A list containing:
  \item{mu }{vector with the estimated loaction.}
  \item{V }{matrix of the estimated scatter.}
  \item{gam }{estimated value of gamma. Only present when \code{alg2} is used.}
  \item{iter }{number of iterations.}
}

\references{ \cite{Kent, J.T., Tyler, D.E. and Vardi, Y. (1994),  A curious likelihood identity for the multivariate t-distribution, \emph{Communications in Statistics, Simulation and Computation}, \bold{23},  441--453.
             <doi:10.1080/03610919408813180>. }

            \cite{Arslan, O., Constable, P.D.L.  and Kent, J.T. (1995), Convergence behaviour of the EM algorithm for the multivariate t-distribution, \emph{Communications in Statistics, Theory and Methods}, \bold{24}, 2981--3000. <doi:10.1080/03610929508831664>.}}

\author{Klaus Nordhausen}

\seealso{  \code{\link[MASS]{cov.trob}} }

\examples{
set.seed(654321)
cov.matrix <- matrix(c(3,2,1,2,4,-0.5,1,-0.5,2), ncol=3)
X <- rmvt(100, cov.matrix, 1)
tM(X)
rm(.Random.seed)
}
\keyword{multivariate}

