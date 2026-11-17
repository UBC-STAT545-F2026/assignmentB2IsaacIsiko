
<!-- README.md is generated from README.Rmd. Please edit that file -->

# assignmentB2IsaacIsiko

`assignmentB2IsaacIsiko` provides `numeric_overview()`, a function that
calculates the mean, standard deviation and median of every numeric
column in a data frame, optionally grouped by one column, and returns a
tidy tibble.

# Installing

Install version 0.1.0 from GitHub:

``` r
# install.packages("devtools")

devtools::install_github("UBC-STAT545-F2026/assignmentB2IsaacIsiko", ref = "0.1.0")
```

# Usage

Summarise every numeric column, split by a grouping column:

``` r
library(assignmentB2IsaacIsiko)

numeric_overview(mtcars, group_var = "cyl")
#> # A tibble: 3 × 31
#>     cyl mpg_mean mpg_sd mpg_median disp_mean disp_sd disp_median hp_mean hp_sd
#>   <dbl>    <dbl>  <dbl>      <dbl>     <dbl>   <dbl>       <dbl>   <dbl> <dbl>
#> 1     4     26.7   4.51       26        105.    26.9        108     82.6  20.9
#> 2     6     19.7   1.45       19.7      183.    41.6        168.   122.   24.3
#> 3     8     15.1   2.56       15.2      353.    67.8        350.   209.   51.0
#> # ℹ 22 more variables: hp_median <dbl>, drat_mean <dbl>, drat_sd <dbl>,
#> #   drat_median <dbl>, wt_mean <dbl>, wt_sd <dbl>, wt_median <dbl>,
#> #   qsec_mean <dbl>, qsec_sd <dbl>, qsec_median <dbl>, vs_mean <dbl>,
#> #   vs_sd <dbl>, vs_median <dbl>, am_mean <dbl>, am_sd <dbl>, am_median <dbl>,
#> #   gear_mean <dbl>, gear_sd <dbl>, gear_median <dbl>, carb_mean <dbl>,
#> #   carb_sd <dbl>, carb_median <dbl>
```

Without `group_var`, the whole data frame can be summarised in one row:

``` r

numeric_overview(iris, digits = 1)
#> # A tibble: 1 × 12
#>   Sepal.Length_mean Sepal.Length_sd Sepal.Length_median Sepal.Width_mean
#>               <dbl>           <dbl>               <dbl>            <dbl>
#> 1               5.8             0.8                 5.8              3.1
#> # ℹ 8 more variables: Sepal.Width_sd <dbl>, Sepal.Width_median <dbl>,
#> #   Petal.Length_mean <dbl>, Petal.Length_sd <dbl>, Petal.Length_median <dbl>,
#> #   Petal.Width_mean <dbl>, Petal.Width_sd <dbl>, Petal.Width_median <dbl>
```

Missing values are removed by default by Setting `na_rm = FALSE` to keep
them:

``` r

df <- data.frame(g = c("a", "a", "b"), v = c(1, NA, 3))

numeric_overview(df, group_var = "g", na_rm = FALSE)
#> # A tibble: 2 × 4
#>   g     v_mean  v_sd v_median
#>   <chr>  <dbl> <dbl>    <dbl>
#> 1 a         NA    NA       NA
#> 2 b          3    NA        3
```
