library(readxl)
library(dplyr)

tintin_head_trauma <- read_excel("dev/tintin_head_trauma.xlsx") %>%
  mutate_if(is.character, as.factor) %>%
  mutate_if(is.double, as.integer) %>%
  arrange(year, page)

use_data(tintin_head_trauma)
