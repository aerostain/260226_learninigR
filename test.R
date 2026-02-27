e <- mpg
e %>% select(starts_with("m"))
e %>% select(contains("e"))

p <- product_test
p %>% str()
p %>% count(cell)

p %>%
  select(starts_with("b1_")) %>%
  head()

tg <- ToothGrowth
tg %>% head()
tg %>% str()
tg$supp %<>% as.numeric
tg$supp %>% table()
tg$dose %>% table()

tg %<>% apply_labels(
  len = "Longitud",
  supp = "Tratamiento",
  supp = c("OJ" = 1, "VC" = 2),
  dose = "Dosis",
  dose = c("Baja" = 0.5, "Media" = 1, "Alta" = 2)
)

tg %>% cross_cases(supp)
tg %>% cross_cases(dose)
tg %>% cross_cases(dose, supp)

tg$dose %>% str()
