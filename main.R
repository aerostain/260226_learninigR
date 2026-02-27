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
system("git commit -m 'Update_7'")
system("git log")
system("git push repos master")

system("dir")

dir.create("Compilado")
dir()


# ---------------------------------------------------------------------
# Repaso
# ---------------------------------------------------------------------

library(haven)
library(expss)

# Cargando data
spss_data <-
  haven::read_spss(
    file.path(
      "D:\\BackUp Desktop -Abril25\\Documents\\2025\\03Mar\\",
      "d26\\R_Test\\R_Join_II\\Files\\Capítulo_I_NACIONAL.sav"
    )
  )

# Capturando estructura
spss_data %>%
  str() %>%
  capture.output() %>%
  writeLines("str_s.txt")

# Activando labels (Paso Fundamental)
spss_data_labels <- add_labelled_class(spss_data)

spss_data_labels %>%
  str() %>%
  capture.output() %>%
  writeLines("str_sl.txt")

s <- spss_data
sl <- spss_data_labels

# Visualizando estructura
s %>%
  colnames() %>%
  matrix()

sl %>%
  colnames() %>%
  matrix()

s %>% count(DEPARTAMENTO)
sl %>% count(DEPARTAMENTO)

attributes(s$TIPO_VIA)
attributes(sl$TIPO_VIA)

sl$TIPO_VIA

