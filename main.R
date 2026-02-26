# Librerías
library(tidyverse)
library(magrittr)
library(ggplot2)
library(gridExtra)
library(haven)
library(expss)
library(ggdark)
library(lubridate)
library(DBI)
library(RMySQL)
library(sf)
library(terra)
library(rio)
library(broom)
library(pacman)
library(shiny)
library(devtools)

# .lintr
text <- c(
  "linters: linters_with_defaults(",
  "  assignment_linter(allow_pipe_assign = TRUE),",
  "  object_usage_linter = NULL",
  "  )"
)
pathfile <- file.path(getwd(), ".lintr")
writeLines(text, pathfile)

# Git
system("git init")
system("git remote add repos
https://github.com/aerostain/260226_learninigR.git")
system("git remote -v")

system("git status")
system("git add .")
system("git status")
system("git commit -m 'Init'")
system("git log")
system("git push repos master")

dir.create("Databases")
dir.create("Documents")
file.create("Readme.md")
unlink("Informe.qmd", recursive = TRUE)

# ---------------------------------------------------------------------
# Controles básicos
# ---------------------------------------------------------------------

dir()
getwd()
dir("./Databases")

system("git add .")
system("git status")
system("git commit -m 'Update_6'")
system("git log")
system("git push repos master")

system("dir")

dir.create("Compilado")
dir()


# ---------------------------------------------------------------------
# Repaso
# ---------------------------------------------------------------------

d <- mpg
d %>% str()
d %>% count(drv)

library(haven)
library(expss)

spss_data <-
  haven::read_spss(
    file.path(
      "D:\\BackUp Desktop -Abril25\\Documents\\2025\\03Mar\\",
      "d26\\R_Test\\R_Join_II\\Files\\Capítulo_I_NACIONAL.sav"
    )
  )

spss_data %>%
  str() %>%
  capture.output() %>%
  writeLines("str_s.txt")

spss_data_labels <- add_labelled_class(spss_data)

spss_data_labels %>%
  str() %>%
  capture.output() %>%
  writeLines("str_sl.txt")

s <- spss_data
sl <- spss_data_labels

s %>%
  colnames() %>%
  matrix()
sl %>%
  colnames() %>%
  matrix()

s %>% count(DEPARTAMENTO)
sl %>% count(DEPARTAMENTO)

attributes(s$DEPARTAMENTO)
attributes(sl$DEPARTAMENTO)

sl$TIPO_VIA

nps <- c(-1, 0, 1, 1, 0, 1, 1, -1)
var_lab(nps) <- "Net promoter score"
val_lab(nps) <- num_lab("
            -1 Detractors
             0 Neutralists
             1 Promoters
             2 NS/NC
")

nps %>% class()
nps_f <- nps %>% as.factor()
