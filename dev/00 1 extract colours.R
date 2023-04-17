# automatic extraction is not quite there, using GIMP instead

# # tidy data manipulation
# library(tidyverse)
# library(scales)
#
# # image manipulation
# library(magick)
# library(imager)
#
# get_colorPal <- function(i, n = 5) {
#   im <- image_read(i)
#
#   tmp <- im %>%
#     image_modulate(brightness = 100) %>%
#     image_quantize(max = n, colorspace = "rgb", treedepth = 1) %>%  ## reducing colours! different colorspace gives you different result
#     magick2cimg() %>%  ## I'm converting, because I want to use as.data.frame function in imager package.
#     RGBtoHSV() %>% ## i like sorting colour by hue rather than RGB (red green blue)
#     as.data.frame(wide = "c") %>%  #3 making it wide makes it easier to output hex colour
#     mutate(hex = hsv(rescale(c.1, from = c(0, 360)), c.2, c.3)) %>%
#     mutate(
#       hex = case_when(
#         substr(hex, 1, 3) %in% c("#FF", "#FB", "#F8", "#FE", "#FC", "#F7") ~ "#453625", # replace whites by Tintin's hair
#         # substr(hex, 1, 3) %in% c("#00", "#05", "#0B", "#0D", "#0F", "#09", "#0A", "#06", "#03") ~ "#453625", # replace blacks by Tintin's hair
#         TRUE ~ hex
#       )
#     ) %>%
#     count(hex, sort = T)
#
#   return(tmp %>% select(hex)) ## I want data frame as a result.
# }
#
# finp <- list.files("dev", pattern = "jpg", full.names = T)
#
# tintin_colours <- map(
#   finp,
#   function(i) {
#     img <- get_colorPal(i)
#
#     return(as.vector(img$hex))
#   }
# )
#
# tintin_colours[[1]]
#
# scales::show_col(tintin_colours[[1]], ncol = 7, labels = FALSE)

finp <- list.files("dev", pattern = "jpg", full.names = T)

tintin_colours <- list()

tintin_colours[[1]] <- c("#165976", "#d04e66", "#ffd613", "#365158", "#3d809d")
tintin_colours[[2]] <- c("#2ac4f6", "#b7da9a", "#ad653f", "#f2f311", "#947964")
tintin_colours[[3]] <- c("#87cceb", "#bbd87e", "#ec4f40", "#1c99b9", "#187352")
tintin_colours[[4]] <- c("#888a7f", "#7aa3d1", "#efae6a", "#b86d4d", "#e2a911")
tintin_colours[[5]] <- c("#e30013", "#1a9abd", "#8d512d", "#de9c62", "#30515a")

tintin_colours[[6]] <- c("#8ba274", "#d8e492", "#89bfe5", "#5c8d78", "#b6c840")
tintin_colours[[7]] <- c("#5499b8", "#c29365", "#9d353e", "#0b509d", "#80767f")
tintin_colours[[8]] <- c("#885a43", "#afa46e", "#ffec8d", "#da1f3e", "#00a7da")
tintin_colours[[9]] <- c("#3ec7f5", "#ffe2a6", "#ca765c", "#7f6360", "#b31b30")
tintin_colours[[10]] <- c("#e31811", "#efaf19", "#b2d2c7", "#cf792e", "#e9a750")

tintin_colours[[11]] <- c("#f2c162", "#98b6b8", "#0095af", "#07a848", "#2f74b9")
tintin_colours[[12]] <- c("#5bc4b3", "#d7e188", "#2ead66", "#f93f4a", "#266052")
tintin_colours[[13]] <- c("#70aa84", "#fcc222", "#945931", "#05acce", "#d92433")
tintin_colours[[14]] <- c("#06b5f4", "#d8652c", "#f1b32c", "#a6834d", "#fbde82")
tintin_colours[[15]] <- c("#e42932", "#23bbe2", "#555249", "#deb589", "#30b8a4")

tintin_colours[[16]] <- c("#5dcaeb", "#f1541f", "#648395", "#d8a345", "#fdd41a")
tintin_colours[[17]] <- c("#ea2a43", "#f18024", "#0291d5", "#629668", "#ddcb81")
tintin_colours[[18]] <- c("#177dc7", "#508551", "#b37731", "#aed361", "#01b8f2")
tintin_colours[[19]] <- c("#0fa9a1", "#cc6554", "#c8870f", "#bb593e", "#7eac6e")

tintin_colours[[20]] <- c("#0598e6", "#b49a1f", "#e2352f", "#bfb38d", "#67a45e")
tintin_colours[[21]] <- c("#104442", "#044d76", "#005e3c", "#3f7656", "#6e928e")
tintin_colours[[22]] <- c("#0097d5", "#b05421", "#fef26a", "#016eaf", "#a0ad75")
tintin_colours[[23]] <- c("#04a0d3", "#c2a471", "#4f8358", "#c0d645", "#9f4834")

names(tintin_colours) <- janitor::make_clean_names(gsub("dev/[0-9][0-9]\\s|\\.jpg", "", finp))

tintin_colours$the_red_sea_sharks

# for (i in seq_along(tintin_colours)) {
#   rgb <- col2rgb(tintin_colours[[i]])
#   lab <- convertColor(t(rgb), 'sRGB', 'Lab')
#   ordered_cols <- tintin_colours[[i]][order(lab[, 'L'])]
#   tintin_colours[[i]] <- ordered_cols
# }

use_data(tintin_colours, overwrite = T)
