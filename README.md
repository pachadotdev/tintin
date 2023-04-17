
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tintin

<!-- badges: start -->
<!-- badges: end -->

The goal of tintin is to provide palettes generated from Tintin covers.
There is one palette per cover, with a total of 24 palettes of 5 colours
each. Includes functions to interpolate colors in order to create more
colors based on the provided palettes.

## Installation

You can install the development version of tintin like so:

``` r
remotes::install_github("pachadotdev/tintin")
```

## Example

This is a basic example which shows you how to create a plot. We’ll plot
the top five causes of injury in the `tintin_head_trauma` dataset that
comes with the package.

<img src="man/figures/README-example-1.png" width="100%" />

What is special about the package is being able to pass the colours as a
function to `ggplot2`. We’ll adapt the previous example to show that
case.

<img src="man/figures/README-cars-1.png" width="100%" />

What happens if we need more colours than 5? The functions in the
package can fix that. We’ll plot the top ten causes of injury.

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" /><img src="man/figures/README-unnamed-chunk-2-2.png" width="100%" />

The use of colour instead of fill is analogous. Let’s plot the top ten
causes of injury per year to see it.

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

We can also use the package for the continuous case. For this case,
we’ll adapt from `ggplot2` examples.

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />
