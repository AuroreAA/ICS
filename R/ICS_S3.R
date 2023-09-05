# Scatter functions returning class "ICS_scatter" -----

#' Location and Scatter Estimates for ICS
#'
#' Computes a scatter matrix and an optional location vector to be used in
#' transforming the data to an invariant coordinate system or independent
#' components.
#'
#' \code{ICS_cov()} is a wrapper for the sample covariance matrix as computed
#' by \code{\link[stats]{cov}()}.
#'
#' \code{ICS_cov4()} is a wrapper for the scatter matrix based on fourth
#' moments as computed by \code{\link{cov4}()}. Note that the scatter matrix
#' is always computed with respect to the sample mean, even though the returned
#' location component can be specified to be based on third moments as computed
#' by \code{\link{mean3}()}.  Setting a location component other than the
#' sample mean can be used to fix the signs of the invariant coordinates in
#' \code{\link{ICS}()} based on generalized skewness values, for instance
#' when using the scatter pair \code{ICS_cov()} and \code{ICS_cov4()}.
#'
#' \code{ICS_covW()} is a wrapper for the one-step M-estimator of scatter as
#' computed by \code{\link{covW}()}.
#'
#' \code{ICS_covAxis()} is a wrapper for the one-step Tyler shape matrix as
#' computed by \code{\link{covAxis}()}, which is can be used to perform
#' Principal Axis Analysis.
#'
#' \code{ICS_tM()} is a wrapper for the M-estimator of location and scatter
#' for a multivariate t-distribution, as computed by \code{\link{tM}()}.
#'
#' \code{ICS_scovq()} is a wrapper for the supervised scatter matrix based
#'  on quantiles scatter, as computed by \code{\link{scovq}()}.
#'
#' @name ICS_scatter
#'
#' @param x  a numeric matrix or data frame.
#' @param location  for \code{ICS_cov()}, \code{ICS_cov4()}, \code{ICS_covW()},
#' and \code{ICS_covAxis()}, a logical indicating whether to include the sample
#' mean as location estimate (default to \code{TRUE}).  For \code{ICS_cov4()},
#' alternatively a character string specifying the location estimate can be
#' supplied.  Possible values are \code{"mean"} for the sample mean (the
#' default), \code{"mean3"} for a location estimate based on third moments,
#' or \code{"none"} to not include a location estimate.  For \code{ICS_tM()}
#' a logical inficating whether to include the M-estimate of location
#' (default to \code{TRUE}).
#'
#' @return An object of class \code{"ICS_scatter"} with the following
#' components:
#' \item{location}{if requested, a numeric vector giving the location
#' estimate.}
#' \item{scatter}{a numeric matrix giving the estimate of the scatter matrix.}
#' \item{label}{a character string providing a label for the scatter matrix.}
#'
#' @author Andreas Alfons and Aurore Archimbaud
#'
#' @references
#' Arslan, O., Constable, P.D.L. and Kent, J.T. (1995) Convergence behaviour of
#' the EM algorithm for the multivariate t-distribution, \emph{Communications
#' in Statistics, Theory and Methods}, \bold{24}(12), 2981--3000.
#' \doi{10.1080/03610929508831664}.
#'
#' Critchley, F., Pires, A. and Amado, C. (2006) Principal Axis Analysis.
#' Technical Report, \bold{06/14}. The Open University, Milton Keynes.
#'
#' Kent, J.T., Tyler, D.E. and Vardi, Y. (1994) A curious likelihood identity
#' for the multivariate t-distribution, \emph{Communications in Statistics,
#' Simulation and Computation}, \bold{23}(2), 441--453.
#' \doi{10.1080/03610919408813180}.
#'
#' Oja, H., Sirkia, S. and Eriksson, J. (2006) Scatter Matrices and Independent
#' Component Analysis. \emph{Austrian Journal of Statistics}, \bold{35}(2&3),
#' 175-189. \doi{10.17713/ajs.v35i2&3.364}.
#'
#' Tyler, D.E., Critchley, F., Duembgen, L. and Oja, H. (2009) Invariant
#' Co-ordinate Selection. \emph{Journal of the Royal Statistical Society,
#' Series B}, \bold{71}(3), 549--592. \doi{10.1111/j.1467-9868.2009.00706.x}.
#'
#' @seealso
#' \code{\link{ICS}()}
#'
#' \code{\link[base:colSums]{colMeans}()}, \code{\link{mean3}()}
#'
#' \code{\link[stats]{cov}()}, \code{\link{cov4}()}, \code{\link{covW}()},
#' \code{\link{covAxis}()}, \code{\link{tM}()}, \code{\link{scovq}()}
#'
#' @examples
#' data("iris")
#' X <- iris[,-5]
#' ICS_cov(X)
#' ICS_cov4(X)
#' ICS_covW(X, alpha = 1, cf = 1/(ncol(X)+2))
#' ICS_covAxis(X)
#' ICS_tM(X)
#'
#'
#' # The number of explaining variables
#' p <- 10
#' # The number of observations
#' n <- 400
#' # The error variance
#' sigma <- 0.5
#' # The explaining variables
#' X <- matrix(rnorm(p*n),n,p)
#' # The error term
#' epsilon <- rnorm(n, sd = sigma)
#' # The response
#' y <- X[,1]^2 + X[,2]^2*epsilon
#' ICS_scovq(X, y = y)
#'
#' @importFrom stats cov
#' @export

ICS_cov <- function(x, location = TRUE) {
  # initializations
  x <- as.matrix(x)
  location <- isTRUE(location)
  # compute location and scatter estimates
  location <- if (location) colMeans(x)
  out <- list(location = location, scatter = cov(x), label = "COV")
  # add class and return object
  class(out) <- "ICS_scatter"
  out
}


#' @name ICS_scatter
#' @export

ICS_cov4 <- function(x, location = c("mean", "mean3", "none")) {
  # initializations
  x <- as.matrix(x)
  if (is.character(location)) location <- match.arg(location)
  else if (isTRUE(location)) location <- "mean"
  else location <- "none"
  # compute location and scatter estimates
  location <- switch(location, "mean" = colMeans(x), "mean3" = mean3(x))
  out <- list(location = location, scatter = cov4(x), label = get_cov4_label())
  # add class and return object
  class(out) <- "ICS_scatter"
  out
}


#' @name ICS_scatter
#'
#' @param alpha  parameter of the one-step M-estimator (default to 1).
#' @param cf  consistency factor of the one-step M-estimator (default to 1).
#'
#' @export

