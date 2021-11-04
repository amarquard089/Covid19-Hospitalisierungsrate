
#
##############################  Dokumentation ##############################  
#

#
###### Divi #####
#

divi_tagesreport <- read.csv("https://www.divi.de/divi-intensivregister-tagesreport-archiv-csv/viewdocument/6071/divi-intensivregister-2021-11-02-12-15")
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
divi_tagesreport <- dplyr::left_join(divi_tagesreport, divi_bundeslaender, by = 'bundesland')

divi_tagesreport$bundesland_fact <- as.factor(divi_tagesreport$bundesland_char)
divi_tagesreport$gemeindeschluessel <- as.factor(divi_tagesreport$gemeindeschluessel)

library(dplyr)

divi_tagesreport <- divi_tagesreport %>% 
  mutate(delta_meldebreich_standort = anzahl_meldebereiche - anzahl_standorte) %>%
  mutate(nicht_invasive_beatmung = faelle_covid_aktuell - faelle_covid_aktuell_invasiv_beatmet) %>%
  mutate(betten_belegt_nur_kinder = betten_belegt - betten_belegt_nur_erwachsen)

### ergänzte Spalten

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



#
##### RKI #####
#


### Klinische Aspekte Excel 
## Bitte Tabelle anschauen ##

library(readxl)

Klinische_Aspekte <- read_excel("Klinische_Aspekte.xlsx", 
                                sheet = "Klinische_Aspekte", skip = 2)

### Spalten

## Meldejahr
# klar

## MW
# Meldewoche im Format KW (Kalenderwoche)

## Fälle gesamt


Faelle_Hospitalisierung_Alter <- read_excel("Klinische_Aspekte.xlsx", 
                                            sheet = "Fälle_Hospitalisierung_Alter", 
                                            skip = 4)

Alter_Median_Mittelwert <- read_excel("Klinische_Aspekte.xlsx", 
                                      sheet = "Alter_Median_Mittelwert", 
                                      col_types = c("date", "text", "numeric", 
                                                    "numeric", "numeric", 
                                                    "numeric", "skip", "skip", 
                                                    "skip", "date", "text", 
                                                    "numeric", "numeric", 
                                                    "numeric", "numeric", 
                                                    "numeric"), 
                                      skip = 3)

Sieben_Tage_Inzidenz_Hosp_Alter <- read_excel("Klinische_Aspekte.xlsx", 
                                          sheet = "7-Tage-Inzidenz_Hosp_Alter", 
                                          skip = 3)