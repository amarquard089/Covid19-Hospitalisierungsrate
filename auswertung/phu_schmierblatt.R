Packages <- c("tidyverse", "productplots", "gganimate", "av",
              "gifski", "gghighlight", "sf", "ggpubr", "data.table",
              "maps", "viridis", "ggrepel", "zoo")
lapply(Packages, library, character.only = TRUE)

Alter_Median_MW_neu <- Alter_Median_MW %>%
  unite(Meldewoche, Meldejahr:Meldewoche, sep=" - ")

ggplot(Alter_Median_MW_neu) +
  geom_line(aes(x = Meldewoche, y = Alle_MW_Alter, group = 1), colour = "red") +
  geom_line(aes(x = Meldewoche, y = Hosp_MW_Alter, group = 1), color = "blue") +
  geom_line(aes(x = Meldewoche, y = Verst_MW_Alter, group = 1), color = "green") +
  labs(x = "Meldewoche", y = "Alter") +
  theme_minimal()

Testzahlen_neu <- Testzahlen %>%
  unite(Meldewoche, Jahr:KW, sep=" - ")

ggplot(Testzahlen_neu, aes(x = Meldewoche, group = 1)) +
  geom_line(aes_string(y = "`Anzahl Testungen`")) +
  geom_line(aes_string(y = "`Positiv getestet`"), color = "red")

ggplot(Sieben_Tage_Inzidenz_Hosp_Alter, aes(x = Meldewoche, group = 1)) +
  geom_line(aes_string(y = "`Inzidenz A00..04`"), color = "red") +
  geom_line(aes_string(y = "`Inzidenz A15..34`"), color = "yellow") +
  geom_line(aes_string(y = "`Inzidenz A35..59`"), color = "blue") +
  geom_line(aes_string(y = "`Inzidenz A60..79`"), color = "green") +
  geom_line(aes_string(y = "`Inzidenz A80+`"), color = "orange") +
  geom_line(aes_string(y = "`Inzidenz A05..14`"), color = "purple") +
  theme_minimal()

klinische_aspekte_neu <- klinische_aspekte %>%
  unite(Meldewoche, Meldejahr:MW, sep=" - ")

ggplot(klinische_aspekte_neu, aes(x = Meldewoche, group = 1)) +
  geom_line(aes_string(y = "`Anzahl hospitalisiert`")) +
  theme_minimal()

sum(blutzucker$`0 min`)

a <- blutzucker %>%
  filter(Mahlzeit == 1) %>%
  select(`30 

?group_by
a <- aggregate(blutzucker[, 2:5], list(blutzucker$Mahlzeit), mean)
aggregate(blutzucker[, 2:5], list(blutzucker$Mahlzeit), function(x) sd(x)/sqrt(length(x)))
a
is.data.frame(a)
a <- as.tibble(a)
a
colnames(a) <- c("Mahlzeit", "0", "30", "60", "120")
a %>%
  gather(Zeit, Value, -Mahlzeit) %>%
  mutate(Zeit = factor(Zeit, levels = c("0", "30", "60", "120"))) %>%
  ggplot(aes(x = Zeit, y = Value)) +
  geom_line(aes(group = Mahlzeit, color = Mahlzeit), size = 1) +
  gghighlight() +
  theme_minimal() +
  xlab("Zeit ")

install.packages("gghighlight")
library(gghighlight)
library(tidyverse)
install.packages("xcolor")

test <- fin_datensatz %>%
  select(Jahrwoche, Hospitalisierung) %>%
  group_by(Jahrwoche) %>%
  summarise(sum(Hospitalisierung))
test
test <- aggregate(fin_datensatz[, 6], list(fin_datensatz$Jahrwoche), sum)
test <- as_tibble(test)
colnames(test) <- c("Jahrwoche", "Hospitalisierung")
ggplot(data = test) +
  geom_col(aes(x = Jahrwoche, y = Hospitalisierung, fill = Jahreszeit)) +
  geom_vline(xintercept = "2020-04") +
  geom_vline(xintercept = "2020-17") +
  geom_vline(xintercept = "2020-30") +
  geom_vline(xintercept = "2020-43") +
  geom_vline(xintercept = "2021-04") +
  geom_vline(xintercept = "2021-17") +
  geom_vline(xintercept = "2021-30") +
  geom_vline(xintercept = "2021-43") +
  theme_minimal() +
  scale_fill_manual(values = c("#4daf4a","#ffd92f", "#d95f02", "#377eb8"))

test <- test %>%
  mutate(WochenID = setdiff(1:100, c(2,3))) %>%
  mutate(Jahreszeit = ifelse(WochenID <= 4, "Winter",
                             ifelse(WochenID <= 17, "Fruehling",
                                    ifelse(WochenID <= 30, "Sommer",
                                           ifelse(WochenID <= 43, "Herbst",
                                                  ifelse(WochenID <= 56, "Winter",
                                                         ifelse(WochenID <= 69, "Fruehling",
                                                                ifelse(WochenID <= 82, "Sommer",
                                                                       ifelse(WochenID <= 95, "Herbst",
                                                                              "Winter"))))))))) %>%
  mutate(Jahreszeit = factor(Jahreszeit, levels = c("Fruehling", "Sommer", "Herbst", "Winter")))
test
a <- c(1,2)
a
tail(test)
setdiff(1:100, c(2,3))


test2 <- fin_datensatz %>%
  select(Jahrwoche, Altersgruppe, Hospitalisierung) %>%
  group_by(Jahrwoche, Altersgruppe) %>%
  summarise(sum(Hospitalisierung))

ggplot(test2) +
  geom_line(aes(x = Jahrwoche, y = `sum(Hospitalisierung)`, 
                group = Altersgruppe, color = Altersgruppe), size = 1) +
  gghighlight() +
  theme_minimal()
  
