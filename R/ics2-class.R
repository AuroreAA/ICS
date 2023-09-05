#' @export
setClass("ics2",representation(gSkew = "numeric", T1 = "numeric", T2 = "numeric", S1args = "list", S2args = "list"), contains="ics")

#' @export
setMethod("show",signature(object="ics2"),
function(object)
    {
    tmp <- list(gSkew=object@gSkew,
                gKurt=object@gKurt,
                UnMix=object@UnMix)
    print(tmp,quote=FALSE)
    invisible(tmp)
    }
)

#' @export
setMethod("summary",signature(object="ics2"),
function(object,digits=4)
    {
    cat("\nICS based on two scatter matrices and two location estimates\n")
    cat("S1: ", object@S1name)
    cat("\nS2: ",object@S2name)
    cat("\n")
    cat("\nThe generalized skewness measures of the components are:\n")
    print(format(round(object@gSkew,digits)),quote=FALSE)
    cat("\nThe generalized kurtosis measures of the components are:\n")
    print(format(round(object@gKurt,digits)),quote=FALSE)

    invisible(object)
    }
)

setValidity("ics2",function(object){
    if(!is(object@gKurt, "numeric")) return("Generalized kurtosis values of ics objects must be numeric")
    if(!(is(object@UnMix, "matrix") )) return("slot 'UnMix' of a ics object must be a numeric matrix")
    if(!(is.numeric(object@UnMix) )) return("slot 'UnMix' of a ics object must be a numeric matrix")
    if(!is(object@S1name, "character") || length(object@S1name)!=1) return("slot 'S1' of a ics object must be the name of a scatter
    function")

    if(!is(object@S2name, "character") || length(object@S2name)!=1) return("slot 'S2' of a ics object must be the name of a scatter
    function")
    if(!(is(object@Scores, "data.frame"))) return("slot 'Scores' of a ics object must be a numeric data frame")
    if(!all(sapply(object@Scores, is.numeric))) return("slot 'Scores' of a ics object must be a numeric data frame")
    if(!is(object@DataNames, "character")) return("slot 'DataNames' of a ics object must give the column names of the data matrix")
    if(!is(object@StandardizeB, "character") || length(object@StandardizeB)!=1) return("slot 'StandardizeB' of a ics object must be
    the name of a standardization method of 'UnMix'")

    if(length(object@gKurt)!=dim(object@UnMix)[2]) return("length of 'gKurt' must correspond to the number of columns of 'UnMix'")
    if(length(object@gKurt)!=dim(object@Scores)[2]) return("length of 'gKurt' must correspond to the number of columns of 'Scores'")
    if(length(object@gKurt)!=length(object@DataNames)) return("length of 'gKurt' must be the same as length of 'DataNames'")
    if(length(object@gKurt)<2) return("at least bivariate data is needed")

    if(!is(object@StandardizegKurt, "logical") || length(object@StandardizegKurt)!=1) return("slot 'StandardizegKurt' of a ics object
    must be 'TRUE' or 'FALSE'")

    if(!(is(object@S1, "matrix") )) return("slot 'S1' of a ics object must be a numeric matrix")
    if(!(is.numeric(object@S1) )) return("slot 'S1' of a ics object must be a numeric matrix")

    if(!(is(object@S2, "matrix") )) return("slot 'S2' of a ics object must be a numeric matrix")
    if(!(is.numeric(object@S2) )) return("slot 'S2' of a ics object must be a numeric matrix")

    if(!(is(object@gSkew, "numeric") )) return("slot 'gSkew' of a ics2 object must be a numeric vector")
    if(!(is(object@T1, "numeric") )) return("slot 'T1' of a ics2 object must be a numeric vector")
    if(!(is(object@T2, "numeric") )) return("slot 'T2' of a ics2 object must be a numeric vector")
    if(!(is(object@S1args, "list") )) return("slot 'S1args' of a ics2 object must be a list")
    if(!(is(object@S2args, "list") )) return("slot 'S2args' of a ics2 object must be a list")

    return(TRUE)
})
