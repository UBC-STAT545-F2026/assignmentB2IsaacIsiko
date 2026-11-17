#' Summary statistics for numeric columns
#'
#' Calculates the mean, standard deviation, and median of every numeric
#' column in a data frame, optionally grouped by one column, and returns
#' a tidy tibble.
#'
#' @param data A data frame or tibble. Named `data` because that is the
#'   usual name for a data frame argument in the tidyverse.
#' @param group_var A single column name, given as a string, to group by,
#'   or `NULL` (the default) for no grouping.
#' @param na_rm Should missing values be removed before calculating?
#'   Default `TRUE`. Named `na_rm` to match the `na.rm` argument it controls.
#' @param digits Number of decimal places to round the statistics to.
#'   Default 2. Exposed as an argument so no rounding choice is hidden.
#'
#' @return A tibble with one row per group (or one row if `group_var` is
#'   `NULL`): the grouping column first, then `_mean`, `_sd` and `_median`
#'   columns for every numeric column in `data`.
#'
#' @examples
#' numeric_overview(mtcars, group_var = "cyl")
#' numeric_overview(iris)
#' numeric_overview(iris, group_var = "Species", digits = 1)
#'
#' @export
numeric_overview <- function(data, group_var = NULL, na_rm = TRUE, digits = 2) {
  # Input checks: stop early with a clear message
  
  # `data` must be a data frame (or tibble)
  if (!is.data.frame(data)) {
    stop("`data` must be a data frame.", call. = FALSE)
  }
  
  # `group_var`, if given, must be ONE string that names a column of `data`
  if (!is.null(group_var)) {
    if (!is.character(group_var) || length(group_var) != 1) {
      stop("`group_var` must be a single column name given as a string.",
           call. = FALSE)
    }
    if (!group_var %in% names(data)) {
      stop("`", group_var, "` is not a column of `data`.", call. = FALSE)
    }
  }
  
  # There must be at least one numeric column to summarise
  if (!any(vapply(data, is.numeric, logical(1)))) {
    stop("`data` must contain at least one numeric column.", call. = FALSE)
  }
  
  
  # Group by the chosen column; with group_var = NULL, no grouping happens
  grouped <- dplyr::group_by(data, dplyr::across(dplyr::all_of(group_var)))
  
  # Mean, sd and median of every numeric column (grouping columns are skipped)
  result <- dplyr::summarise(
    grouped,
    dplyr::across(
      dplyr::where(is.numeric),
      list(
        mean   = ~ mean(.x, na.rm = na_rm),
        sd     = ~ stats::sd(.x, na.rm = na_rm),
        median = ~ stats::median(.x, na.rm = na_rm)
      ),
      .names = "{.col}_{.fn}"  
    ),
    .groups = "drop"           
  )
  
  # Round only the statistics, never a numeric grouping column
  dplyr::mutate(
    result,
    dplyr::across(
      dplyr::where(is.numeric) & !dplyr::any_of(group_var),
      ~ round(.x, digits)
    )
  )
}
