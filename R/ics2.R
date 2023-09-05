#' @export
ics2 <- function (X, S1 = MeanCov, S2 = Mean3Cov4, S1args = list(), S2args = list(), na.action = na.fail)
{
    X <- na.action(X)
    p <- ncol(X)
    data.matrix <- as.matrix(X)
    S1name <- deparse(substitute(S1))
    S2name <- deparse(substitute(S2))
    if (!is.list(S1)) S1 <- do.call("S1", c(list(data.matrix), S1args))
    if (!is.list(S2)) S2 <- do.call("S2", c(list(data.matrix), S2args))

    T1.X <- S1[[1]]
    S1.X <- S1[[2]]

    T2.X <- S2[[1]]
    S2.X <- S2[[2]]

    S1.X.eigen <- eigen(S1.X, symmetric=TRUE)
    B1 <- S1.X.eigen$vectors %*% tcrossprod(diag(S1.X.eigen$values^(-0.5)), S1.X.eigen$vectors)
    S2.Y <- B1 %*% S2.X %*% B1

    S2.Y.eigen <- eigen(S2.Y, symmetric=TRUE)
    U2 <- S2.Y.eigen$vectors
    gKurt <- S2.Y.eigen$values

    B <- crossprod(U2, B1)

    T1.Z <- T1.X %*% B
    T2.Z <- T2.X %*% B

    gSkew <- T1.Z - T2.Z
    skew.signs <- ifelse(gSkew >= 0, 1, -1)

    B.res <- sweep(B, 1, skew.signs, "*")
    data.matrix.C <- sweep(data.matrix, 2, T1.X, "-")
    Z <- as.data.frame(tcrossprod(data.matrix.C, B.res))

    names(Z) <- paste(rep("IC", p), 1:p, sep = ".")
    if (is.null(colnames(X)) == TRUE)
        names.X <- paste(rep("X", p), 1:p, sep = ".")
    else names.X <- colnames(X)

    stdB <- "Z"
    stdKurt <- FALSE

    # ics2 is same as class ics but with extra slots T1, T2, gSkew, S1args, S2args

    res <- new("ics2", gKurt = gKurt, UnMix = B.res, S1 = S1.X,
        S2 = S2.X, S1name = S1name, S2name = S2name,
        S1args = S1args, S2args = S2args, Scores = Z,
        T1 = T1.X, T2=T2.X, gSkew = as.vector(skew.signs*gSkew),
        DataNames = names.X, StandardizeB = stdB, StandardizegKurt = stdKurt)
    return(res)
}
