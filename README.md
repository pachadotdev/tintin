
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tintin

<!-- badges: start -->
<!-- badges: end -->

The goal of tintin is to provide palettes generated from Tintin covers.
There is one palette per cover, with a total of 24 palettes of 5 colours
each. Includes functions to interpolate colors in order to create more
colors based on the provided palettes.

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

## Installation

You can install the development version of tintin like so:

``` r
remotes::install_github("pachadotdev/tintin")
```

## Example

This is a basic example which shows you how to create a plot. We’ll plot
the top five causes of injury in the `tintin_head_trauma` dataset that
comes with the package.

``` r
library(dplyr)
library(ggplot2)
library(tintin)

total_head_trauma_5 <- tintin_head_trauma %>% 
  arrange(-loss_of_consciousness_length) %>% 
  filter(row_number() <= 5)

ggplot(total_head_trauma_5) +
  geom_col(aes(x = cause_of_injury, y = loss_of_consciousness_length, 
    fill = book_title), position = "dodge") +
  labs(x = "Cause of injury", y = "Loss of consciousness length",
    title = "Top five causes of injury") +
  theme_minimal() +
  scale_fill_manual(values = tintin_colours$the_black_island,
    name = "Book") +
  coord_flip()
```

<img src="man/figures/README-example-1.png" width="100%" />

What is special about the package is being able to pass the colours as a
function to `ggplot2`. We’ll adapt the previous example to show that
case.

``` r
ggplot(total_head_trauma_5) +
  geom_col(aes(x = cause_of_injury, y = loss_of_consciousness_length, 
    fill = book_title), position = "dodge") +
  labs(x = "Cause of injury", y = "Loss of consciousness length",
    title = "Top five causes of injury") +
  theme_minimal() +
  scale_fill_tintin_d(option = "cigars_of_the_pharaoh", direction = -1) +
  coord_flip()
```

<img src="man/figures/README-cars-1.png" width="100%" />

What happens if we need more colours than 5? The functions in the
package can fix that. We’ll plot the top ten causes of injury.

``` r
total_head_trauma_10 <- tintin_head_trauma %>% 
  arrange(-loss_of_consciousness_length) %>% 
  filter(row_number() <= 10)

ggplot(total_head_trauma_10) +
  geom_col(aes(x = cause_of_injury, y = loss_of_consciousness_length, 
    fill = book_title), position = "dodge") +
  labs(x = "Cause of injury", y = "Loss of consciousness length",
    title = "Top ten causes of injury") +
  scale_fill_manual(values = tintin_clrs(
    n = length(unique(total_head_trauma_10$book_title)), 
    option = "the_black_island"),
    name = "Book") +
  coord_flip()
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

``` r
# or alternatively

ggplot(total_head_trauma_10) +
  geom_col(aes(x = cause_of_injury, y = loss_of_consciousness_length, 
    fill = book_title), position = "dodge") +
  labs(x = "Cause of injury", y = "Loss of consciousness length",
    title = "Top ten causes of injury") +
  scale_fill_manual(values = tintin_pal(option = "the_black_island")(8), 
    name = "Book") +
  coord_flip()
```

<img src="man/figures/README-unnamed-chunk-3-2.png" width="100%" />

The use of colour instead of fill is analogous. Let’s plot the top ten
causes of injury per year to see it.

``` r
library(tidyr)

total_head_trauma_y <- tintin_head_trauma %>% 
  group_by(year) %>% 
  summarise_if(is.integer, sum) %>% 
  pivot_longer(loss_of_consciousness_length:loss_of_consciousness_severity)

ggplot(total_head_trauma_y) +
  geom_line(aes(x = year, y = value, color = name), linewidth = 1.5) +
  labs(x = "Year", y = "Loss of consciousness length/severity",
    title = "Result of injuries per year") +
  theme_minimal() +
  scale_colour_manual(values = tintin_pal(option = "the_secret_of_the_unicorn")(2), 
    name = "Cause of injury")
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

We can also use the package for the continuous case. For this case,
we’ll plot a map of Canada.

``` r
# updated 2023-03-26 from
# https://health-infobase.canada.ca/src/data/covidLive/vaccination-coverage-map.csv

library(canadamaps)

vaccination <- data.frame(
  pruid = c(10,11,12,13,24,35,46,47,48,59,60,61,62),
  proptotal_atleast1dose = c(96.1,89.9,89.7,86.9,80.8,84,82.2,81.7,79.7,86.7,84.8,79.1,85)
)

vaccination <- vaccination %>% 
  left_join(get_provinces(), by = "pruid") %>% # canadamaps in action
  mutate(
    label = paste(gsub(" /.*", "", prname),
                  paste0(proptotal_atleast1dose, "%"), sep = "\n"),
  )

vaccination %>% 
  ggplot() +
  geom_sf(aes(fill = proptotal_atleast1dose, geometry = geometry)) +
  geom_sf_label(aes(label = label, geometry = geometry)) +
  scale_fill_tintin_c(option = "the_crab_with_the_golden_claws") +
  labs(title = "Cumulative percent of the population who have received at least 1 dose of a COVID-19 vaccine")
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />
