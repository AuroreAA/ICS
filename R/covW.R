#'  One-step M-estimator
#'
#'  Estimates the scatter matrix based on one-step M-estimator using mean and covariance matrix as starting point.
#'
#' @param X numeric \eqn{n \times p} data matrix or dataframe.
#' @param na.action a function which indicates what should happen when the data contain 'NA's. Default is to fail.
#' @param alpha parameter of the one-step M-estimator. By default equals to 1.
#' @param cf consistency factor of the one-step M-estimator. By default equals to 1.
#'
#' @details
#' It is given for \eqn{n \times p} matrix \eqn{X} by
#' \deqn{COV_{w}(X)=\frac{1}{n} {cf} \sum_{i=1}^n w(D^2(x_i))
#' (x_i - \bar{ x})^\top(x_i - \bar{ x}),}
#' where \eqn{\bar{x}} is the mean vector, \eqn{D^2(x_i)} is the squared
#'  Mahalanobis distance, \eqn{w(d)=d^\alpha} is a
#' non-negative and continuous weight function and \eqn{{cf}} is a consistency factor.
#' Note that the consistency factor, which makes the estimator consistent at the multivariate normal distribution, is in most case unknown and therefore the default is to use simply \code{cf = 1}.
#'
#' - If \eqn{w(d)=1}, we get the covariance matrix [cov()] (up to the factor
#' \eqn{1/(n-1)} instead of \eqn{1/n}).
#' - If \eqn{\alpha=-1}, we get the [covAxis()].
#' - If \eqn{\alpha=1}, we get the [cov4()] with \eqn{{cf} = \frac{1}{p+2}}.
#'
#' @references Archimbaud, A., Drmac, Z., Nordhausen, K., Radojicic, U. and
#'   Ruiz-Gazen, A. (2023). SIAM Journal on Mathematics of Data Science (SIMODS),
#'    Vol.5(1):97–121. \doi{10.1137/22M1498759}.
#'
#' @return A matrix containing the one-step M-scatter.
#'
#' @author Aurore Archimbaud and Klaus Nordhausen
#'
#' @seealso [cov()], [cov4()], [covAxis()]
#'
#' @export
#'
#' @examples
#' data(iris)
#' X <- iris[,1:4]
#'
#' # Equivalence with covAxis
#' covW(X, alpha = -1, cf = ncol(X))
#' covAxis(X)
#'
#' # Equivalence with cov4
#' covW(X, alpha = 1, cf = 1/(ncol(X)+2))
#' cov4(X)
#'
#' # covW with alpha = 0.5
#' covW(X, alpha = 0.5)
#'
covW <- function (X, na.action = na.fail, alpha = 1, cf = 1 )
{
  X <- na.action(X)
  X <- as.matrix(X)
  n <- dim(X)[1]
  p <- dim(X)[2]
  if (p < 2)
    stop("'X' must be at least bivariate")
  Xmeans <- colMeans(X)
  di <- mahalanobis(X, Xmeans, cov(X))
  X.centered <- sweep(X, 2, Xmeans)
  v.tilde <- cf/n * t( X.centered) %*% diag(di^alpha) %*%  X.centered

  return(v.tilde)
}
