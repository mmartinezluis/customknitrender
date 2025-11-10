#' Define output format for rmarkdown files
#'
#' @description
#' Defines the output format for rmarkdown's render function using integer representations:
#' * `in_format(3)` for "pdf_document"
#' * `in_format(33)` for "html_document"
#' * Any other integer for "word_document" (e.g., `in_format(333)`, `in_format(4)`)
#' @md
#'
#' @param x A numeric, non-decimal value to represent output format: 3 for "pdf_document", 33 for "html_document", and any other integer for "word_document".
#'
#' @returns The rmarkdown::render function called with the interpreted output format from x
#'
#' @export
#' @importFrom rmarkdown render
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
