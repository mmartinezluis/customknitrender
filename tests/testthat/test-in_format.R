test_that("in_format(x) returns a function which environment
          contains 'the_format' function which returns 'pdf_document'
          for x = 3, 'html_document' for x = 33, and 'word_document'
          for any other integer", {
  result <- in_format(3)
  expect_true(is.function(result))

  closure_env <- environment(result)
  expect_true(is.function(closure_env$the_format))

  the_format <- closure_env$the_format
  expect_equal(the_format(3), "pdf_document")
  expect_equal(the_format(33), "html_document")
  expect_equal(the_format(333), "word_document")
  expect_equal(the_format(8), "word_document")
})

test_that("in_format(x) errors when passed a non-numeric
          or decimal argument", {
  expect_error(in_format("3"))
  expect_error(in_format(3.1))
  expect_error(in_format("pdf"))
})

test_that("in_format(x) errors when called with no argument", {
  expect_error(in_format())
})
