# try with GIMP

# tintin_colours <- list()
#
# tintin_colours[[1]] <- c("#253844", "#f7efb0", "#432727", "#ad0e20", "#867a64", "#c7d6bf", "#c1841a")
#
# scales::show_col(tintin_colours[[1]], ncol = 7, labels = FALSE)

# tidy data manipulation
library(tidyverse)
library(scales)

# image manipulation
library(magick)
library(imager)

get_colorPal <- function(i, n = 5) {
  im <- image_read(i)

  tmp <- im %>%
    image_modulate(brightness = 100) %>%
    image_quantize(max = n, colorspace = "rgb", treedepth = 1) %>%  ## reducing colours! different colorspace gives you different result
    magick2cimg() %>%  ## I'm converting, because I want to use as.data.frame function in imager package.
    RGBtoHSV() %>% ## i like sorting colour by hue rather than RGB (red green blue)
    as.data.frame(wide = "c") %>%  #3 making it wide makes it easier to output hex colour
    mutate(hex = hsv(rescale(c.1, from = c(0, 360)), c.2, c.3)) %>%
    mutate(
      hex = case_when(
        substr(hex, 1, 3) %in% c("#FF", "#FB", "#F8", "#FE", "#FC", "#F7") ~ "#453625", # replace whites by Tintin's hair
        # substr(hex, 1, 3) %in% c("#00", "#05", "#0B", "#0D", "#0F", "#09", "#0A", "#06", "#03") ~ "#453625", # replace blacks by Tintin's hair
        TRUE ~ hex
      )
    ) %>%
    count(hex, sort = T)

  return(tmp %>% select(hex)) ## I want data frame as a result.
}

finp <- list.files("dev", pattern = "jpg", full.names = T)

tintin_colours <- map(
  finp,
  function(i) {
    img <- get_colorPal(i)

    return(as.vector(img$hex))
  }
)

tintin_colours[[1]]

scales::show_col(tintin_colours[[1]], ncol = 7, labels = FALSE)

names(tintin_colours) <- janitor::make_clean_names(gsub("dev/[0-9][0-9]\\s|\\.jpg", "", finp))

tintin_colours$the_red_sea_sharks

# for (i in seq_along(tintin_colours)) {
#   rgb <- col2rgb(tintin_colours[[i]])
#   lab <- convertColor(t(rgb), 'sRGB', 'Lab')
#   ordered_cols <- tintin_colours[[i]][order(lab[, 'L'])]
#   tintin_colours[[i]] <- ordered_cols
# }

use_data(tintin_colours, overwrite = T)