ICS_covW <- function(x, location = TRUE, alpha = 1, cf = 1) {
  # initializations
  x <- as.matrix(x)
  location <- isTRUE(location)
  # compute location and scatter estimates
  location <- if (location) colMeans(x)
  scatter <- covW(x, alpha = alpha, cf = cf)
  out <- list(location = location, scatter = scatter, label = get_covW_label())
  # add class and return object
  class(out) <- "ICS_scatter"
  out
}


#' @name ICS_scatter
#' @export

ICS_covAxis <- function(x, location = TRUE) {
  # initializations
  x <- as.matrix(x)
  location <- isTRUE(location)
  # compute location and scatter estimates
  location <- if (location) colMeans(x)
  out <- list(location = location, scatter = covAxis(x),
              label = get_covAxis_label())
  # add class and return object
  class(out) <- "ICS_scatter"
  out
}


#' @name ICS_scatter
#'
#' @param df  assumed degrees of freedom of the t-distribution (default to 1,
#' which corresponds to the Cauchy distribution).
#' @param \dots  additional arguments to be passed down to \code{\link{tM}()}.
#'
#' @export

ICS_tM <- function(x, location = TRUE, df = 1, ...) {
  # initializations
  location <- isTRUE(location)
  # compute location and scatter estimates
  mlt <- tM(x, df = df, ...)
  location <- if (location) mlt$mu
  # construct object to be returned
  out <- list(location = location, scatter = mlt$V, label = "MLT")
  class(out) <- "ICS_scatter"
  out
}


#' @name ICS_scatter
#'
#' @param y  numerical vector specifying the dependent variable.
#' @param \dots  additional arguments to be passed down to \code{\link{scovq}()}.
#'
#' @export

ICS_scovq <- function(x, y, ...) {
  # compute location and scatter estimates
  scov <- scovq(x = x, y = y, ...)
  # construct object to be returned
  out <- list(location = NULL, scatter =  scov, label = "SCOVQ")
  class(out) <- "ICS_scatter"
  out
}

# Main function to compute ICS -----

#' Two Scatter Matrices ICS Transformation
#'
#' Transforms the data via two scatter matrices to an invariant coordinate
#' system or independent components, depending on the underlying assumptions.
#' Function \code{ICS()} is intended as a replacement for \code{\link{ics}()}
#' and \code{\link{ics2}()}, and it combines their functionality into a single
#' function. Importantly, the results are returned as an
#' \code{\link[base:class]{S3}} object rather than an
#' \code{\link[methods:Classes_Details]{S4}} object. Furthermore, \code{ICS()}
#' implements recent improvements, such as a numerically stable algorithm based
#' on the QR algorithm for a common family of scatter pairs.
#'
#' For a given scatter pair \eqn{S_{1}}{S1} and \eqn{S_{2}}{S2}, a matrix
#' \eqn{Z} (in which the columns contain the scores of the respective invariant
#' coordinates) and a matrix \eqn{W} (in which the rows contain the
#' coefficients of the linear transformation to the respective invariant
#' coordinates) are found such that:
#' \itemize{
#'   \item The columns of \eqn{Z} are whitened with respect to
#'   \eqn{S_{1}}{S1}. That is, \eqn{S_{1}(Z) = I}{S1(Z) = I}, where \eqn{I}
#'   denotes the identity matrix.
#'   \item The columns of \eqn{Z} are uncorrelated with respect to
#'   \eqn{S_{2}}{S2}. That is, \eqn{S_{2}(Z) = D}{S2(Z) = D}, where \eqn{D}
#'   is a diagonal matrix.
#'   \item The columns of \eqn{Z} are ordered according to their generalized
#'   kurtosis.
#' }
#'
#' Given those criteria, \eqn{W} is unique up to sign changes in its rows. The
#' argument \code{fix_signs} provides two ways to ensure uniqueness of \eqn{W}:
#' \itemize{
#'   \item If argument \code{fix_signs} is set to \code{"scores"}, the signs
#'   in \eqn{W} are fixed such that the generalized skewness values of all
#'   components are positive. If \code{S1} and \code{S2} provide location
#'   components, which are denoted by \eqn{T_{1}}{T1} and \eqn{T_{2}}{T2},
#'   the generalized skewness values are computed as
#'   \eqn{T_{1}(Z) - T_{2}(Z)}{T1(Z) - T2(Z)}.
#'   Otherwise, the skewness is computed by subtracting the column medians of
#'   \eqn{Z} from the corresponding column means so that all components are
#'   right-skewed. This way of fixing the signs is preferred in an invariant
#'   coordinate selection framework.
#'   \item If argument \code{fix_signs} is set to \code{"W"}, the signs in
#'   \eqn{W} are fixed independently of \eqn{Z} such that the maximum element
#'   in each row of \eqn{W} is positive and that each row has norm 1. This is
#'   the usual way of fixing the signs in an independent component analysis
#'   framework.
#' }
#'
#' In principal, the order of \eqn{S_{1}}{S1} and \eqn{S_{2}}{S2} does not
#' matter if both are true scatter matrices. Changing their order will just
#' reverse the order of the components and invert the corresponding
#' generalized kurtosis values.
#'
#' The same does not hold when at least one of them is a shape matrix rather
#' than a true scatter matrix. In that case, changing their order will also
#' reverse the order of the components, but the ratio of the generalized
#' kurtosis values is no longer 1 but only a constant. This is due to the fact
#' that when shape matrices are used, the generalized kurtosis values are only
#' relative ones.
#'
#' Different algorithms are available to compute the invariant coordinate
#' system of a data frame \eqn{X_n} with \eqn{n} observations:
#' - **"whiten"**: whitens the data \eqn{X_n} with respect to the first
#' scatter matrix before computing the second scatter matrix. If \code{S2} is not a function, whitening is not applicable.
#'    -  whiten the data \eqn{X_n} with respect to the first
#' scatter matrix: \eqn{Y_n =  X_n S_1(X_n)^{-1/2}}
#'    - compute \eqn{S_2} for the uncorrelated data: \eqn{S_2(Y_n)}
#'    - perform the eigendecomposition of \eqn{S_2(Y_n)}: \eqn{S_2(Y_n) = UDU'}
#'    - compute \eqn{W}: \eqn{W = U' S_1(X_n)^{-1/2}}
#'
#'
#' - **"standard"**: performs the spectral decomposition of the
#' symmetric matrix  \eqn{M(X_n)}
#'    - compute \eqn{M(X_n) = S_1(X_n)^{-1/2} S_2(X_n) S_1(X_n)^{-1/2}}
#'    - perform the eigendecomposition of \eqn{M(X_n)}: \eqn{M(X_n) = UDU'}
#'    - compute \eqn{W}: \eqn{W = U' S_1(X_n)^{-1/2}}
#'
#' - **"QR"**: numerically stable algorithm based on the QR algorithm for a
#'  common family of scatter pairs: if \code{S1} is \code{\link{ICS_cov}()}
#'   or \code{\link[stats]{cov}()}, and if \code{S2} is one of
#'    \code{\link{ICS_cov4}()}, \code{\link{ICS_covW}()}
#'    , \code{\link{ICS_covAxis}()}, \code{\link{cov4}()},
#'    \code{\link{covW}()}, or \code{\link{covAxis}()}.
#'    For other scatter pairs, the QR algorithm is not
#'    applicable.   See Archimbaud et al. (2023)
#'   for details.
#'
#' The "whiten" algorithm is the most natural version and therefore the default. The option "standard"
#' should be only used if the scatters provided are not functions but precomputed matrices.
#' The option "QR" is mainly of interest when there are numerical issues when "whiten" is used and the
#' scatter combination allows its usage.
#'
#' Note that when the purpose of ICS is outlier detection the package \link[ICSOutlier]{ICSOutlier}
#' provides additional functionalities as does the package `ICSClust` in case the
#' goal of ICS is dimension reduction prior clustering.
#'
#' @name ICS-S3
#'
#' @param X  a numeric matrix or data frame containing the data to be
#' transformed.
#' @param S1  a numeric matrix containing the first scatter matrix, an object
#' of class \code{"ICS_scatter"} (that typically contains the location vector
#' and scatter matrix as \code{location} and \code{scatter} components), or a
#' function that returns either of those options. The default is function
#' \code{\link{ICS_cov}()} for the sample covariance matrix.
#' @param S2  a numeric matrix containing the second scatter matrix, an object
#' of class \code{"ICS_scatter"} (that typically contains the location vector
#' and scatter matrix as \code{location} and \code{scatter} components), or a
#' function that returns either of those options. The default is function
#' \code{\link{ICS_cov4}()} for the covariance matrix based on fourth order
#' moments.
#' @param S1_args  a list containing additional arguments for \code{S1} (only
#' relevant if \code{S1} is a function).
#' @param S2_args  a list containing additional arguments for \code{S2} (only
#' relevant if \code{S2} is a function).
#' @param algorithm a character string specifying with which algorithm
#' the invariant coordinate system is computed. Possible values are
#'  \code{"whiten"}, \code{"standard"} or \code{"QR"}.
#' See \sQuote{Details} for more information.
#' @param center  a logical indicating whether the invariant coordinates should
#' be centered with respect to first locattion or not (default to \code{FALSE}).
#' Centering is only applicable if the
#' first scatter object contains a location component, otherwise this is set to
#' \code{FALSE}. Note that this only affects the scores of the invariant
#' components (output component \code{scores}), but not the generalized
#' kurtosis values (output component \code{gen_kurtosis}).
#' @param fix_signs a character string specifying how to fix the signs of the
#' invariant coordinates. Possible values are \code{"scores"} to fix the signs
#' based on (generalized) skewness values of the coordinates, or \code{"W"} to
#' fix the signs based on the coefficient matrix of the linear transformation.
#' See \sQuote{Details} for more information.
#' @param na.action  a function to handle missing values in the data (default
#' to \code{\link[stats]{na.fail}}, see its help file for alternatives).
#'
#' @return An object of class \code{"ICS"} with the following components:
#' \item{gen_kurtosis}{a numeric vector containing the generalized kurtosis
#' values of the invariant coordinates.}
#' \item{W}{a numeric matrix in which each row contains the coefficients of the
#' linear transformation to the corresponding invariant coordinate.}
#' \item{scores}{a numeric matrix in which each column contains the scores of
#' the corresponding invariant coordinate.}
#' \item{gen_skewness}{a numeric vector containing the (generalized) skewness
#' values of the invariant coordinates (only returned if
#' \code{fix_signs = "scores"}).}
#' \item{S1_label}{a character string providing a label for the first scatter
#' matrix to be used by various methods.}
#' \item{S2_label}{a character string providing a label for the second scatter
#' matrix to be used by various methods.}
#' \item{S1_args}{a list containing additional arguments used to compute
#' \code{S1} (if a function was supplied).}
#' \item{S2_args}{a list containing additional arguments used to compute
#' \code{S2} (if a function was supplied).}
#' \item{algorithm}{a character string specifying how the invariant
#'  coordinate is computed.}
#' \item{center}{a logical indicating whether or not the data were centered
#' with respect to the first location vector before computing the invariant
#' coordinates.}
#' \item{fix_signs}{a character string specifying how the signs of the
#' invariant coordinates were fixed.}
#'
#' @author Andreas Alfons and Aurore Archimbaud, based on code for
#' \code{\link{ics}()} and \code{\link{ics2}()} by Klaus Nordhausen
#'
#' @references
#'
#' Tyler, D.E., Critchley, F., Duembgen, L. and Oja, H. (2009) Invariant
#' Co-ordinate Selection. \emph{Journal of the Royal Statistical Society,
#' Series B}, \bold{71}(3), 549--592. \doi{10.1111/j.1467-9868.2009.00706.x}.
#'
#' Archimbaud, A., Drmac, Z., Nordhausen, K., Radojcic, U. and Ruiz-Gazen, A.
#' (2023) Numerical Considerations and a New Implementation for Invariant
#' Coordinate Selection. \emph{SIAM Journal on Mathematics of Data Science},
#' \bold{5}(1), 97--121. \doi{10.1137/22M1498759}.
#'
#' @seealso \code{\link{gen_kurtosis}()}, \code{\link[=coef.ICS]{coef}()},
#' \code{\link{components}()}, \code{\link[=fitted.ICS]{fitted}()}, and
#' \code{\link[=plot.ICS]{plot}()} methods
#'
#' @examples
#' # import data
#' data("iris")
#' X <- iris[,-5]
#'
#' # run ICS
#' out_ICS <- ICS(X)
#' out_ICS
#' summary(out_ICS)
#'
#' # extract generalized eigenvalues
#' gen_kurtosis(out_ICS)
#' # Plot
#' screeplot(out_ICS)
#'
#' # extract the components
#' components(out_ICS)
#' components(out_ICS, select = 1:2)
#'
#' # Plot
#' plot(out_ICS)
#'
#' # equivalence with previous functions
#' out_ics <- ics(X, S1 = cov, S2 = cov4, stdKurt = FALSE)
#' out_ics
#' out_ics2 <- ics2(X, S1 = MeanCov, S2 = Mean3Cov4)
#' out_ics2
#' out_ICS
#'
#'
#' # example using two functions
#' X1 <- rmvnorm(250, rep(0,8), diag(c(rep(1,6),0.04,0.04)))
#' X2 <- rmvnorm(50, c(rep(0,6),2,0), diag(c(rep(1,6),0.04,0.04)))
#' X3 <- rmvnorm(200, c(rep(0,7),2), diag(c(rep(1,6),0.04,0.04)))
#' X.comps <- rbind(X1,X2,X3)
#' A <- matrix(rnorm(64),nrow=8)
#' X <- X.comps %*% t(A)
#' ics.X.1 <- ICS(X)
#' summary(ics.X.1)
#' plot(ics.X.1)
#' # compare to
#' pairs(X)
#' pairs(princomp(X,cor=TRUE)$scores)
#'
#'
#' # slow:
#' if (require("ICSNP")) {
#'   ics.X.2 <- ICS(X, S1 = tyler.shape, S2 = duembgen.shape,
#'   S1_args = list(location=0))
#'   summary(ics.X.2)
#'   plot(ics.X.2)
#'   # example using three pictures
#'   library(pixmap)
#'   fig1 <- read.pnm(system.file("pictures/cat.pgm", package = "ICS")[1],
#'                    cellres = 1)
#'   fig2 <- read.pnm(system.file("pictures/road.pgm", package = "ICS")[1],
#'                    cellres = 1)
#'   fig3 <- read.pnm(system.file("pictures/sheep.pgm", package = "ICS")[1],
#'                    cellres = 1)
#'   p <- dim(fig1@grey)[2]
#'   fig1.v <- as.vector(fig1@grey)
#'   fig2.v <- as.vector(fig2@grey)
#'   fig3.v <- as.vector(fig3@grey)
#'   X <- cbind(fig1.v, fig2.v, fig3.v)
#'   A <- matrix(rnorm(9), ncol = 3)
#'   X.mixed <- X %*% t(A)
#'   ICA.fig <- ICS(X.mixed)
#'   par.old <- par()
#'   par(mfrow=c(3,3), omi = c(0.1,0.1,0.1,0.1), mai = c(0.1,0.1,0.1,0.1))
#'   plot(fig1)
#'   plot(fig2)
#'   plot(fig3)
#'   plot(pixmapGrey(X.mixed[,1], ncol = p, cellres = 1))
#'   plot(pixmapGrey(X.mixed[,2], ncol = p, cellres = 1))
#'   plot(pixmapGrey(X.mixed[,3], ncol = p, cellres = 1))
#'   plot(pixmapGrey(components(ICA.fig)[,1], ncol = p, cellres = 1))
#'   plot(pixmapGrey(components(ICA.fig)[,2], ncol = p, cellres = 1))
#'   plot(pixmapGrey(components(ICA.fig)[,3], ncol = p, cellres = 1))
#' }
#' @importFrom stats cov na.fail
#' @export

