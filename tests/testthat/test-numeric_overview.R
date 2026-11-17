

# Test 1: the shape and type of the output

test_that("output is a tibble with one row per group", {
  out <- numeric_overview(mtcars, group_var = "cyl")
  expect_s3_class(out, "tbl_df")                            
  expect_identical(nrow(out), 3L)                            
  expect_identical(nrow(numeric_overview(mtcars)), 1L)       
})

# Test 2: the numbers are right (compared with a hand calculation)

test_that("the statistics are correct", {
out <- numeric_overview(mtcars, group_var = "cyl", digits = 5)
expect_equal(out$mpg_mean[out$cyl == 4],
round(mean(mtcars$mpg[mtcars$cyl == 4]), 5))
})

# Test 3: missing values are handled by the `na_rm` argument

test_that("na_rm controls missing values", {
df <- data.frame(g = c("a", "a", "b"), v = c(1, NA, 3))   
expect_equal(numeric_overview(df, "g")$v_mean, c(1, 3))    
expect_true(anyNA(numeric_overview(df, "g", na_rm = FALSE)$v_mean))  
})

# Test 4: a numeric grouping column keeps its exact values
test_that("numeric grouping column is not rounded", {
  df <- data.frame(g = c(1.234, 1.234, 1.236, 1.236), v = 1:4)
  expect_equal(numeric_overview(df, "g")$g, c(1.234, 1.236))
})

# Test 5: bad input produces clear error messages

test_that("bad input gives clear errors", {
expect_error(numeric_overview(1:5), "data frame")                   
expect_error(numeric_overview(mtcars, "colour"), "not a column")    
expect_error(numeric_overview(mtcars, c("cyl", "gear")), "single column name")  
expect_error(numeric_overview(data.frame(a = "x")), "numeric column") 
})
