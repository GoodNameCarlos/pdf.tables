
# Simple use of str_split(), using default pattern to identify a new line.
str_split_pdf <- function(x, pattern  = "\n", page)  {

  suppressMessages(require(tidyverse))

  tab <- str_split(x, pattern)
  tab <- tab[[ page ]]

}