ICS <- function(X, S1 = ICS_cov, S2 = ICS_cov4, S1_args = list(),
                S2_args = list(),
                algorithm = c("whiten", "standard", "QR"),
                center = FALSE, fix_signs = c("scores", "W"),
                na.action = na.fail) {

  # make sure we have a suitable data matrix
  X <- na.action(X)
  X <- as.matrix(X)
  p <- ncol(X)
  if (p < 2L) stop("'X' must be at least bivariate")

  # match algorithm
  algorithm <- match.arg(algorithm)
  QR <- ifelse(algorithm == "QR", TRUE, FALSE)
  whiten <- ifelse(algorithm == "whiten", TRUE, FALSE)

  # obtain default labels for scatter matrices
  S1_label <- deparse(substitute(S1))
  S2_label <- deparse(substitute(S2))

  # check argument for QR algorithm
  # QR algorithm requires a certain class of scatter pairs supplied as functions
  if (isTRUE(QR)){
    have_cov <- identical(S1, cov) || identical(S1, ICS_cov)
    have_cov4 <- identical(S2, cov4) || identical(S2, ICS_cov4)
    have_covW <- identical(S2, covW) || identical(S2, ICS_covW)
    have_covAxis <- identical(S2, covAxis) || identical(S2, ICS_covAxis)
    if (!(have_cov && (have_cov4 || have_covW || have_covAxis))) {
      warning("QR algorithm is not applicable; proceeding without it")
      QR <- FALSE
    }
  }
  # check argument for whitening
  # whitening requires S2 to be a function
  if (isTRUE(whiten)) {
    if (!is.function(S2)) {
      warning("whitening requires 'S2' to be a function; ",
              "proceeding without whitening")
      whiten <- FALSE
      algorithm <- "standard"
    }
  }

  # check remaining arguments
  center <- isTRUE(center)
  fix_signs <- match.arg(fix_signs)

  # obtain first scatter matrix
  if (is.function(S1)) {
    S1_X <- get_scatter(X, fun = S1, args = S1_args, label = S1_label)
  } else {
    S1_X <- to_ICS_scatter(S1, label = S1_label)
    if (length(S1_args) > 0L) {
      warning("'S1' is not a function; ignoring additional arguments")
      S1_args <- list()
    }
  }
  # update label for first scatter matrix
  S1_label <- S1_X$label

  # obtain second scatter matrix
  if (QR) {

    ## perform numerically stable algorithm based on QR decomposition (second
    ## scatter matrix is specified as a function for a one-step M-estimator)

    # further initializations
    n <- nrow(X)

    # obtain column means: if ICS_cov() is used, we may already have them in
    # location component of S1_X (S1 is either cov() or ICS_cov())
    T1_X <- S1_X$location
    if (is.null(T1_X)) T1_X <- colMeans(X)
    # center the columns of data matrix by the mean
    X_centered <- sweep(X, 2L, T1_X, "-")

    # reorder rows by decreasing by infinity norm (maximum in absolute value)
    norm_inf <- apply(abs(X_centered), 1L, max)
    order_rows <- order(norm_inf, decreasing = TRUE)
    X_reordered <- X_centered[order_rows, ]

    # compute QR decomposition with column pivoting from LAPACK: note that this
    # changes the order of the columns internally, which we need to take into
    # account when returning the matrix W of coefficients (or other output)
    qr_X <- qr(X_reordered / sqrt(n-1), LAPACK = TRUE)

    # extract components of the QR decomposition
    Q <- qr.Q(qr_X)  # should be nxp
    R <- qr.R(qr_X)  # should be pxp

    # compute squared Mahalanobis distances (leverage scores)
    d <- (n-1) * rowSums(Q^2)

    # obtain arguments for one-step M-estimator and update label for S2
    if (have_cov4) {
      alpha <- 1
      cf <- 1 / (p+2)
      S2_label <- get_cov4_label()
    } else if (have_covAxis) {
      alpha <- -1
      cf <- p
      S2_label <- get_covAxis_label()
    } else {
      # COVW: get arguments from supplied list or function defaults
      alpha <- S2_args$alpha
      if (is.null(alpha)) alpha <- formals(covW)$alpha
      cf <- S2_args$cf
      if (is.null(cf)) cf <- formals(covW)$cf
      S2_label <- get_covW_label()
    }

    # compute the second scatter matrix: this works for one-step M-estimators
    S2_Y <- cf*(n-1)/n * crossprod(sweep(Q, 1L, d^alpha, "*"), Q)

    # convert second scatter matrix to class "ICS_scatter"
    S2_Y <- to_ICS_scatter(S2_Y, label = S2_label)

    # set flag that we don't have location component in S2_X for fixing
    # signs in W (since we don't have S2_X)
    missing_T2_X <- TRUE

  } else {

    # compute inverse of the square root of the first scatter matrix
    W1 <- mat_sqrt(S1_X$scatter, inverse = TRUE)

    # obtain second scatter matrix
    if (whiten) {
      # whiten the data with respect to the first scatter matrix
      Y <- X %*% W1
      # compute second scatter matrix on whitened data and update label
      S2_Y <- get_scatter(Y, fun = S2, args = S2_args, label = S2_label)
      S2_label <- S2_Y$label
      # set flag that we don't have location component in S2_X for fixing
      # signs in W (since we don't have S2_X)
      missing_T2_X <- TRUE
    } else {
      # obtain second scatter matrix on original data matrix
      if (is.function(S2)) {
        S2_X <- get_scatter(X, fun = S2, args = S2_args, label = S2_label)
      } else {
        S2_X <- to_ICS_scatter(S2, label = S2_label)
        if (length(S2_args) > 0L) {
          warning("'S2' is not a function; ignoring additional arguments")
          S2_args <- list()
        }
      }
      # update label for second scatter matrix
      S2_label <- S2_X$label
      # transform second scatter matrix
      S2_Y <- to_ICS_scatter(W1 %*% S2_X$scatter %*% W1, label = S2_label)
      # check if we have location component in S2_X for fixing signs in W
      T2_X <- S2_X$location
      missing_T2_X <- is.null(T2_X)
    }

    # if requested, center the columns of the data matrix
    if (center) {
      # center by the location estimate from S1_X or give warning
      # if S1_X doesn't have a location component
      T1_X <- S1_X$location
      if (is.null(T1_X)) {
        warning("location component in 'S1' required for centering the data; ",
                "proceeding without centering")
        center <- FALSE
      } else X_centered <- sweep(X, 2L, T1_X, "-")
    }

  }

  # compute eigendecomposition of second scatter matrix
  S2_Y_eigen <- eigen(S2_Y$scatter, symmetric = TRUE)
  # extract generalized kurtosis values
  gen_kurtosis <- S2_Y_eigen$values
  if (!all(is.finite(gen_kurtosis))) {
    warning("some generalized kurtosis values are non-finite")
  }
  # obtain coefficient matrix of the linear transformation
  if (QR) {
    # obtain matrix of coefficients in internal order from column pivoting
    W <- t(qr.solve(R, S2_Y_eigen$vectors))
    # reorder columns of W to correspond to original order of columns in X
    W <- W[, order(qr_X$pivot)]
  } else W <- crossprod(S2_Y_eigen$vectors, W1)

  # fix the signs in matrix W of coefficients
  if (fix_signs == "scores") {

    # the condition is phrased so that the last part is only evaluated when
    # necessary (and it is guaranteed that T1_X and T2_X actually exist)
    if (center && !(missing_T2_X || isTRUE(all.equal(T1_X, T2_X)))) {
      # compute generalized skewness values of each component
      T1_Z <- T1_X %*% W
      T2_Z <- T2_X %*% W
      gen_skewness <- as.vector(T1_Z - T2_Z)
    } else {
      # compute scores for initial matrix W of coefficients
      Z <- if (center) tcrossprod(X_centered, W) else tcrossprod(X, W)
      # compute skewness values of each component
      gen_skewness <- colMeans(Z) - apply(Z, 2L, median)
    }

    # compute signs of (generalized) skewness values for each component
    skewness_signs <- ifelse(gen_skewness >= 0, 1, -1)
    # fix signs in W so that generalized skewness values are positive
    gen_skewness <- skewness_signs * gen_skewness
    W_final <- sweep(W, 1L, skewness_signs, "*")

  } else {
    # fix signs in W so that the maximum element per row is positive
    # and that each row has norm 1
    row_signs <- apply(W, 1L, .sign.max)
    row_norms <- sqrt(rowSums(W^2))
    W_final <- sweep(W, 1L, row_norms * row_signs, "/")
    # we don't have (generalized) skewness values in this case
    gen_skewness <- NULL
  }

  # compute the component scores
  if (center) Z_final <- tcrossprod(X_centered, W_final)
  else Z_final <- tcrossprod(X, W_final)

  # set names for different parts of the output
  IC_names <- paste("IC", seq_len(p), sep = ".")
  names(gen_kurtosis) <- IC_names
  dimnames(W_final) <- list(IC_names, colnames(X))
  dimnames(Z_final) <- list(rownames(X), IC_names)
  if (!is.null(gen_skewness)) names(gen_skewness) <- IC_names



  # construct object to be returned
  res <- list(gen_kurtosis = gen_kurtosis, W = W_final, scores = Z_final,
              gen_skewness = gen_skewness, S1_label = S1_label,
              S2_label = S2_label, S1_args = S1_args, S2_args = S2_args,
              algorithm = algorithm, center = center, fix_signs = fix_signs)
  class(res) <- "ICS"
  res

}


# Methods for class "ICS" -----


#' To extract the Generalized Kurtosis Values of the ICS Transformation
#'
#' Extracts the generalized kurtosis values of the components obtained via an
#' ICS transformation.
#'
#' The argument \code{scale} is useful when ICS is performed with shape
#' matrices rather than true scatter matrices. Let \eqn{S_{1}}{S1} and
#' \eqn{S_{2}}{S2} denote the scatter or shape matrices used in ICS.
#'
#' If both \eqn{S_{1}}{S1} and \eqn{S_{2}}{S2} are true scatter matrices, their
#' order in principal does not matter. Changing their order will just reverse
#' the order of the components and invert the corresponding generalized
#' kurtosis values.
#'
#' The same does not hold when at least one of them is a shape matrix rather
#' than a true scatter matrix. In that case, changing their order will also
#' reverse the order of the components, but the ratio of the generalized
#' kurtosis values is no longer 1 but only a constant. This is due to the fact
#' that when shape matrices are used, the generalized kurtosis values are only
#' relative ones. It is then useful to scale the generalized kurtosis values
#' such that their product is 1.
#'
#' @param object  an object inheriting from class \code{"ICS"} containing
#' results from an ICS transformation.
#' @param select  an integer, character, or logical vector specifying for which
#' components to extract the generalized kurtosis values, or \code{NULL} to
#' extract the generalized kurtosis values of all components.
#' @param scale  a logical indicating whether to scale the generalized kurtosis
#' values to have product 1 (default to \code{FALSE}). See \sQuote{Details}
#' for more information.
#' @param index  an integer vector specifying for which components to extract
#' the generalized kurtosis values, or \code{NULL} to extract the generalized
#' kurtosis values of all components.  Note that \code{index} is deprecated
#' and may be removed in the future, use \code{select} instead.
#' @param \dots  additional arguments to be passed down.
#'
#' @return A numeric vector containing the generalized kurtosis values of the
#' requested components.
#'
#' @author Andreas Alfons and Aurore Archimbaud
#'
#' @seealso
#' \code{\link{ICS}()}
#'
#' \code{\link[=coef.ICS]{coef}()}, \code{\link{components}()},
#' \code{\link[=fitted.ICS]{fitted}()}, and \code{\link[=plot.ICS]{plot}()}
#' methods
#'
#' @examples
#' data("iris")
#' X <- iris[,-5]
#' out <- ICS(X)
#' gen_kurtosis(out)
#' gen_kurtosis(out, scale = TRUE)
#' gen_kurtosis(out, select = c(1,4))
#'
#' @export

gen_kurtosis <- function(object, ...) UseMethod("gen_kurtosis")

#' @name gen_kurtosis
#' @export
gen_kurtosis.ICS <- function(object, select = NULL, scale = FALSE,
                             index = NULL, ...) {
  # back-compatibility check
  if (missing(select) && !missing(index)) {
    warning("argument 'index' is deprecated, use 'select' instead")
    select <- index
  }
  # extract generalized kurtosis values
  gen_kurtosis <- object$gen_kurtosis
  p <- length(gen_kurtosis)
  # if requested, scale generalized kurtosis values
  if (isTRUE(scale)) gen_kurtosis <- gen_kurtosis / prod(gen_kurtosis)^(1/p)
  # check if we have argument of components to return
  if (!is.null(select)) {
    # check argument specifying components
    if (check_undefined(select, max = p, names = names(gen_kurtosis))) {
      stop("undefined components selected")
    }
    # select components
    gen_kurtosis <- gen_kurtosis[select]
  }
  # return generalized kurtosis values for selected components
  gen_kurtosis
}


#' To extract the Coefficient Matrix of the ICS Transformation
#'
#' Extracts the coefficient matrix of a linear transformation to an invariant
#' coordinate system. Each row of the matrix contains the coefficients of the
#' transformation to the corresponding component.
#'
#' @name coef.ICS-S3
#'
#' @param object  an object inheriting from class \code{"ICS"} containing
#' results from an ICS transformation.
#' @param select  an integer, character, or logical vector specifying for which
#' components to extract the coefficients, or \code{NULL} to extract the
#' coefficients for all components.
#' @param drop  a logical indicating whether to return a vector rather than a
#' matrix in case coefficients are extracted for a single component (default
#' to \code{FALSE}).
#' @param index  an integer vector specifying for which components to extract
#' the coefficients, or \code{NULL} to extract coefficients for all components.
#' Note that \code{index} is deprecated and may be removed in the future, use
#' \code{select} instead.
#' @param \dots  additional arguments are ignored.
#'
#' @return A numeric matrix or vector containing the coefficients for the
#' requested components.
#'
#' @author Andreas Alfons and Aurore Archimbaud
#'
#' @seealso
#' \code{\link{ICS}()}
#'
#' \code{\link{gen_kurtosis}()}, \code{\link{components}()},
#' \code{\link[=fitted.ICS]{fitted}()}, and \code{\link[=plot.ICS]{plot}()}
#' methods
#'
#' @examples
#' data("iris")
#' X <- iris[,-5]
#' out <- ICS(X)
#' coef(out)
#' coef(out, select = c(1,4))
#' coef(out, select = 1, drop = FALSE)
#'
#' @method coef ICS
#' @importFrom stats coef
#' @export

coef.ICS <- function(object, select = NULL, drop = FALSE, index = NULL, ...) {
  # back-compatibility check
  if (missing(select) && !missing(index)) {
    warning("argument 'index' is deprecated, use 'select' instead")
    select <- index
  }
  # extract coefficient matrix
  W <- object$W
  # check if we have argument of components to return
  if (!is.null(select)) {
    # check argument specifying components
    if (check_undefined(select, max = nrow(W), names = rownames(W))) {
      stop("undefined components selected")
    }
    # select components
    W <- W[select, , drop = drop]
  }
  # return coefficient matrix for selected components
  W
}


#' To extract the Component Scores of the ICS Transformation
#'
#' Extracts the components scores of an invariant coordinate system obtained
#' via an ICS transformation.
#'
#' @param x  an object inheriting from class \code{"ICS"} containing results
#' from an ICS transformation.
#' @param select  an integer, character, or logical vector specifying which
#' components to extract, or \code{NULL} to extract all components.
#' @param drop  a logical indicating whether to return a vector rather than a
#' matrix in case a single component is extracted (default to \code{FALSE}).
#' @param index  an integer vector specifying which components to extract, or
#' \code{NULL} to extract all components.  Note that \code{index} is deprecated
#' and may be removed in the future, use \code{select} instead.
#' @param \dots  additional arguments to be passed down.
#'
#' @return A numeric matrix or vector containing the requested components.
#'
#' @author Andreas Alfons and Aurore Archimbaud
#'
#' @seealso
#' \code{\link{ICS}()}
#'
#' \code{\link{gen_kurtosis}()}, \code{\link[=coef.ICS]{coef}()},
#' \code{\link[=fitted.ICS]{fitted}()}, and \code{\link[=plot.ICS]{plot}()}
#' methods
#'
#' @examples
#' data("iris")
#' X <- iris[,-5]
#' out <- ICS(X)
#' components(out)
#' components(out, select = c(1,4))
#' components(out, select = 1, drop = FALSE)
#'
#' @export

