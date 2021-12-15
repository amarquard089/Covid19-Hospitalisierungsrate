#
###### Divi #####
#

divi_tagesreport <- read.csv("../data_truth/DIVI/divi_tagesreport.csv", header = TRUE)
head(divi_tagesreport)

### Cleanup data of divi_tagesreport ###

divi_tagesreport$date <- as.Date(divi_tagesreport$date)
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

divi_tagesreport <- left_join(divi_tagesreport, divi_bundeslaender, by = 'bundesland')

divi_tagesreport$bundesland_fact <- as.factor(divi_tagesreport$bundesland_char)
divi_tagesreport$gemeindeschluessel <- as.factor(divi_tagesreport$gemeindeschluessel)



divi_tagesreport <- divi_tagesreport %>% 
  mutate(delta_meldebreich_standort = anzahl_meldebereiche - anzahl_standorte) %>%
  mutate(nicht_invasive_beatmung = faelle_covid_aktuell - faelle_covid_aktuell_invasiv_beatmet) %>%
  mutate(betten_belegt_nur_kinder = betten_belegt - betten_belegt_nur_erwachsen)

### ergänzte Spalten

## bundesland_char:
# Bundesländer namentlich

## bundesland_fact:
# Bundesland_char als faktor

## delta_meldebereich_standort
# delta zwischen meldebreich und standort. Entspricht Krankhäuser mit 
# intensivstation/intensivbereich ohne meldung 

## nicht_invasive_beatmung
# delta zwischen faelle covid und faelle covid invasiv beatmet. Entspricht
# anzahl an personen, die nicht invasiv beatmet werden (könnten allerdings
# trotzdem mit Sauerstoffmaske beatmet werden)
# In dieser Zahl sind also alle Leute enthalten, die nicht beatmet werden oder 
# nur zu einem geringen Maße (low-care). 

## betten_belegt_nur_kinder
# delta belegte bette und belegte betten nur erwachsen. Entspricht anzahl
# kinder auf intensivstation

saveRDS(divi_tagesreport, file = './daten/divi_tagesreport.Rds')


## RKI impfung ####

rki_impfung_bl <- read.csv('rki_impfung_bundeslaender.csv', header = T)
# ergänze Bundesländer
rki_impfung_bl$Impfdatum <- as.Date(rki_impfung_bl)
rki_bundeslaender = data.frame('BundeslandId_Impfort' = seq(16), 
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
                                                     "Sachsen-Anhalt",
                                                     "Thüringen")
)
library(dplyr)
rki_impfung_bl <- left_join(rki_impfung_bl, rki_bundeslaender, by = 'BundeslandId_Impfort')
head(rki_impfung_bl)
saveRDS(rki_impfung_bl, file = './daten/rki_impfung_nach_bundesland.Rds')

rki_impfung_impfquote_heute <- read.csv('rki_impfung_impfquote.csv', header = T)
rki_impfung_impfquote_heute$Datum <- as.Date(rki_impfung_impfquote_heute$Datum)
head(rki_impfung_impfquote_heute)
saveRDS(rki_impfung_impfquote_heute, file = './daten/rki_impfung_gesamt_aktuell.Rds') 