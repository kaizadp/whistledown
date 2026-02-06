test_that("whistledown_palette works", {
  # Error on bad input
  expect_error(whistledown_palette(1, n = 100, type = "continuous", direction = 1))
  expect_error(whistledown_palette("sharmaji", n = "100", type = "continuous", direction = 1))
  expect_error(whistledown_palette("sharmaji", n = 100, type = 1, direction = 1))
  expect_error(whistledown_palette("sharmaji", n = 100, type = "continuous", direction = "1"))
  expect_error(whistledown_palette("sharmaji", n = 100, type = "continuous", direction = 2), 
               regexp = "direction must be 1 or -1")
  
  x <- whistledown_palette("sharmaji", n = 100, type = "continuous", direction = 1)
  expect_s3_class(x, "palette")
})

test_that("print.palette works", {
  # Error on bad input
  expect_error(print.palette(1))
  
  x <- whistledown_palette("sharmaji", n = 100, type = "continuous", direction = 1)
  expect_null(print.palette(x))
})
