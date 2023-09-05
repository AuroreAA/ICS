#' @export
MeanCov <- function(x) list(location = colMeans(x), scatter = cov(x))
