
#
##############################  Dokumentation ##############################  
#

# Run python to collect files
 
if (FALSE) {
  if (!require("reticulate")) install.packages("reticulate")
  reticulate::py_run_file("fetchdata.py")
}


#
###### Divi #####
#


divi_tagesreport <- read.csv("divi_tagesreport.csv", header = TRUE)
head(divi_tagesreport)

### Columns (pls view divi_tagesreport_Erklaerung_Spalten.pdf):

## date: 
# Min-date: 24.04.2020 Max-date: 02.11.2020, each observation equals one day

## bundesland:
# bundesland with the following coding:
# 01 Schleswig-Holstein
# 02 Freie und Hansestadt Hamburg
# 03 Niedersachsen
# 04 Freie Hansestadt Bremen
# 05 Nordrhein-Westfalen
# 06 Hessen
# 07 Rheinland-Pfalz
# 08 Baden-Württemberg
# 09 Freistaat Bayern
# 10 Saarland
# 11 Berlin
# 12 Brandenburg
# 13 Mecklenburg-Vorpommern
# 14 Freistaat Sachsen
# 15 Sachsen-Anhalt
# 16 Freistaat Thüringen


## gemeindeschluessel: Siehe PDF (u.U. keine Relevanz)

## anzahl_standorte:
# Die Anzahl der Standorte gibt an, wie viele Standorte des jeweiligen
# Landkreises eine Meldung abgegeben haben und in den aktuellen Datenstand 
# einfließen.

# Was ist ein (Krankenhaus-)Standort?
# 
# Jedes Krankenhaus kann einen oder mehrere Krankenhaus-Standorte haben. 
# Die Standorte zugelassener deutscher Krankenhäuser sind im InEK-
# Standort-Verzeichnis (https://krankenhausstandorte.de/info) mit eindeutiger 
# Standort-ID registriert. 
# Diese Liste enthält keine Information darüber, 
# ob ein Standort intensivmedizinische Betten besitzt oder nicht.


## anzahl_meldebereiche:
# Ein Meldebereich entspricht einer Intensivstation oder einem Intensivbereich, für welchen das dort
# arbeitende fachmedizinische Personal Meldungen im DIVI-Intensivregister (täglich) abgibt.
# 
# Was ist ein Meldebereich?
# Ein Meldebereich ist ein von dem meldenden Arzt/Ärztin definierter Bereich für 
# den eine bestimmte Anzahl von Intensivbetten zur Akutbehandlung 
# (und nur Intensivbetten) in einem Krankenhaus-Standort gemeldet werden.


## faelle_covid_aktuell
# Anzahl aller aktuell in intensivmedizinischer Behandlung (beatmet und nicht beatmet) 
# befindlichen COVID-19-Patient*innen (Erwachsene und Kinder) in den definierten 
# ICU-Versorgungsstufen (low-high und ecmo). Dabei nur nachgewiesene Infektionen mit SARS-CoV-2 und 
# keine reinen Verdachtsfälle. 


## faelle_covid_aktuell_invasiv_beatmet
# Anzahl aktuell beatmeter COVID-19-Patient*innen (Erwachsene und Kinder) in 
# intensivmedizinischer Behandlung, bezogen nur auf invasive Beatmung und ECMO.
# 
# Hinweis: Diese Angabe bezieht sich auf COVID-19-Intensivpatient*innen mit 
# invasiver Beatmung. Das bedeutet nicht, dass die anderen 
# COVID-19-Intensivpatient*innen nicht beatmet werden. Evtl. erfolgt
# dort eine nicht-invasive Beatmung (z.B. über Sauerstoffmaske). 


## betten_frei
# Anzahl der freien, betreibbaren Intensivbetten (Low- und High-Care) 
# für Erwachsene und Kinder zur
# Behandlung von allen intensivpflichtigen Erkrankungen.


## betten_belegt
# Anzahl der belegten Intensivbetten (Low- und High-Care), unabhängig von der 
# Behandlungsursache, für
# Erwachsene und Kinder


## betten_belegt_nur_erwachsen
# Anzahl der belegten Intensivbetten (Low- und High-Care), unabhängig von der 
# Behandlungsursache, NUR
# für Erwachsene 


## betten_frei_nur_erwachsen
# Anzahl der freien, betreibbaren Intensivbetten (Low- und High-Care) NUR für 
# Erwachsene zur
# Behandlung von allen intensivpflichtigen Erkrankungen.

# **was bedeutet Low- und High-Care:
# Intensivbetten ohne invasive Beatmungsmöglichkeit (ICU low care), 
# Intensivbetten mit invasiver Beatmungsmöglichkeit (ICU high care)



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
library(dplyr)
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

#
##### RKI #####
#

# Download excel data
download.file(url = 'https://www.rki.de/DE/Content/InfAZ/N/Neuartiges_Coronavirus/Daten/Klinische_Aspekte.xlsx?__blob=publicationFile',
              destfile = './Klinische_Aspekte.xlsx', mode = 'wb')


### Klinische Aspekte Excel 
## Bitte Tabelle anschauen ##

library(readxl)

Klinische_Aspekte <- read_excel("Klinische_Aspekte.xlsx", 
                                sheet = "Klinische_Aspekte", skip = 2)

saveRDS(Klinische_Aspekte, file = './daten/klinische_aspekte.Rds')


Faelle_Hospitalisierung_Alter <- read_excel("Klinische_Aspekte.xlsx", 
                                            sheet = "Fälle_Hospitalisierung_Alter", 
                                            skip = 4)
