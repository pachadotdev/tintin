rgb2hex <- function(r, g, b) {
  grDevices::rgb(r, g, b, maxColorValue = 255)
}

#' @title Tintin Colour Palettes
#'
#' @description This function creates a vector of colours along the selected
#'  colour map.
#'
#' @param n The number of colors (\eqn{\ge 1}) to be in the palette.
#'
#' @param alpha	The alpha transparency, a number in `[0,1]`, see argument alpha in
#' \code{\link[grDevices]{hsv}}.
#'
#' @param begin The (corrected) hue in `[0,1]` at which the color map begins.
#'
#' @param end The (corrected) hue in `[0,1]` at which the color map ends.
#'
#' @param direction Sets the order of colors in the scale. If 1, the default,
#'  colors are ordered from darkest to lightest. If -1, the order of colors is
#'  reversed.
#'
#' @param option A character string indicating the color map option to use.
#'  Options are available with tidy names (i.e., 'the_blue_lotus'):
#'  \itemize{
#'    \item "Tintin in the Land of the Soviets"
#'    \item "Tintin in the Congo"
#'    \item "Tintin in America"
#'    \item "Cigars of the Pharaoh"
#'    \item "The Blue Lotus" (Standard)
#'    \item "The Broken Ear"
#'    \item "The Black Island"
#'    \item "King Ottokar's Sceptre"
#'    \item "The Crab with the Golden Claws"
#'    \item "The Shooting Star"
#'    \item "The Secret of the Unicorn"
#'    \item "Red Rackham's Treasure"
#'    \item "The Seven Crystal Balls"
#'    \item "Prisoners of the Sun"
#'    \item "Land of Black Gold"
#'    \item "Destination Moon"
#'    \item "Explorers on the Moon"
#'    \item "The Calculus Affair"
#'    \item "The Red Sea Sharks"
#'    \item "Tintin in Tibet"
#'    \item "The Castafiore Emerald"
#'    \item "Flight 714 to Sydney"
#'    \item "Tintin and the Picaros"
#'    \item "Tintin and Alph-Art"
#'  }
#'
#' @importFrom dplyr rowwise mutate distinct pull across everything arrange as_tibble
#' @importFrom tidyr crossing
#' @importFrom grDevices colorRampPalette col2rgb rgb
#' @importFrom stats kmeans
#' @importFrom rlang sym
#'
#' @return \code{tintin_clrs} returns a character vector, \code{cv}, of color hex
#'  codes. This can be used either to create a user-defined color palette for
#'  subsequent graphics.
#'
#' @details
#'
#' \if{html}{Here are the color scales:
#'
#'   \out{<div style="text-align: center">}\figure{tintin-scales.png}{options: style="width:750px;max-width:75\%;"}\out{</div>}
#'   }
#' \if{latex}{Here are the color scales:
#'
#'   \out{\begin{center}}\figure{tintin-scales.png}\out{\end{center}}
#'   }
#'
#' Semi-transparent colors (\eqn{0 < alpha < 1}) are supported only on some
#'  devices: see \code{\link[grDevices]{rgb}}.
#'
#' @examples
#' \dontrun{
#' # using code from RColorBrewer to demo the palette
#' n <- 20
#' image(
#'   1:n, 1, as.matrix(1:n),
#'   col = tintin_clrs(n, option = "the_blue_lotus"),
#'   xlab = "Tintin darkblue n", ylab = "", xaxt = "n", yaxt = "n", bty = "n"
#' )
#' }
#' @export
tintin_clrs <- function(n = 5, alpha = 1, begin = 0, end = 1, direction = 1, option = "the_blue_lotus") {
  if (begin < 0 | begin > 1 | end < 0 | end > 1) {
    stop("begin and end must be in [0,1]")
  }

  if (abs(direction) != 1) {
    stop("direction must be 1 or -1")
  }

  if (n == 0) {
    return(character(0))
  }

  option <- switch(
    EXPR = option,
    tintin_in_the_land_of_the_soviets = "tintin_in_the_land_of_the_soviets",
    tintin_in_the_congo = "tintin_in_the_congo",
    tintin_in_america = "tintin_in_america",
    cigars_of_the_pharaoh = "cigars_of_the_pharaoh",
    the_blue_lotus = "the_blue_lotus",
    the_broken_ear = "the_broken_ear",
    the_black_island = "the_black_island",
    king_ottokars_sceptre = "king_ottokars_sceptre",
    the_crab_with_the_golden_claws = "the_crab_with_the_golden_claws",
    the_shooting_star = "the_shooting_star",
    the_secret_of_the_unicorn = "the_secret_of_the_unicorn",
    red_rackhams_treasure = "red_rackhams_treasure",
    the_seven_crystal_balls = "the_seven_crystal_balls",
    prisoners_of_the_sun = "prisoners_of_the_sun",
    land_of_black_gold = "land_of_black_gold",
    destination_moon = "destination_moon",
    explorers_on_the_moon = "explorers_on_the_moon",
    the_calculus_affair = "the_calculus_affair",
    the_red_sea_sharks = "the_red_sea_sharks",
    tintin_in_tibet = "tintin_in_tibet",
    the_castafiore_emerald = "the_castafiore_emerald",
    flight_714_to_sydney = "flight_714_to_sydney",
    tintin_and_the_picaros = "tintin_and_the_picaros",
    tintin_and_alph_art = "tintin_and_alph_art",
    {
      warning(paste0("Option '", option, "' does not exist. Defaulting to 'the_blue_lotus'."))
      "the_blue_lotus"
    }
  )

  use_clrs <- switch(
    EXPR = option,
    tintin_in_the_land_of_the_soviets = c(tintin::tintin_colours[["tintin_in_the_land_of_the_soviets"]]),
    tintin_in_the_congo = c(tintin::tintin_colours[["tintin_in_the_congo"]]),
    tintin_in_america = c(tintin::tintin_colours[["tintin_in_america"]]),
    cigars_of_the_pharaoh = c(tintin::tintin_colours[["cigars_of_the_pharaoh"]]),
    the_blue_lotus = c(tintin::tintin_colours[["the_blue_lotus"]]),
    the_broken_ear = c(tintin::tintin_colours[["the_broken_ear"]]),
    the_black_island = c(tintin::tintin_colours[["the_black_island"]]),
    king_ottokars_sceptre = c(tintin::tintin_colours[["king_ottokars_sceptre"]]),
    the_crab_with_the_golden_claws = c(tintin::tintin_colours[["the_crab_with_the_golden_claws"]]),
    the_shooting_star = c(tintin::tintin_colours[["the_shooting_star"]]),
    the_secret_of_the_unicorn = c(tintin::tintin_colours[["the_secret_of_the_unicorn"]]),
    red_rackhams_treasure = c(tintin::tintin_colours[["red_rackhams_treasure"]]),
    the_seven_crystal_balls = c(tintin::tintin_colours[["the_seven_crystal_balls"]]),
    prisoners_of_the_sun = c(tintin::tintin_colours[["prisoners_of_the_sun"]]),
    land_of_black_gold = c(tintin::tintin_colours[["land_of_black_gold"]]),
    destination_moon = c(tintin::tintin_colours[["destination_moon"]]),
    explorers_on_the_moon = c(tintin::tintin_colours[["explorers_on_the_moon"]]),
    the_calculus_affair = c(tintin::tintin_colours[["the_calculus_affair"]]),
    the_red_sea_sharks = c(tintin::tintin_colours[["the_red_sea_sharks"]]),
    tintin_in_tibet = c(tintin::tintin_colours[["tintin_in_tibet"]]),
    the_castafiore_emerald = c(tintin::tintin_colours[["the_castafiore_emerald"]]),
    flight_714_to_sydney = c(tintin::tintin_colours[["flight_714_to_sydney"]]),
    tintin_and_the_picaros = c(tintin::tintin_colours[["tintin_and_the_picaros"]]),
    tintin_and_alph_art = c(tintin::tintin_colours[["tintin_and_alph_art"]])
  )

  if (n <= 5) {
    use_clrs <- use_clrs[1:min(n, 5)]

    if (alpha != 1) {
      use_clrs <- t(col2rgb(use_clrs)) / 255
      use_clrs <- rgb(use_clrs[, 1], use_clrs[, 2], use_clrs[, 3], alpha = alpha)[1:n]
    }

    if (direction != 1) {
      use_clrs <- rev(use_clrs)
    }

    return(use_clrs)
  }

  set.seed(1234)

  use_clrs_s <- crossing(col1 = use_clrs, col2 = use_clrs) %>%
    rowwise() %>%
    # interpolate 9 colors, take the midpoint
    mutate(colf = colorRampPalette(c(!!sym("col1"), !!sym("col2")))(9)[5]) %>%
    distinct(!!sym("colf")) %>%
    pull()

  dfcolors <- as_tibble(t(col2rgb(use_clrs_s)))

  use_clrs_n <- kmeans(dfcolors, n)$centers %>%
    as_tibble() %>%
    mutate(across(everything(), as.integer)) %>%
    mutate(color = rgb2hex(!!sym("red"), !!sym("green"), !!sym("blue"))) %>%
    arrange(!!sym("red"), !!sym("green"), !!sym("blue")) %>%
    pull(!!sym("color"))

  if (alpha != 1) {
    use_clrs_n <- t(col2rgb(use_clrs_n)) / 255
    use_clrs_n <- rgb(use_clrs_n[, 1], use_clrs_n[, 2], use_clrs_n[, 3], alpha = alpha)
  }

  if (direction != 1) {
    use_clrs_n <- rev(use_clrs_n)
  }

  return(use_clrs_n)
}

