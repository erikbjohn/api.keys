#' \code{api.keys} package
#'
#' api.keys
#'
#' See the Vignette on 
#'
#' @docType package
#' @name api.keys
#' @importFrom data.table :=
NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))

#' @title import.key
#'
#' @description Imports api.key from local (dropbox) file
#' @param path.root Dropbox root path (default = ~/Dropbox/pkg.data)
#' @param str.api.name api key source (defualt = all, example = 'google')
#' @keywords api key load
#' @export
#' @import stringr
#'     data.table
#'     pkg.data.paths
import.key <- function(path.root = NULL, str.api.name = 'all'){
  file.name <- NULL
  dt.paths <- pkg.data.paths::paths(path.root, str.pkg.name = 'api.keys')
  l.pkg.path <- dt.paths[file.name == 'l.pkg.rdata']$sys.path
  load(l.pkg.path)
  if (str.api.name == 'all'){
    return(unlist(l.pkg))
  } else {
    api.key <- unlist(l.pkg[names(l.pkg) == str.api.name])
    if (is.null(api.key)){
      api.key <- readline(prompt=paste0("Enter an api.key for ", str.api.name, ": "))
      names(api.key) <- str.api.name
      l.pkg <- c(l.pkg, api.key)
      save(l.pkg, file=l.pkg.path)
    }
  }
  return(api.key) 
}
