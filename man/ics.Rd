\encoding{latin1}

\name{ics}
\alias{ics}

\title{ Two Scatter Matrices ICS Transformation }
\description{
  Implements the two scatter matrices transformation to obtain an invariant coordinate sytem or independent
  components, depending on the underlying assumptions.
}
\usage{
ics(X, S1 = cov, S2 = cov4, S1args = list(), S2args = list(),
    stdB = "Z", stdKurt = TRUE, na.action = na.fail)
}

\arguments{
  \item{X}{ numeric data matrix or dataframe.}
  \item{S1}{ name of the first scatter matrix function or a scatter matrix. Default is the regular covariance matrix.}
  \item{S2}{ name of the second scatter matrix or a scatter matrix. Default is the covariance matrix based on forth order moments.
             Note that the type of S2 must be the same as S1.}
  \item{S1args}{ list with optional additional arguments for S1. Only considered if S1 is a function.}
  \item{S2args}{ list with optional additional arguments for S2. Only considered if S2 is a function.}
  \item{stdB}{ either "B" or "Z". Defines the way to standardize the matrix B. Default is "Z". Details are given below.}
  \item{stdKurt}{ Logical, either "TRUE" or "FALSE". Specifies weather the product of the kurtosis values is 1 or not.}
  \item{na.action}{ a function which indicates what should happen when the data
          contain 'NA's.  Default is to fail.}
}
\details{
  Seeing this function as a tool for data transformation the result is an invariant coordinate selection which can be used for test and estimation. And
  if needed the results can be easily retransformed to the original scale. It is possible to use it also for dimension reduction, in order to find outliers or clusters in the data.
  The function can, also be used in a modelling framework. In this case it is assumed that the data were created by mixing independent components which
  have different kurtosis values. If the two scatter matrices used have the so-called independence property the function can recover the independent components
  by estimating the unmixing matrix.

  By default S1 is the regular covariance matrix \code{\link{cov}} and S2 the matrix of fourth moments \code{\link{cov4}}. However those can be replaced with any other
  scatter matrix the user prefers. The package \pkg{ICS} offers for example also \code{\link{cov4.wt}}, \code{\link{covAxis}}, \code{\link{covOrigin}}, \code{\link{covW}} or \code{\link{tM}} and the \pkg{ICSNP} offers further scatters as \code{\link[ICSNP]{duembgen.shape}}, \code{\link[ICSNP]{tyler.shape}}, \code{\link[ICSNP]{HR.Mest}} or \code{\link[ICSNP]{HP1.shape}}.
  But of course also scatters from any other package can be used.

  Note that when function names are submitted, the function should return only a scatter matrix. If the function returns more, the scatter should be computed in advance or
  a wrapper written that yields the required output. For example \code{\link{tM}} returns a list with four elements where the scatter estimate is called V. A simple wrapper would then be
  \code{my.tm <- function(x, ...) tM(x, ...)$V}.

  For a given choice of S1 and S2, the general idea of the \code{ics} function is to find the unmixing matrix B and the invariant coordinates (independent coordinates)
  Z in such a way, that:

  \describe{
  \item{(i)}{The elements of Z are standardized with respect to S1 (S1(Z)=I).}
  \item{(ii)}{The elements of Z are uncorrelated with respect to S2. (S2(Z)=D, where D is a diagonal matrix).}
  \item{(iii)}{The elements of Z are ordered according to their generalized kurtosis.}
  }

  Given those criteria, B is unique up to sign changes of its rows. The function provides two options to decide the exact form of B.

  \describe{
  \item{(i)}{Method 'Z' standardizes B such, that all components are right skewed. The criterion used is the sign of each componentwise difference of mean vector and
  transformation retransformation median. This standardization is prefered in an invariant coordinate framework.}
  \item{(ii)}{Method 'B' standardizes B independent of Z such that the maximum element per row is positive and each row has norm 1. Usual way in an independent
  component analysis framework.}
  }

  In principal, if S1 and S2 are true scatter matrices the order does not matter. It will just reverse and invert the kurtosis value vector.
  This is however not true when one or both are shape matrices (and not both of them are scatter matrices). In this case the order of the kurtosis values is also reversed,
  the ratio however then is not 1 but only constant. This is due to the fact that when shape matrices are used, the kurtosis values are only relative ones.
  Therefore by the default the kurtosis values are standardized such that their product is 1. If no standardization is wanted, the 'stdKurt' argument should be used.


}
\value{
  an object of class \code{ics}.
}
\note{
Function \code{ics()} reached the end of its lifecycle, please use \code{\link[=ICS-S3]{ICS}()} instead. In future versions, \code{ics()} will be deprecated and eventually removed.
}
\references{
   \cite{Tyler, D.E., Critchley, F., \enc{D?mbgen}{Duembgen}, L. and Oja, H. (2009), Invariant co-ordinate selecetion, \emph{Journal of the Royal Statistical Society},Series B, \bold{71},  549--592. <doi:10.1111/j.1467-9868.2009.00706.x>.}

   \cite{Oja, H., \enc{Sirki?}{Sirkia}, S. and Eriksson, J. (2006), Scatter matrices and independent component analysis, \emph{Austrian Journal of Statistics}, \bold{35},  175--189.}

   \cite{Nordhausen, K., Oja, H. and Tyler, D.E. (2008), Tools for exploring multivariate data: The package ICS, \emph{Journal of Statistical Software}, \bold{28}, 1--31. <doi:10.18637/jss.v028.i06>.}
}
\author{Klaus Nordhausen}


