\encoding{latin1}

\name{covAxis}
\alias{covAxis}

\title{ One step Tyler Shape Matrix}
\description{
  This matrix can be used to get the principal axes from \code{\link{ics}},
  which is then known as principal axis analysis.
}
\usage{
covAxis(X, na.action = na.fail)
}

\arguments{
  \item{X}{numeric data matrix or dataframe. }
  \item{na.action}{ a function which indicates what should happen when the data
          contain 'NA's.  Default is to fail.}
}
\details{
 The \code{covAxis} matrix \eqn{V}{V} is a given for a \eqn{n \times p}{n x p} data matrix X as
 \deqn{p \ ave_{i}\{[(x_{i}-\bar{x})S^{-1}(x_{i}-\bar{x})']^{-1}(x_{i}-\bar{x})'(x_{i}-\bar{x})\},}{%
  p ave{[(x_i-x_bar)S^{-1}(x_i-x_bar)']^(-1) (x_i-x_bar)'(x_i-x_bar)},}
  where \eqn{\bar{x}}{x_bar} is the mean vector and \eqn{S}{S} the regular covariance matrix.

  \code{covAxis} can be used to perform a Prinzipal Axis Analysis (Critchley et al. 2006) using the function \code{\link{ics}}.
  In that case, for a centered data matrix X, \code{covAxis} can be used as S2 in \code{\link{ics}}, where S1 should be in that
  case the regular covariance matrix.
}
\value{
  A matrix containing the estimated one step Tyler shape matrix.
}
\references{ \cite{Critchley , F., Pires, A. and Amado, C. (2006),  Principal axis analysis, \emph{Technical Report}, \bold{06/14}, The Open University Milton Keynes.}

             \cite{Tyler, D.E., Critchley, F., \enc{D?mbgen}{Duembgen}, L. and Oja, H. (2009), Invariant co-ordinate selecetion, \emph{Journal of the Royal Statistical Society},Series B, \bold{71},  549--592. <doi:10.1111/j.1467-9868.2009.00706.x>.}   }
\author{Klaus Nordhausen}

\seealso{\code{\link{ics}} }
\examples{

data(iris)
iris.centered <- sweep(iris[,1:4], 2, colMeans(iris[,1:4]), "-")
iris.paa <- ics(iris.centered, cov, covAxis, stdKurt = FALSE)
summary(iris.paa)
plot(iris.paa, col=as.numeric(iris[,5]))
mean(iris.paa@gKurt)
emp.align <- iris.paa@gKurt
emp.align

screeplot(iris.paa)
abline(h = 1)



}
\keyword{multivariate}
