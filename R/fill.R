#' Tintin Colour Scales
#'
#' The `tintin` scales provide colour maps for the different Tintin
#' covers.
#'
#' @importFrom ggplot2 discrete_scale
#' @inheritParams tintin_pal
#' @inheritParams ggplot2::discrete_scale
#' @param ... Other arguments passed on to [ggplot2::discrete_scale()],
#' [ggplot2::continuous_scale()], or [ggplot2::binned_scale()] to control name, limits, breaks,
#'   labels and so forth.
#' @param aesthetics Character string or vector of character strings listing the
#'   name(s) of the aesthetic(s) that this scale works with. This can be useful, for
#'   example, to apply colour settings to the `colour` and `fill` aesthetics at the
#'   same time, via `aesthetics = c("colour", "fill")`.
#' @param values if colours should not be evenly positioned along the gradient this
#' vector gives the position (between 0 and 1) for each colour in the colours vector.
#' @family colour scales
#' @rdname scale_fill_tintin_d
#' @return A `ggproto` object for use with `ggplot2`.
#' @examples
#' library(dplyr)
#' library(ggplot2)
#' library(tintin)
#'
#' total_head_trauma <- tintin_head_trauma %>%
#'   arrange(-loss_of_consciousness_length) %>%
#'   filter(row_number() <= 5)
#' 
#' # discrete scale
#' 
#' ggplot(total_head_trauma) +
#'   geom_col(aes(x = cause_of_injury, y = loss_of_consciousness_length,
#'     fill = book_title), position = "dodge") +
#'   labs(x = "Cause of injury", y = "Loss of consciousness length",
#'     title = "Top five causes of injury") +
#'   theme_minimal() +
#'   scale_fill_tintin_d(option = "cigars_of_the_pharaoh", direction = -1) +
#'   coord_flip()
#' 
#' # continuous scale
#' 
#' # continuous scale
#' ggplot(total_head_trauma) +
#'  geom_col(aes(
#'    x = cause_of_injury, y = loss_of_consciousness_length,
#'    fill = year
#'  ), position = "dodge") +
#'  labs(
#'    x = "Cause of injury", y = "Loss of consciousness length",
#'    title = "Top five causes of injury"
#'  ) +
#'  theme_minimal() +
#'  scale_fill_tintin_c(option = "cigars_of_the_pharaoh", direction = -1)
#' 
#' @export
scale_fill_tintin_d <- function(..., alpha = 1, begin = 0, end = 1, direction = 1,
                              option = "the_blue_lotus", aesthetics = "fill") {
  discrete_scale(aesthetics, "the_blue_lotus", tintin_pal(alpha, begin, end, direction, option), ...)
}

#' @export
#' @inheritParams scale_fill_tintin_d
#' @importFrom scales gradient_n_pal
#' @importFrom ggplot2 continuous_scale
#' @rdname scale_fill_tintin_d
scale_fill_tintin_c <- function(..., alpha = 1, begin = 0, end = 1, direction = 1,
                              option = "the_blue_lotus", values = NULL,
                              na.value = "grey50", guide = "colourbar",
                              aesthetics = "fill") {
  my_colours <- tintin_pal(alpha, begin, end, direction, option)(5)
  rgb <- col2rgb(my_colours)
  lab <- convertColor(t(rgb), 'sRGB', 'Lab')
  ordered_cols <- my_colours[order(lab[, 'L'])]

  continuous_scale(aesthetics, "the_blue_lotus",
                   gradient_n_pal(ordered_cols, values),
                   na.value = na.value,
                   guide = guide, ...
  )
}
