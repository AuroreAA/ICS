### screeplot method for an ics object
### barplot or lineplot are options
###
#' @export
#' @importFrom graphics plot barplot axis
`screeplot.ics` <-
  function(x,index=NULL,type="barplot",
           main = deparse(substitute(x)),ylab="generalized kurtosis",xlab= "component", names.arg=index, labels=TRUE,...)
  {
    #if(class(x)!="ics") stop("'x' must be of class ics")
    type<-match.arg(type,c("barplot","lines"))
    if (is.null(index)) index=1:length(x@gKurt)
    if (type=="barplot")
    {
      barplot(x@gKurt[index],names.arg=names.arg,ylab=ylab,xlab=xlab,main=main,...)
    }
    else
    {
      plot(index,x@gKurt[index],type="b",ylab=ylab,xlab=xlab,axes=FALSE,main=main,...)
      axis(2)
      axis(1, at = seq_along(index), labels = labels)
    }
    invisible()
  }

#' Screeplot for an `ICS` Object
#'
#' Plots the kurtosis measures of an `ICS` object against its index number.
#' Two versions of this screeplot are available.
#'
#' @param x object of class `ICS`
#' @param index index of the components to be plottes.
#' If NULL all components are used.
#' @param type "barplot" if a barplot or "lines" if a line plot is preferred.
#' @param main main title of the plot.
#' @param ylab y-axis label.
#' @param xlab x-axis label.
#' @param names.arg names.arg argument passed on to "barplot".
#' @param labels `labels` argument for the labels of the x-axis passed on to
#' `axis`.
#' @param ... other arguments for the plotting functions.
#'
#' @name screeplot.ICS-S3
#'
#' @author Andreas Alfons and Aurore Archimbaud
#'
#' @seealso
#' \code{\link{ICS}()}
#'
#' \code{\link{gen_kurtosis}()}  method
#' @export
#' @method screeplot ICS
#' @importFrom graphics plot barplot axis
#'
#' @examples
#' X <- iris[,-5]
#' out <- ICS(X)
#' screeplot(out)
#' screeplot(out, type = "lines")
screeplot.ICS <- function(x, index = NULL, type = "barplot",
                          main = deparse(substitute(x)), ylab = "generalized kurtosis",
                          xlab = "component", names.arg = index, labels = TRUE,...)  {
  #if(class(x)!="ics") stop("'x' must be of class ics")
  type <- match.arg(type,c("barplot","lines"))
  if (is.null(index)) index = 1:length(x$gen_kurtosis)
  if (type=="barplot")
  {
    barplot(x$gen_kurtosis[index], names.arg = names.arg, ylab = ylab,
            xlab = xlab, main = main, ...)
  }
  else
  {
    plot(index, x$gen_kurtosis[index], type = "b", ylab = ylab, xlab = xlab,
         axes = FALSE, main = main, ...)
    axis(2)
    axis(1, at = seq_along(index), labels = labels)
  }
  invisible()
}
