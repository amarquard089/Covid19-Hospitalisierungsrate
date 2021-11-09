##### Auswertung
# Autor: Qian Feng
# Projekt: Covid 19 - Vorhersage der Hospitalisierungsrate



### Vorbereitung
library(dplyr)
library(data.table)
install.packages("data.table")
library(tidyverse)
install.packages("tidyverse")
### I. Data Wrangling


## 1.1 Input Data**
  
# Wir importieren Daten.
divi_tagesreport <-
  read.csv("https://www.divi.de/divi-intensivregister-tagesreport-archiv-csv/viewdocument/6071/divi-intensivregister-2021-11-02-12-15")  # Daten einlesen


## 1.2 Data Cleaning
summary(divi_tagesreport) # Informationen ueber the Daten

divi_tagesreport$date <- as.Date(divi_tagesreport$date) # Variable "date" wird character in date verwandelt
divi_bundeslaender = data.frame('bundesland' = seq(16), 
                                'bundesland_char' = c("Schleswig-Holstein",
                                                      "Hamburg",
                                                      "Niedersachsen",
                                                      "Bremen",
                                                      "Nordrhein-Westfalen",
                                                      "Hessen",
                                                      "Rheinland-Pfalz",
                                                      "Baden-Württemberg",
                                                      "Bayern",
                                                      "Saarland",
                                                      "Berlin",
                                                      "Brandenburg",
                                                      "Mecklenburg-Vorpommern",
                                                      "Sachsen",
                                                      "Sachen-Anhalt",
                                                      "Thüringen")
)
divi_tagesreport <- dplyr::left_join(divi_tagesreport, divi_bundeslaender, by = 'bundesland')
# summary(divi_tagesreport)
divi_tagesreport$bundesland_fact <- as.factor(divi_tagesreport$bundesland_char)
divi_tagesreport$gemeindeschluessel <- as.factor(divi_tagesreport$gemeindeschluessel)


divi_tagesreport <- divi_tagesreport %>% 
  mutate(delta_meldebreich_standort = anzahl_meldebereiche - anzahl_standorte) %>%
  mutate(nicht_invasive_beatmung = faelle_covid_aktuell - faelle_covid_aktuell_invasiv_beatmet) %>%
  mutate(betten_belegt_nur_kinder = betten_belegt - betten_belegt_nur_erwachsen)

divi_tagesreport <- data.table(divi_tagesreport)
divi_tagesreport <- select(divi_tagesreport, -gemeindeschluessel) # Column "gemeindeschluessel" weg nehmen
divi_tagesreport <- select(divi_tagesreport, -bundesland_char) # Column "bundesland_char" weg nehmen
divi_tagesreport[, lapply(.SD, sum), by=list(date, bundesland_fact)] # An einem Tag gibt es nur die Information fuer ein ganzes Bundesland, aber keine Gemeinde 
divi_tagesreport %>%
  group_by(date, bundesland_fact, faelle_covid_aktuell) %>%
  summarise(count = n(), .groups = "drop") %>%
  ggplot(aes(date, faelle_covid_aktuell, color = count)) +
  geom_point() +
  scale_color_viridis_c(option = "C") +
  facet_wrap(~ bundesland_fact) +
  labs(x = "date", 
       y = "faelle_covid_aktuell") +
  ggtitle("date und faelle_covid_aktuell") # title