# Para casos excepcionales
nps <- c(-1, 0, 1, 1, 0, 1, 1, -1)
var_lab(nps) <- "Net promoter score"
val_lab(nps) <- num_lab("
            -1 Detractors
             0 Neutralists
             1 Promoters
             2 NS/NC
")

# Siempre usar data.frame o similares
sc <- data.frame(x = sample(1:3, 100, replace = TRUE))
sc %<>% apply_labels(
  x = "Score",
  x = c("A" = 1, "B" = 2, "C" = 3, "Otros" = 98, "No responde" = 99)
)
sc$x
sc %>% cross_cases(x)

sc$x %>% var_lab()
sc$x %>% val_lab()

sc$x %>% unlab()

val_lab(sc$x) <- val_lab(sc$x) %d% 98
val_lab(sc$x) <- val_lab(sc$x) %n_d% "No responde"

m <- mpg
m$year %<>% as.factor
m$year %<>% as.labelled()
m %>% str()
m$year %>% cro()
var_lab(m$year) <- "Año"
m %>% count(year)

nps() %>%
  class()
nps_f <- nps %>% as.factor()

help(as.factor)

score <- sample(-1:1, 20, replace = TRUE)
var_lab(score) <- "Evaluation of tested brand"
val_lab(score) <- c(
  "Dislike it" = -1,
  "So-so" = 0,
  "Like it" = 1
)
score %>% fre()

brands <- as.sheet(t(replicate(20, sample(c(1:5, NA), 4, replace = FALSE))))
var_lab(brands) <- "Used brands"
val_lab(brands) <- make_labels("
                              1 Brand A
                              2 Brand B
                              3 Brand C
                              4 Brand D
                              5 Brand E
                              ")

brands %>% fre()

# Opciones de Consola
options("width" = 10000)
getOption("width")

# Procesamiento
mtcars %>% str()
mtcars %>% info()

cro_cpct(brands, score)
table(age)

products <- 1:8
val_lab(products) <- lab_num("
 Chocolate bars    1
 Chocolate sweets (bulk)	2
 Slab chocolate(packed)	3
 Slab chocolate (bulk)	4
 Boxed chocolate sweets	5
 Marshmallow/pastilles in chocolate coating	6
 Marmalade in chocolate coating	7
 Other	8
")
table(products)

products %>% fre()

data(mtcars)
var_lab(mtcars$am) <- "Transmission"
val_lab(mtcars$am) <- c(automatic = 0, manual = 1)

mtcars %>% str()

summary(lm(mpg ~ am, data = mtcars)) # no labels
summary(lm(mpg ~ fctr(am), data = mtcars)) # with labels
summary(lm(mpg ~ fctr(unvr(am)), data = mtcars))

fctr(mtcars$am)

table(factor(mtcars$am))

x <- 1:3
1:5 %a% 3:7
1:5 %u% 3:7
1:5 %d% 3:7
1:5 %i% 3:7
1:5 %e% 3:7
1:5 %r% 2

iris %n_i% like("Sepal*")
iris %n_i% ("Species" | like("Sepal*"))

data(state)
st <- state.x77
st %>% str()
st %>% class()
st %>%
  colnames() %>%
  matrix()
st %>%
  rownames() %>%
  matrix()
st %>% dim()
dst <- st %>% data.frame()
dst %>% str()

dst_w <- dst %>%
  let(
    # calculate 'weight' variable.
    weight = Population / 100
  ) %>%
  weight_by(weight)

dst_w %>% str()
dst_w %>%
  .$Population %>%
  sum()
dst_w %>%
  .$weight %>%
  sum()
dst_w %>% nrow()

where(iris, Species == "setosa")
rows(iris, 1:5)

iris %>% filter(Species == "setosa")

window_fun(1:3, mean)

attach(warpbreaks)
window_fun(breaks, wool, mean)
window_fun(breaks, tension, function(x) mean(x, trim = 0.1))

warpbreaks$breaks %>% w_mean()
warpbreaks$breaks %>% w_median()

sqrt(100000)

dfs <- mtcars %>% columns(mpg, disp, hp, wt)
with(dfs, w_mean(hp, weight = 1 / wt))

dichotomy_matrix <- matrix(sample(0:1, 40, replace = TRUE, prob = c(.6, .4)), nrow = 10)
colnames(dichotomy_matrix) <- c("Milk", "Sugar", "Tea", "Coffee")
as.category(dichotomy_matrix, compress = TRUE)
category_encoding <- as.category(dichotomy_matrix)

identical(val_lab(category_encoding), c(Milk = 1L, Sugar = 2L, Tea = 3L, Coffee = 4L))
all(as.dichotomy(category_encoding, use_na = FALSE) == dichotomy_matrix)

as.category(dichotomy_matrix, prefix = "products_")
as.category(dichotomy_matrix)

dichotomy_dataframe <- as.data.frame(dichotomy_matrix)
colnames(dichotomy_dataframe) <- paste0("product_", 1:4)
var_lab(dichotomy_dataframe[[1]]) <- "Milk"
var_lab(dichotomy_dataframe[[2]]) <- "Sugar"
var_lab(dichotomy_dataframe[[3]]) <- "Tea"
var_lab(dichotomy_dataframe[[4]]) <- "Coffee"

dichotomy_dataframe %>% str()
as.category(dichotomy_dataframe, prefix = "products_")

set.seed(123)
brands <- as.sheet(t(replicate(20, sample(c(1:5, NA), 4, replace = FALSE))))
var_lab(brands) <- "Used brands"
val_lab(brands) <- autonum("
Brand A
Brand B
Brand C
Brand D
Brand E
")
brands %>% str()

score <- sample(-1:1, 20, replace = TRUE)
var_lab(score) <- "Evaluation of tested brand"
val_lab(score) <- make_labels("-1 Dislike it
0 So-so
1 Like it
")
score %>% str()

brands
as.dichotomy(brands)
etable_mtcars <- as.etable(mtcars)

as.etable(brands)
brands

counts <- table(mtcars$am, mtcars$vs)
props <- prop.table(counts)
compare_proportions(
  props[, 1], props[, 2],
  colSums(counts)[1], colSums(counts)[1]
)

t.test(mpg ~ am, data = mtcars)$p.value
# the same result
with(
  mtcars,
  compare_means(
    mean(mpg[am == 0]), mean(mpg[am == 1]),
    sd(mpg[am == 0]), sd(mpg[am == 1]),
    length(mpg[am == 0]), length(mpg[am == 1])
  )
)

dfs <- data.frame(
  test = 1:5,
  a = rep(10, 5),
  b_1 = rep(11, 5),
  b_2 = rep(12, 5),
  b_3 = rep(13, 5),
  b_4 = rep(14, 5),
  b_5 = rep(15, 5)
)

x <-
  let(dfs,
    b_total = sum_row(b_1 %to% b_5),
    b_total = set_var_lab(b_total, "Sum of b"),
    random_numbers = runif(.N) # .N usage
  )

x %>% str()

data(product_test)

product_test %>% head(15)
product_test %>% str()
cross_cpct(product_test, mrset(a1_1 %to% a1_6))
pt <- product_test
pt %>% head()
pt %>%
  as.dichotomy() %>%
  head()

product_test %>% colnames()
pta <- pt %>% select(starts_with("a1_"))
ptb <- pt %>% select(starts_with("b1_"))
pt %>% head()
pta %>% head()
ptb %>% head()

ptb %>%
  as.dichotomy() %>%
  head()
ptb %>% filter(b1_1 == 98)

# Supongamos que buscas el valor "Meta"
valor_buscado <- 98

# Retorna las filas donde el valor aparece al menos una vez
filas_con_valor <- pt[rowSums(datos == valor_buscado, na.rm = TRUE) > 0, ]

pt[rowSums(ptb == 98, na.rm = T) > 0, ]

ptb <- pt %>% select(id, starts_with("b1_"))
rownames(ptb) <- paste0("i", seq_len(150))

ptb %>%
  filter(if_any(everything(), ~ . == 98)) %>%
  {
    .$b1_1 <- 1
    .
  }

ptb[43, ]

ptb %<>% select(starts_with("b1_"))
ptb %>%
  as.dichotomy() %>%
  head()
ptb %>% head()

x <- data.frame(dist = 1:10, speed = rnorm(10))
x

x %>%
  filter(dist == 5) %>%
  .$dist %>%
  (\(x) 5)

x %>%
  filter(dist == 5) %>%
  mutate(dist = 99)

file.create("test.R")
