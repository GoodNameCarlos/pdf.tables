
# Import metadata from pdf.
herrington <- pdftools::pdf_text(pdf = "D:/OneDrive/Investigación/Artículos/00 - Referencias/MCPS/Herrington (2018).pdf")

# Indicates the page where the table is located.
step1 <- str_split_pdf(herrington, page = 5)

# Select the range of values that make up the table.
step2 <- step1[c(44:55)]

# Use pdf_tables() function to arrange the information
step3 <- pdf_tables(step2)

# Remove or select all values with no information or that are not part of the
# data set.
step4 <- step3[-8,]

# Extract table indicating column with variable names and colums with estimates.
RR_1 <- step4 %>%
  tables_extract(variables = c(X1, X7),
                 orvar = X7, icvar = X7,
                 same_var_OR_IC = T,
                 separator = "–", dbl = T)

RR_2 <- step4 %>%
  tables_extract(variables = c(X1, X8),
                 orvar = X8, icvar = X8,
                 same_var_OR_IC = T,
                 separator = "–", dbl = T)

# Optional: Prepare tables with ID.
tables_ID(RR_1, author = "Herrington", year = "2018", estimate = "Risk Ratio")
tables_ID(RR_2, author = "Herrington", year = "2018", estimate = "Risk Ratio")


Gnatiuc <- pdftools::pdf_text(pdf = "D:/OneDrive/Investigación/Artículos/00 - Referencias/MCPS/Gnatiuc (2019).pdf")

step1 <- str_split_pdf(Gnatiuc, page = 7)
step1
step2 <- step1[c(44:62)]

step3 <- pdf_tables(step2)
step4 <- step3 %>% filter(X2 != "")

step4 %>%
  tables_extract(variables = c(X1, X3),
                 orvar = X3, icvar = X3,
                 same_var_OR_IC = T,
                 separator = "–", dbl = T)

step4 %>%
  tables_extract(variables = c(X1, X5),
                 orvar = X5, icvar = X5,
                 same_var_OR_IC = T,
                 separator = "–", dbl = T)

