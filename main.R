# Librerías
library(tidyverse)
library(magrittr)
library(ggplot2)
library(gridExtra)
library(expss)
library(ggdark)
library(lubridate)
library(DBI)
library(RMySQL)
library(sf)
library(terra)
library(haven)
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
system("git log")
system("git commit -m 'update_1'")
system("git push repos master")