#' @title Tintin Colour Palettes
#'
#' @description A wrapper function around \code{Tintin_clrs} to
#'  turn it into a palette function compatible with
#'  \code{\link[ggplot2]{discrete_scale}}.
#' @details See \code{Tintin_clrs} for more information on the color palettes.
#' @param alpha The alpha transparency, a number in `[0,1]`, see argument alpha in
#' \code{\link[grDevices]{hsv}}.
#' @param begin The (corrected) hue in `[0,1]` at which the color map begins.
#' @param end The (corrected) hue in `[0,1]` at which the color map ends.
#' @param direction Sets the order of colors in the scale. If 1, the default,
#'  colors are ordered from darkest to lightest. If -1, the order of colors is
#'  reversed.
#' @param option A character string indicating the color map option to use.
#'  Options are available:
#'  \itemize{
#'    \item "Tintin in the Land of the Soviets"
#'    \item "Tintin in the Congo"
#'    \item "Tintin in America"
#'    \item "Cigars of the Pharaoh"
#'    \item "The Blue Lotus" (Standard)
#'    \item "The Broken Ear"
#'    \item "The Black Island"
#'    \item "King Ottokar's Sceptre"
#'    \item "The Crab with the Golden Claws"
#'    \item "The Shooting Star"
#'    \item "The Secret of the Unicorn"
#'    \item "Red Rackham's Treasure"
#'    \item "The Seven Crystal Balls"
#'    \item "Prisoners of the Sun"
#'    \item "Land of Black Gold"
#'    \item "Destination Moon"
#'    \item "Explorers on the Moon"
#'    \item "The Calculus Affair"
#'    \item "The Red Sea Sharks"
#'    \item "Tintin in Tibet"
#'    \item "The Castafiore Emerald"
#'    \item "Flight 714 to Sydney"
#'    \item "Tintin and the Picaros"
#'    \item "Tintin and Alph-Art"
#'  }
#'
#' @examples
#' scales::show_col(tintin_pal()(5))
#'
#' @importFrom rlang is_installed
#'
#' @export
tintin_pal <- function(alpha = 1, begin = 0, end = 1, direction = 1, option = "the_blue_lotus") {
  function(n) {
    tintin_clrs(n, alpha, begin, end, direction, option)
  }
}
