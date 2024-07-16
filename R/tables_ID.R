# Identifiers of the table, author, year, estimates (OR as default)
tables_ID <- function(.data, author, year, estimate = "OR") {

  suppressMessages(require(tidyverse))

  .data %>%
    mutate(author_year = paste0({{ author }}, " (", {{ year }}, ")"),
           estimate = {{ estimate }},
           characteristics = str_to_lower(characteristics))

}

