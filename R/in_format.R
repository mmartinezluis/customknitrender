#' Calls rmarkdown::render with passed in output format code
#'
#' @param x A numeric, non-decimal value to represent output format: 3 for "pdf_document", 33 for "html_document", and any other integer for "word_document".
#'
#' @returns The rmarkdown::render function called with the interpreted output format from x
#' @export
#'
#' @examples
#' x <- 3
#' in_format(3)
#'
#' x <- 33
#' in_format(x)
in_format <- function(x) {
  stopifnot(is.numeric(x), isTRUE(all.equal(x, as.integer(x))))
  the_format <- function(x){
    ifelse(x == 3,
           "pdf_document",
           (ifelse(x == 33, "html_document", "word_document")))
  }
  function(input, ...) {
    rmarkdown::render(input,
                      output_format = the_format(x),
                      envir = globalenv())
  }
}

# You can learn more about package authoring with RStudio at:
#
#   https://r-pkgs.org
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'
