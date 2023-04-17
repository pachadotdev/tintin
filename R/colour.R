#' @export
#' @inheritParams scale_fill_tintin_d
#' @rdname scale_fill_tintin_d
scale_colour_tintin_d <- function(..., alpha = 1, begin = 0, end = 1, direction = 1,
                                option = "the_blue_lotus", aesthetics = "colour") {
  discrete_scale(aesthetics, "tintin_standard", tintin_pal(alpha, begin, end, direction, option), ...)
}

#' @export
#' @inheritParams scale_fill_tintin_d
#' @importFrom scales gradient_n_pal
#' @importFrom ggplot2 continuous_scale
#' @importFrom grDevices col2rgb convertColor
#' @rdname scale_fill_tintin_d
scale_colour_tintin_c <- function(..., alpha = 1, begin = 0, end = 1, direction = 1,
                                option = "the_blue_lotus", values = NULL,
                                na.value = "grey50", guide = "colourbar",
                                aesthetics = "colour") {
  my_colours <- tintin_pal(alpha, begin, end, direction, option)(5)
  rgb <- col2rgb(my_colours)
  lab <- convertColor(t(rgb), 'sRGB', 'Lab')
  ordered_cols <- my_colours[order(lab[, 'L'])]

  continuous_scale(aesthetics, "tintin_standard",
                   gradient_n_pal(ordered_cols, values),
                   na.value = na.value,
                   guide = guide, ...
  )
}