Faelle_Hospitalisierung_Alter <- 
  Faelle_Hospitalisierung_Alter[, -dim(Faelle_Hospitalisierung_Alter)[[2]]]

saveRDS(Faelle_Hospitalisierung_Alter, file = './daten/Faelle_Hosp_Alter.Rds')


Alter_Median_Mittelwert <- read_excel("Klinische_Aspekte.xlsx", 
                                      sheet = "Alter_Median_Mittelwert", 
                                      skip = 3)

Alter_Median <- Alter_Median_Mittelwert[, seq(6)]
names(Alter_Median) <- c("Meldejahr", "Meldewoche", names(Alter_Median)[seq(from = 3, to = 6, by = 1)])
Alter_Median

Alter_Mittelwert <- Alter_Median_Mittelwert[, seq(from = 10, to = 16, by = 1)]
names(Alter_Mittelwert) <- c("Meldejahr", "Meldewoche", names(Alter_Mittelwert)[seq(from = 3, to = 7, by = 1)])
Alter_Mittelwert

Alter_Median_Mittelwert_clean <- Alter_Median_Mittelwert[, c(seq(6), 12, 13, 14, 15, 16)]
names(Alter_Median_Mittelwert_clean) <- c("Meldejahr", "Meldewoche", names(Alter_Median_Mittelwert_clean)[c(-1,-2)])
Alter_Median_Mittelwert_clean

head(Alter_Median_Mittelwert_clean)
saveRDS(Alter_Median_Mittelwert_clean, file = './daten/Alter_Median_MW.Rds')


Sieben_Tage_Inzidenz_Hosp_Alter <- read_excel("Klinische_Aspekte.xlsx", 
                                              sheet = "7-Tage-Inzidenz_Hosp_Alter", 
                                              skip = 3)

Sieben_Tage_Inzidenz_Hosp_Alter <- 
  Sieben_Tage_Inzidenz_Hosp_Alter[, -dim(Sieben_Tage_Inzidenz_Hosp_Alter)[[2]]]

head(Sieben_Tage_Inzidenz_Hosp_Alter)
saveRDS(Sieben_Tage_Inzidenz_Hosp_Alter, file = './daten/Sieben_Tage_Inzidenz_Hosp_Alter.Rds')

## nowcast RKI

nowcast_rki <- read.csv("rki_nowcast.csv", header = T)

nowcast_rki$Datum <- as.Date(nowcast_rki$Datum)

saveRDS(nowcast_rki, file = './daten/nowcasting_rki.Rds')

## Testzahlen RKI

download.file('https://www.rki.de/DE/Content/InfAZ/N/Neuartiges_Coronavirus/Daten/Testzahlen-gesamt.xlsx?__blob=publicationFile', 
              destfile = './Testzahlen.xlsx', mode = 'wb')

Testzahlen <- read_excel("Testzahlen.xlsx", 
                         sheet = "1_Testzahlerfassung")
Testzahlen <- Testzahlen[c(-1,-dim(Testzahlen)[[1]]) ,]

Testzahlen <- Testzahlen %>%
  mutate(KW = unlist(str_split(Testzahlen$Kalenderwoche, 
                               '/'))[seq(dim(Testzahlen)[[1]]) %% 2 == 1],
         Jahr = unlist(str_split(Testzahlen$Kalenderwoche, 
                                 '/'))[seq(dim(Testzahlen)[[1]]) %% 2 == 0])

Testzahlen <- Testzahlen[, c(7,6,2,3,4,5)]
head(Testzahlen)

saveRDS(Testzahlen, file = './daten/Testzahlen.Rds')


### Inzidenz Impfstatus excel

download.file('https://www.rki.de/DE/Content/InfAZ/N/Neuartiges_Coronavirus/Daten/Inzidenz_Impfstatus.xlsx?__blob=publicationFile',
              destfile = './Inzidenz_Impfstatus.xlsx', mode = 'wb')

inzidenz_symptomatisch <- read_excel("Inzidenz_Impfstatus.xlsx", 
                                  sheet = "Symptomatische_nach_Impfstatus", 
                                  skip = 1)

inzidenz_hospitalisiert <- read_excel("Inzidenz_Impfstatus.xlsx", 
                                  sheet = "Hospitalisierte_nach_Impfstatus", 
                                  skip = 1)

head(inzidenz_symptomatisch)
head(inzidenz_hospitalisiert)

saveRDS(inzidenz_symptomatisch, file = './daten/inzidenz_symptom.Rds')
saveRDS(inzidenz_hospitalisiert, file = './daten/inzidenz_hosp.Rds')

## RKI Impfung nach Bundesländern

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

### Yegi daten ####


library(readr)
nowcasting_lmu_08_11 <- read_delim("Yegi 9.11/nowcasting_results_2021-11-08.csv", 
                                            delim = "\t", escape_double = FALSE, 
                                            trim_ws = TRUE)

saveRDS(nowcasting_lmu_08_11, file = './daten/nowcasting_lmu_08_11.Rds')

nowcasting_lmu_08_11_hosp <- read_delim("Yegi 9.11/nowcasting_results_Hospdatum_2021-11-08.csv", 
                                                      delim = ";", escape_double = FALSE, trim_ws = TRUE)

saveRDS(nowcasting_lmu_08_11_hosp, file = './daten/nowcasting_lmu_08_11_hosp.Rds')