components <- function(x, ...) UseMethod("components")

#' @name components
#' @export
components.ICS <- function(x, select = NULL, drop = FALSE, index = NULL, ...) {
  # back-compatibility check
  if (missing(select) && !missing(index)) {
    warning("argument 'index' is deprecated, use 'select' instead")
    select <- index
  }
  # extract scores
  scores <- x$scores
  # check if we have argument of components to return
  if (!is.null(select)) {
    # check argument specifying components
    if (check_undefined(select, max = ncol(scores), names = colnames(scores))) {
      stop("undefined components selected")
    }
    # select components
    scores <- scores[, select, drop = drop]
  }
  # return matrix of scores for selected components
  scores
}


#' Fitted Values of the ICS Transformation
#'
#' Computes the fitted values based on an invariant coordinate system obtained
#' via an ICS transformation.  When using all components, computing the fitted
#' values constitutes a backtransformation to the observed data.  When using
#' fewer components, the fitted values can often be viewed as reconstructions
#' of the observed data with noise removed.
#'
#' @name fitted.ICS-S3
#'
#' @param object  an object inheriting from class \code{"ICS"} containing
#' results from an ICS transformation.
#' @param select  an integer, character, or logical vector specifying which
#' components to use for computing the fitted values, or \code{NULL} to compute
#' the fitted values from all components.
#' @param index  an integer vector specifying which components to use for
#' computing the fitted values, or \code{NULL} to compute the fitted values
#' from all components.  Note that \code{index} is deprecated and may be
#' removed in the future, use \code{select} instead.
#' @param \dots  additional arguments are ignored.
#'
#' @return A numeric matrix containing the fitted values.
#'
#' @author Andreas Alfons and Aurore Archimbaud
#'
#' @seealso
#' \code{\link{ICS}()}
#'
#' \code{\link{gen_kurtosis}()}, \code{\link[=coef.ICS]{coef}()},
#' \code{\link{components}()}, and \code{\link[=plot.ICS]{plot}()}
#' methods
#'
#' @examples
#' data("iris")
#' X <- iris[,-5]
#' out <- ICS(X)
#' fitted(out)
#' fitted(out, select = 4)
#'
#' @method fitted ICS
#' @export

fitted.ICS <- function(object, select = NULL, index = NULL, ...) {
  # back-compatibility check
  if (missing(select) && !missing(index)) {
    warning("argument 'index' is deprecated, use 'select' instead")
    select <- index
  }
  # initializations
  scores <- object$scores
  p <- ncol(scores)
  if (is.null(select)) select <- seq_len(p)
  else if (check_insufficient(select, target = 1L)) {
    stop("no components selected")
  } else if (check_undefined(select, max = p, names = colnames(scores))) {
    stop("undefined components selected")
  }
  # compute reconstructions from selected components
  # ('drop = FALSE' preserves row and column names)
  W_inverse <- solve(object$W)
  tcrossprod(scores[, select, drop = FALSE], W_inverse[, select, drop = FALSE])
}


#' Scatterplot Matrix of Component Scores from the ICS Transformation
#'
#' Produces a scatterplot matrix of the component scores of an invariant
#' coordinate system obtained via an ICS transformation.
#'
#' @name plot.ICS-S3
#'
#' @param x  an object inheriting from class \code{"ICS"} containing results
#' from an ICS transformation.
#' @param select  an integer, character, or logical vector specifying which
#' components to plot. If \code{NULL}, all components are plotted if there are
#' at most six components, otherwise the first three and the last three
#' components are plotted (as the components with extreme generalized kurtosis
#' values are the most interesting ones).
#' @param index  an integer vector specifying which components to plot, or
#' \code{NULL} to plot all components.  Note that \code{index} is deprecated
#' and may be removed in the future, use \code{select} instead.
#' @param \dots  additional arguments to be passed down to
#' \code{\link[graphics]{pairs}()}.
#'
#' @author Andreas Alfons and Aurore Archimbaud
#'
#' @seealso
#' \code{\link{ICS}()}
#'
#' \code{\link{gen_kurtosis}()}, \code{\link[=coef.ICS]{coef}()},
#' \code{\link{components}()}, and \code{\link[=fitted.ICS]{fitted}()} methods
#'
#' @examples
#' data("iris")
#' X <- iris[,-5]
#' out <- ICS(X)
#' plot(out)
#' plot(out, select = c(1,4))
#'
#' @method plot ICS
#' @importFrom graphics pairs
#' @export

plot.ICS <- function(x, select = NULL, index = NULL, ...) {
  # back-compatibility check
  if (missing(select) && !missing(index)) {
    warning("argument 'index' is deprecated, use 'select' instead")
    select <- index
  }
  # initializations
  scores <- x$scores
  p <- ncol(scores)
  # create scatterplot matrix
  if (is.null(select)) {
    # not specified which components to plot, use default
    if (p <= 6L) pairs(scores, ...)
    else pairs(scores[, c(1:3, p-2:0)], ...)
  } else {
    # check argument specifying components
    if (check_insufficient(select, target = 2L)) {
      stop("'select' must specify at least two components")
    } else if (check_undefined(select, max = p, names = colnames(scores))) {
      stop("undefined components selected")
    }
    # create scatterplot matrix of selected components
    pairs(scores[, select], ...)
  }
}


