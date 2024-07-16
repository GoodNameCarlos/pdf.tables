## Create table from stringr proccesed object
pdf_tables <- function(data) {

  # requiere tidiverse
  suppressMessages(require(tidyverse))

  if (is.character(data) == TRUE) {

    data %>%
      str_trim() %>%
      str_split("\\s{2,}", simplify = T) %>%
      data.frame(stringsAsFactors = F) %>%
      as_tibble()

  } else {

    warning("No character object")

  }
}

