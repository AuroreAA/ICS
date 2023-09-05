\name{mvnorm.skew.test}
\alias{mvnorm.skew.test}

\title{ Test of Multivariate Normality Based on Skewness}
\description{
  Test for multivariate normality that uses as criterion the skewness measured as the difference between
  location estimates based on first respectively third moments
}
\usage{
mvnorm.skew.test(X, na.action = na.fail)
}
\arguments{
  \item{X}{a numeric data frame or matrix. }
  \item{na.action}{a function which indicates what should happen when the data
          contain 'NA's.  Default is to fail.}
}
\details{
  This test implements the multivariate normality test based on skewness measured by two different location estimates
  as described in Kankainen, Taskinen and Oja. The choice here is based on the regular mean vector and the location estimate based on
  third moments (\code{\link{mean3}}). The scatter matrix used is the regular covariance matrix.
}
\value{
  A list with class 'htest' containing the following components:
  \item{statistic }{the value of the test statistic U.}
  \item{parameter}{the degrees of freedom for the statistic U.}
  \item{p.value}{the p-value for the test.}
  \item{method}{a character string indicating what type of test was performed.}
  \item{data.name}{a character string giving the name of the data.}
}
\references{\cite{Kankainen, A., Taskinen, S. and Oja, H. (2007),Tests of multinormality based on location vectors and scatter matrices, \emph{Statistical Methods and Applications}, \bold{16},  357--379. <doi:10.1007/s10260-007-0045-9>.}}
\author{Klaus Nordhausen}
\seealso{ \code{\link{mvnorm.kur.test}} }
\examples{
X<-rmvnorm(100,c(2,4,5))
mvnorm.skew.test(X)
}
\keyword{htest}
\keyword{ multivariate }