#' Basic information of ICS Object
#'
#' Prints information of an `ICS` object.
#'
#' @param x object of class `ICS`.
#' @param info Logical, either TRUE or FALSE. If TRUE, print additional
#' information on arguments used for computing scatter matrices
#' (only named arguments that contain numeric, character, or logical scalars)
#' and information on the parameters of the algorithm.
#' Default is FALSE.
#' @param digits number of digits for the numeric output.
#' @param ... additional arguments passed to `print()`
#'
#' @name print.ICS-S3
#' @author Andreas Alfons and Aurore Archimbaud
#'
#' @seealso
#' \code{\link{ICS}()}
#' @method print ICS
#'
#' @examples
#' data("iris")
#' X <- iris[,-5]
#' out <- ICS(X)
#' print(out)
#' print(out, info = TRUE)
#' @export
print.ICS <- function(x, info = FALSE, digits = 4L, ...){
  # initializations
  info <- isTRUE(info)
  # print information on scatter matrices
  cat("\nICS based on two scatter matrices")
  cat("\nS1:", x$S1_label)
  # if requested, print information on first scatter
  if (info) print_scatter_info(x$S1_args)
  cat("\nS2:", x$S2_label)
  # if requested, print information on second scatter and additional arguments
  if (isTRUE(info)) {
    print_scatter_info(x$S2_args)
    cat("\n\nInformation on the algorithm:")
    cat("\nalgorithm:", x$algorithm)
    cat("\ncenter:", x$center)
    cat("\nfix_signs:", x$fix_signs)
  }
  # print generalized kurtosis measures and coefficient matrix
  cat("\n\nThe generalized kurtosis measures of the components are:\n")
  # print(formatC(x$gen_kurtosis, digits = digits, format = "f"), quote = FALSE)
  print(x$gen_kurtosis, digits = digits, ...)
  cat("\nThe coefficient matrix of the linear transformation is:\n")
  # print(formatC(x$W, digits = digits, format = "f", flag = " "), quote = FALSE)
  print(x$W, digits = digits, ...)
  # return x invisibly
  invisible(x)
}


#' To summarize an `ICS` object
#'
#' Summarizes and prints an `ICS` object in an informative way.
#'
#' @param object object of class `ICS`.
#' @param ... additional arguments passed to [print.ICS()].
#'
#' @name summary.ICS-S3
#'
#' @author Andreas Alfons and Aurore Archimbaud
#'
#' @seealso
#' \code{\link{ICS}()}
#'
#' @method summary ICS
#' @seealso [print.ICS()]
#'
#' @examples
#' data("iris")
#' X <- iris[,-5]
#' out <- ICS(X)
#' summary(out)
#' @export
summary.ICS <- function(object, ...) {
  # currently doesn't do anything but add a subclass
  class(object) <- c("summary_ICS", class(object))
  print(object, ...)
}


#' @method print summary_ICS
#' @export
print.summary_ICS <- function(x, info = TRUE, digits = 4L, ...) {
  # call method for class "ICS" with default for printing additional information
  print.ICS(x, info = info, digits = digits, ...)
}


# internal function to print information on arguments used for a scatter matrix
# (only named arguments that contain numeric, character, or logical scalars)
print_scatter_info <- function(args) {
  # initializations
  arg_names <- names(args)
  # keep only arguments that have a name (also works if there are no names)
  keep <- which(arg_names != "")
  args <- args[keep]
  arg_names <- arg_names[keep]
  # if we don't have arguments with names, there is nothing to do
  if (length(args) > 0) {
    # loop over arguments and print simple ones
    mapply(function(name, value) {
      if ((is.numeric(value) || is.character(value) || is.logical(value)) &&
          length(value == 1L)) {
        cat("\n  ", name, ": ", value, sep = "")
      }
    }, name = arg_names, value = args, SIMPLIFY = FALSE, USE.NAMES = FALSE)
  }
}


# Internal functions -----


# check if argument 'select' specifies undefined components
check_undefined <- function(select, max, names) {
  (is.numeric(select) && length(select) > 0L &&
     (min(select) < 1L || max(select) > max)) ||
    (is.character(select) && !all(select %in% names))
}

# check if argument 'select' specifies an insufficient number of components
check_insufficient <- function(select, target = 2L) {
  ((is.numeric(select) || is.character(select)) && length(select) < target) ||
    (is.logical(select) && sum(select) < target)
}


## apply a scatter function to the data matrix
# X ......... data matrix
# fun ....... function to compute a scatter matrix
# args ...... list of additional arguments to be passed to the function
# convert ... logical indicating whether the scatter matrix should be converted
#             to class "ICS_scatter"
# label ..... typically constructed beforehand via deparse(substitute())
get_scatter <- function(X, fun = cov, args = list(), label) {
  if (length(args) == 0) scatter <- fun(X)
  else {
    # TODO: there may be a more efficient way of doing this, perhaps via call()
    args <- c(list(X), args)
    scatter <- do.call(fun, args)
  }
  # convert to class "ICS_scatter": use the supplied label if the function does
  # not return an object of this class already
  to_ICS_scatter(scatter, label = label)
}


## convert scatter matrices to the required class

to_ICS_scatter <- function(object, ...) UseMethod("to_ICS_scatter")

# object ... a scatter matrix
# label .... typically constructed beforehand via deparse(substitute())
to_ICS_scatter.matrix <- function(object, label, ...) {
  # convert to class "ICS_scatter" with empty location estimate
  out <- list(location = NULL, scatter = object, label = label)
  class(out) <- "ICS_scatter"
  out
}

# object ... typically a list with components 'location' and 'scatter', but it
#            can also have a component 'label'
# label .... typically constructed beforehand via deparse(substitute()) and
#            ignored if the list already has a component 'label'
to_ICS_scatter.list <- function(object, label) {
  # check that list has a component 'scatter'
  scatter <- object$scatter
  if (is.null(scatter)) {
    stop("list should have components 'scatter' (required) as well as ",
         "'location' and 'label' (optional)")
  }
  # check if there already is a component 'label' in the list
  if (!is.null(object$label)) label <- object$label
  # convert to class "ICS_scatter"
  out <- list(location = object$location, scatter = scatter, label = label)
  class(out) <- "ICS_scatter"
  out
}

to_ICS_scatter.ICS_scatter <- function(object, ...) object


# compute the matrix square root (or the inverse thereof) of a symmetric matrix
# TODO: there is already an internal function mat.sqrt() in the package, but it
#       doesn't assume symmetry and doesn't allow to compute the inverse
mat_sqrt <- function(A, inverse = FALSE) {
  # initializations
  power <- if (inverse) -0.5 else 0.5
  # compute eigendecomposition
  eigen_A <- eigen(A, symmetric = TRUE)
  # compute matrix square root or inverse
  eigen_A$vectors %*% tcrossprod(diag(eigen_A$values^power), eigen_A$vectors)
}

# in QR algorithm, the function for the second scatter matrix is not actually
# applied, so we need a different way to get the label for those scatters
get_cov4_label <- function() "COV4"
get_covW_label <- function() "COVW"
get_covAxis_label <- function() "COVAxis"
