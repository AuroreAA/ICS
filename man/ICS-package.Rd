\name{ICS-package}
\alias{ICS-package}

\docType{package}
\title{
\packageTitle{ICS}
}
\description{
\packageDescription{ICS}
}
\details{
\packageDESCRIPTION{ICS}

Some multivariate tests and estimates are not affine equivariant by nature. A possible remedy for the lack of that property is to transform the data points to an invariant coordinate system,
construct tests and estimates from the transformed data, and if needed, retransform the estimates back. The use of two different
scatter matrices to obtain invariant coordinates is implemeted in this package by the function \code{ICS}. For an invariant coordinate selection no
assumptions are made about the data or the scatter matrices and it can be seen as a data transformation method. If the data come, however, from a so called independent component model
the \code{ICS} function can recover the independent components and estimate the mixing matrix under general assumptions.
Besides, the function \code{ICS} provides these package tools to work with objects of this class, and some
scatter matrices which can be used in the \code{ICS} function. Furthermore, there are also two tests for multinormality.
Note that starting with version 1.4-0 the functions \code{ics} and \code{ics2} are not recommended anymore and everything can be done in a more efficient way using the function \code{ICS} which combines
the functionality of the original two functions and also provides an improved algorithm for certain scatter combinations. Furthermore, does \code{ICS} return
an S3 object and not anymore S4 objects as \code{ics} and \code{ics2} did. In the long run functions \code{ics} and \code{ics2} will be removed from the package.

\packageIndices{ICS}
}

\references{
   \cite{Tyler, D.E., Critchley, F., \enc{Dümbgen}{Duembgen}, L. and Oja, H. (2009), Invariant co-ordinate selecetion, \emph{Journal of the Royal Statistical Society},Series B, \bold{71},  549--592. <doi:10.1111/j.1467-9868.2009.00706.x>.}

   \cite{Oja, H., \enc{Sirkiä}{Sirkia}, S. and Eriksson, J. (2006), Scatter matrices and independent component analysis, \emph{Austrian Journal of Statistics}, \bold{35},  175--189.}

   \cite{Nordhausen, K., Oja, H. and Tyler, D.E. (2008), Tools for exploring multivariate data: The package \pkg{ICS}, \emph{Journal of Statistical Software}, \bold{28}, 1--31. <doi:10.18637/jss.v028.i06>.}

   \cite{Archimbaud, A., Drmac, Z., Nordhausen, K., Radojicic, U. and Ruiz-Gazen, A. (2023), Numerical considerations and a new implementation for ICS, \emph{SIAM Journal on Mathematics of Data Science}, \bold{5}, 97--121.  <doi:10.1137/22M1498759>.}
}


\author{
\packageAuthor{ICS}

Maintainer: \packageMaintainer{ICS}
}

\keyword{package}