\seealso{
  \code{\link{ICS-package}}, \code{\link[=ICS-S3]{ICS}}
}
\examples{
    # example using two functions
    set.seed(123456)
    X1 <- rmvnorm(250, rep(0,8), diag(c(rep(1,6),0.04,0.04)))
    X2 <- rmvnorm(50, c(rep(0,6),2,0), diag(c(rep(1,6),0.04,0.04)))
    X3 <- rmvnorm(200, c(rep(0,7),2), diag(c(rep(1,6),0.04,0.04)))

    X.comps <- rbind(X1,X2,X3)
    A <- matrix(rnorm(64),nrow=8)
    X <- X.comps \%*\% t(A)

    ics.X.1 <- ics(X)
    summary(ics.X.1)
    plot(ics.X.1)

    # compare to
    pairs(X)
    pairs(princomp(X,cor=TRUE)$scores)

    # slow:

    # library(ICSNP)
    # ics.X.2 <- ics(X, tyler.shape, duembgen.shape, S1args=list(location=0))
    # summary(ics.X.2)
    # plot(ics.X.2)

    rm(.Random.seed)

    # example using two computed scatter matrices for outlier detection

    library(robustbase)
    ics.wood<-ics(wood,tM(wood)$V,tM(wood,2)$V)
    plot(ics.wood)

    # example using three pictures
    library(pixmap)

    fig1 <- read.pnm(system.file("pictures/cat.pgm", package = "ICS")[1])
    fig2 <- read.pnm(system.file("pictures/road.pgm", package = "ICS")[1])
    fig3 <- read.pnm(system.file("pictures/sheep.pgm", package = "ICS")[1])

    p <- dim(fig1@grey)[2]

    fig1.v <- as.vector(fig1@grey)
    fig2.v <- as.vector(fig2@grey)
    fig3.v <- as.vector(fig3@grey)
    X <- cbind(fig1.v,fig2.v,fig3.v)

    set.seed(4321)
    A <- matrix(rnorm(9), ncol = 3)
    X.mixed <- X \%*\% t(A)

    ICA.fig <- ics(X.mixed)

    par.old <- par()
    par(mfrow=c(3,3), omi = c(0.1,0.1,0.1,0.1), mai = c(0.1,0.1,0.1,0.1))

    plot(fig1)
    plot(fig2)
    plot(fig3)

    plot(pixmapGrey(X.mixed[,1],ncol=p))
    plot(pixmapGrey(X.mixed[,2],ncol=p))
    plot(pixmapGrey(X.mixed[,3],ncol=p))

    plot(pixmapGrey(ics.components(ICA.fig)[,1],ncol=p))
    plot(pixmapGrey(ics.components(ICA.fig)[,2],ncol=p))
    plot(pixmapGrey(ics.components(ICA.fig)[,3],ncol=p))

    par(par.old)
    rm(.Random.seed)
    }

\keyword{models}
\keyword{multivariate}
