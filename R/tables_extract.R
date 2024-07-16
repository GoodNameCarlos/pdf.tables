
# dlb = Default FALSE, if TRUE indicates that it contains "-" as a separator
# between lower and upper CI.

tables_extract <- function(.data, variables,
                           orvar,
                           icvar,
                           separator,
                           same_var_OR_IC = F,
                           dbl = FALSE) {

  suppressMessages(require(tidyverse))
  suppressMessages(require(stringr))

  if (same_var_OR_IC == T &
      dbl == TRUE &
      is_tibble(.data) == TRUE) {

    .data %>%
      select({{ variables }}) %>%
      mutate(
        OR = str_extract({{ orvar }}, "^\\d{1,}.\\d{1,}"),
        IC = str_extract({{ icvar }}, "(?<=\\()\\d{1,}.\\d{1,}[:punct:]\\d{1,}.\\d{1,}"),
        .keep = "unused") %>%
      mutate(
        tmp_chunks = str_split(IC, pattern = separator, n = 2),
        .keep = "unused") %>%
      mutate(
        lower = map_chr(tmp_chunks, 1),
        upper = map_chr(tmp_chunks, 2),
        .keep = "unused") %>%
      rename(characteristics = X1)

  } else if (same_var_OR_IC == F &
      dbl == TRUE &
      is_tibble(.data) == TRUE) { # contiene un signo de puntuación específico

    .data %>%
      select({{ variables }}) %>%
      mutate(tmp_chunks = str_split({{ icvar }}, pattern = {{ separator }}, n = 2)) %>%
      mutate(lower = map_chr(tmp_chunks, 1),
             upper = map_chr(tmp_chunks, 2)) %>%
      select(-tmp_chunks, -{{ icvar }}) %>%
      rename(characteristics = X1,
             OR = {{orvar}}) %>%
      mutate(OR = str_extract(string = OR, pattern = "\\d{1,3}\\.\\d{1,2}|\\.\\d{1,2}|\\d{1,3}"),
             lower = str_extract(string = lower, pattern = "\\d{1,3}\\.\\d{1,2}|\\.\\d{1,2}|\\d{1,3}"),
             upper = str_extract(string = upper, pattern = "\\d{1,3}\\.\\d{1,2}|\\.\\d{1,2}|\\d{1,3}"))

  } else if (same_var_OR_IC == F &
      dbl == FALSE &
      is_tibble(.data) == TRUE) { # NO contiene un signo de puntuación específico

    .data %>%
      select({{ variables }}) %>%
      mutate(tmp_chunks = str_split({{ icvar }}, pattern = {{ separator }}, n = 2)) %>%
      mutate(lower = map_chr(tmp_chunks, 1),
             upper = map_chr(tmp_chunks, 2)) %>%
      select(-tmp_chunks, -{{ icvar }}) %>%
      rename(characteristics = X1,
             OR = {{ orvar }}) %>%
      mutate(OR = str_extract(string = OR, pattern = "\\d{1,3}\\.\\d{1,2}|\\.\\d{1,2}|\\d{1,3}"))

  } else {
    warning("Check Data")
  }
}
