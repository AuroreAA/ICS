\encoding{latin1}

\name{ics2}
\alias{ics2}

\title{
Two Scatter Matrices ICS Transformation Augmented by Two Location Estimates
}
\description{
This function implements the two scatter matrices transformation to obtain an invariant coordinate sytem or independent 
  components, depending on the underlying assumptions. Differently to \code{\link{ics}} here are also two location functionals used
  to fix the signs of the components and to get a measure of skewness.
}
\usage{
ics2(X, S1 = MeanCov, S2 = Mean3Cov4, S1args = list(), S2args = list(),
     na.action = na.fail)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{X}{ numeric data matrix or dataframe.}
  \item{S1}{ name of the function which returns the first location vector T1 and scatter matrix S1. Can be also
  a list which has these values already computed. See details for more information. Default is \code{\link{MeanCov}}.}
  \item{S2}{name of the function which returns the second location vector T2 and scatter matrix S2. Can be also
  a list which has these values already computed. See details for more information. Default is \code{\link{Mean3Cov4}}.}
  \item{S1args}{ list with optional additional arguments when calling function S1.}
  \item{S2args}{ list with optional additional arguments when calling function S2.}
  \item{na.action}{ a function which indicates what should happen when the data
          contain 'NA's.  Default is to fail.}
}
\details{
For a general discussion about ICS see the help for \code{\link{ics}}. The difference to \code{\link{ics}} is that \code{S1} and \code{S2}
are either functions which return a list containing a multivariate location and scatter computed on \code{X} or lists containing these measures
computed in advance. Of importance for the resulting lists is that in both cases the location vector is the first element of the list and the scatter matrix
the second element. This means most multivariate location - scatter functions can be used directly without the need to write a wrapper.

The invariant coordinates Z are then computed such that
(i)   T1(Z) = 0, the origin.
(ii)  S1(Z) = I_p, the identity matrix. 
(iii) T2(Z) = S, where S is a vector having positive elements and can be seen as a generalized skewness measure (gSkew).
(iv)  S2(Z) = D, a diagonal matrix with descending elements which can be seen as a generalized kurtosis measure (gKurt).

Hence in this function there are no options to standardize Z or the transformation matrix B as everything is 
specified by \code{S1} and \code{S2}.

Note also that \code{ics2} makes hardly any input checks.
}
\value{
an object of class \code{ics2} inheriting from class \code{ics}.
}
\references{
\cite{Tyler, D.E., Critchley, F., \enc{Duembgen}{Duembgen}, L. and Oja, H. (2009), Invariant co-ordinate selecetion, \emph{Journal of the Royal Statistical Society},Series B, \bold{71},  549--592. <doi:10.1111/j.1467-9868.2009.00706.x>.}

\cite{Nordhausen, K., Oja, H. and Ollila, E. (2011), Multivariate Models and the First Four Moments, In Hunter, D.R., Richards, D.S.R. and Rosenberger, J.L. (editors) "Nonparametric Statistics and Mixture Models:  A Festschrift in Honor of Thomas P. Hettmansperger", 267--287, World Scientific, Singapore. <doi:10.1142/9789814340564_0016>.}

}
\author{
Klaus Nordhausen
}


\seealso{
 \code{\link{ics}}
}
\examples{
 set.seed(123456)
 X1 <- rmvnorm(250, rep(0,8), diag(c(rep(1,6),0.04,0.04)))
 X2 <- rmvnorm(50, c(rep(0,6),2,0), diag(c(rep(1,6),0.04,0.04)))
 X3 <- rmvnorm(200, c(rep(0,7),2), diag(c(rep(1,6),0.04,0.04)))

 X.comps <- rbind(X1,X2,X3)
 A <- matrix(rnorm(64),nrow=8)
 X <- X.comps \%*\% t(A)
 
 # the default
 ics2.X.1 <- ics2(X2)
 summary(ics2.X.1)
 
 # using another function as S2 not with its default
 ics2.X.2 <- ics2(X2, S2 = tM, S2args = list(df = 2))
 summary(ics2.X.2)
 
 # computing in advance S2 and using another S1
 Scauchy <- tM(X)
 ics2.X.2 <- ics2(X2, S1 = tM, S2 = Scauchy, S1args = list(df = 5))
 summary(ics2.X.2)
 plot(ics2.X.2)
}
\keyword{models}
\keyword{multivariate}
