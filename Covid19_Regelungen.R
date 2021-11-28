library(tidyverse)

######################################################## Covid-19 Einschränkungen Bayern: #################################################
###########################################################################################################################################

## 2020:

covid_regelungen2020_Bayern <- data.frame(matrix(ncol = 8, nrow = 53))

colnames(covid_regelungen2020_Bayern) <- c("Jahr", "KW", "Bundesland", "Medizinische_Maskenpflicht","FFP2_Maskenpflicht",
                                           "Lockdown", "Drei_G", "Zwei_G")


# Attributdefinition der ersten drei Variablen:

covid_regelungen2020_Bayern <- covid_regelungen2020_Bayern %>% 
  mutate(Jahr = 2020, Bundesland = "Bayern", Drei_G = 0, Zwei_G = 0)


x <- 1  
    while (x <= nrow(covid_regelungen2020_Bayern)) {
    covid_regelungen2020_Bayern$KW[x] <- x
    x <- x + 1
  }
  
# Attributdefinitionen der Einschränkungen Variablen:

# Lockdown Einschränkung:

# https://www.wiwo.de/politik/deutschland/corona-lockdown-wie-verlief-der-erste-lockdown-in-deutschland/26853384.html
# https://www.wiwo.de/politik/deutschland/corona-lockdowns-so-ist-der-zweite-lockdown-in-deutschland-verlaufen/27076474.html

# Lockdown 1: KW 12 - 24 (16.03.2020 - 16.06.2020)
# Lockdown 2: KW 45 - 53 (02.11.2020 - Ende des Jahres)
# Quelle: https://de.wikipedia.org/wiki/COVID-19-Pandemie_in_Bayern#Ma%C3%9Fnahmen_der_Bayerischen_Staatsregierung

covid_regelungen2020_Bayern$Lockdown[12:24] <- 1
covid_regelungen2020_Bayern$Lockdown[45:53] <- 1
covid_regelungen2020_Bayern$Lockdown[is.na(covid_regelungen2020_Bayern$Lockdown)] <- 0

# Maskenpflicht:

# Medizinische (oder andere) Maskenpflicht: 27.04.2020 - Ende des Jahres
# FFP2 Maskenpflicht: keine in 2020
# Quelle: https://www.br.de/nachrichten/bayern/corona-ein-jahr-maskenpflicht-in-bayern,SVhTZwh

covid_regelungen2020_Bayern$Medizinische_Maskenpflicht[18:53] <- 1
covid_regelungen2020_Bayern$Medizinische_Maskenpflicht[is.na(covid_regelungen2020_Bayern$Medizinische_Maskenpflicht)] <- 0
covid_regelungen2020_Bayern$FFP2_Maskenpflicht[1:53] <- 0

## 2021:

covid_regelungen2021_Bayern <- data.frame(matrix(ncol = 8, nrow = 47))

colnames(covid_regelungen2021_Bayern) <- c("Jahr", "KW", "Bundesland", "Medizinische_Maskenpflicht","FFP2_Maskenpflicht",
                                           "Lockdown", "Drei_G", "Zwei_G")

covid_regelungen2021_Bayern <- covid_regelungen2021_Bayern %>% 
  mutate(Jahr = 2021, Bundesland = "Bayern")

x <- 1  
while (x <= nrow(covid_regelungen2021_Bayern)) {
  covid_regelungen2021_Bayern$KW[x] <- x
  x <- x + 1
}

# Lockdown Einschränkung:

# Lockdown 2: KW 1 - 20 (bis 21.05.2021)

covid_regelungen2021_Bayern$Lockdown[1:20] <- 1
covid_regelungen2021_Bayern$Lockdown[is.na(covid_regelungen2021_Bayern$Lockdown)] <- 0

# 3G Einschränkung:
# KW 21 - 47 (21.05.2021 - 24.11.2021)
# Quelle: https://de.wikipedia.org/wiki/COVID-19-Pandemie_in_Bayern#%E2%80%9ELockdowns%E2%80%9C_ab_Oktober_2020

covid_regelungen2021_Bayern$Drei_G[21:46] <- 1
covid_regelungen2021_Bayern$Drei_G[is.na(covid_regelungen2021_Bayern$Drei_G)] <- 0

# 2G Einschränkung:
# ab 24.11.2021 (KW 47)

covid_regelungen2021_Bayern$Zwei_G[47] <- 1

covid_regelungen2021_Bayern$Zwei_G[is.na(covid_regelungen2021_Bayern$Zwei_G)] <- 0

# Maskenpflicht:

# FFP2 Pflicht: KW 1 - 35 (ab Januar bis 2. September) und KW 45 - jetzt (ab 06.11.2021 - jetzt)

# Medizinische Maskenpflicht: KW 36 - 44 (02.09.2021 - 06.11.2021)

# Quellen: https://www.br.de/nachrichten/bayern/corona-ein-jahr-maskenpflicht-in-bayern,SVhTZwh
# https://www.augsburger-allgemeine.de/bayern/FFP2-Maske-in-Bayern-FFP2-Maskenpflicht-gilt-wieder-id60927481.html
# https://www.bayern.de/bericht-aus-der-kabinettssitzung-vom-31-august-2021/

covid_regelungen2021_Bayern$Medizinische_Maskenpflicht[36:44] <- 1
covid_regelungen2021_Bayern$Medizinische_Maskenpflicht[is.na(covid_regelungen2021_Bayern$Medizinische_Maskenpflicht)] <- 0

covid_regelungen2021_Bayern$FFP2_Maskenpflicht[1:35] <- 1
covid_regelungen2021_Bayern$FFP2_Maskenpflicht[45:47] <- 1
covid_regelungen2021_Bayern$FFP2_Maskenpflicht[is.na(covid_regelungen2021_Bayern$FFP2_Maskenpflicht)] <- 0

# Finaler Datensatz Covid19 Regelungen Bayern:

covid_regelungen_Bayern <- rbind(covid_regelungen2020_Bayern, covid_regelungen2021_Bayern)

######################################################## Covid-19 Einschränkungen Baden-Württemberg: ######################################
###########################################################################################################################################

## 2020:

covid_regelungen2020_Baden_Wuerttemberg <- data.frame(matrix(ncol = 8, nrow = 53))

colnames(covid_regelungen2020_Baden_Wuerttemberg) <- c("Jahr", "KW", "Bundesland", "Medizinische_Maskenpflicht","FFP2_Maskenpflicht",
                                           "Lockdown", "Drei_G", "Zwei_G")

covid_regelungen2020_Baden_Wuerttemberg <- covid_regelungen2020_Baden_Wuerttemberg %>% 
  mutate(Jahr = 2020, Bundesland = "Baden-Württemberg", Drei_G = 0, Zwei_G = 0)

x <- 1  
while (x <= nrow(covid_regelungen2020_Baden_Wuerttemberg)) {
  covid_regelungen2020_Baden_Wuerttemberg$KW[x] <- x
  x <- x + 1
}

# Lockdown Einschränkung:

# Lockdown 1: KW 12 - 24 (16.03.2020 - 15.06.2020)
# Lockdown 2: KW 45 - 53 (02.11.2020 - Ende des Jahres)
# Quelle: https://www.gew-bw.de/aktuelles/detailseite/corona-rueckblick-2020

covid_regelungen2020_Baden_Wuerttemberg$Lockdown[12:24] <- 1
covid_regelungen2020_Baden_Wuerttemberg$Lockdown[45:53] <- 1
covid_regelungen2020_Baden_Wuerttemberg$Lockdown[is.na(covid_regelungen2020_Baden_Wuerttemberg$Lockdown)] <- 0

# Maskenpflicht:

# Alltagsmaske oder Medizinische Maske: KW 18 - 53 (27.04.2020 - Ende des Jahres)
# Quellen: https://www.baden-wuerttemberg.de/de/service/presse/pressemitteilung/pid/kabinett-beschliesst-sechste-anpassung-der-corona-verordnung/
# https://www.baden-wuerttemberg.de/de/service/presse/pressemitteilung/pid/medizinische-masken-ab-25-januar-in-bussen-und-bahnen-pflicht/
# https://www.baden-wuerttemberg.de/en/service/aktuelle-infos-zu-corona/faq-corona-verordnung/

# Baden-Württemberg hatte nie eine FFP2-Maskenpflicht

covid_regelungen2020_Baden_Wuerttemberg$Medizinische_Maskenpflicht[18:53] <- 1
covid_regelungen2020_Baden_Wuerttemberg$Medizinische_Maskenpflicht[is.na(covid_regelungen2020_Baden_Wuerttemberg$Medizinische_Maskenpflicht)] <- 0
covid_regelungen2020_Baden_Wuerttemberg$FFP2_Maskenpflicht[is.na(covid_regelungen2020_Baden_Wuerttemberg$FFP2_Maskenpflicht)] <- 0

## 2021:

covid_regelungen2021_Baden_Wuerttemberg <- data.frame(matrix(ncol = 8, nrow = 47))

colnames(covid_regelungen2021_Baden_Wuerttemberg) <- c("Jahr", "KW", "Bundesland", "Medizinische_Maskenpflicht","FFP2_Maskenpflicht",
                                                       "Lockdown", "Drei_G", "Zwei_G")

covid_regelungen2021_Baden_Wuerttemberg <- covid_regelungen2021_Baden_Wuerttemberg %>% 
  mutate(Jahr = 2021, Bundesland = "Baden-Württemberg")

x <- 1  
while (x <= nrow(covid_regelungen2021_Baden_Wuerttemberg)) {
  covid_regelungen2021_Baden_Wuerttemberg$KW[x] <- x
  x <- x + 1
}

# Lockdown 2: KW 1 - 20 (Anfang des Jahres bis Mai)
# Quelle: https://de.wikipedia.org/wiki/COVID-19-Pandemie_in_Baden-W%C3%BCrttemberg

covid_regelungen2021_Baden_Wuerttemberg$Lockdown[1:20] <- 1
covid_regelungen2021_Baden_Wuerttemberg$Lockdown[is.na(covid_regelungen2021_Baden_Wuerttemberg$Lockdown)] <- 0

# Maskenpflicht:

# nur medizinische Maske (ganze Jahr):

covid_regelungen2021_Baden_Wuerttemberg$Medizinische_Maskenpflicht[1:47] <- 1

covid_regelungen2021_Baden_Wuerttemberg$FFP2_Maskenpflicht[1:47] <- 0

# 3G:
# KW 33 - 47 (16.08.2021 - 24.11.2021)
# Quelle: https://www.baden-wuerttemberg.de/de/service/presse/pressemitteilung/pid/neue-corona-verordnung-zum-16-august-2021/
# https://www.baden-wuerttemberg.de/de/service/aktuelle-infos-zu-corona/uebersicht-corona-verordnungen/archiv-der-aenderungen-der-corona-verordnungen/

covid_regelungen2021_Baden_Wuerttemberg$Drei_G[33:46] <- 1
covid_regelungen2021_Baden_Wuerttemberg$Drei_G[is.na(covid_regelungen2021_Baden_Wuerttemberg$Drei_G)] <- 0

# 2G:
# ab 24.11.2021

covid_regelungen2021_Baden_Wuerttemberg$Zwei_G[47] <- 1
covid_regelungen2021_Baden_Wuerttemberg$Zwei_G[is.na(covid_regelungen2021_Baden_Wuerttemberg$Zwei_G)] <- 0

# Finaler Datensatz:

covid_regelungen_Baden_Wuerttemberg <- rbind(covid_regelungen2020_Baden_Wuerttemberg, covid_regelungen2021_Baden_Wuerttemberg)

######################################################## Covid-19 Einschränkungen Berlin: #################################################
###########################################################################################################################################

## 2020:

covid_regelungen2020_Berlin <- data.frame(matrix(ncol = 8, nrow = 53))

colnames(covid_regelungen2020_Berlin) <- c("Jahr", "KW", "Bundesland", "Medizinische_Maskenpflicht","FFP2_Maskenpflicht",
                                                       "Lockdown", "Drei_G", "Zwei_G")

covid_regelungen2020_Berlin <- covid_regelungen2020_Berlin %>% 
  mutate(Jahr = 2020, Bundesland = "Berlin", Drei_G = 0, Zwei_G = 0)

x <- 1  
while (x <= nrow(covid_regelungen2020_Berlin)) {
  covid_regelungen2020_Berlin$KW[x] <- x
  x <- x + 1
}

# Lockdown 1 & 2 gleich wie andere Bundesländer

covid_regelungen2020_Berlin$Lockdown[12:24] <- 1
covid_regelungen2020_Berlin$Lockdown[45:53] <- 1
covid_regelungen2020_Berlin$Lockdown[is.na(covid_regelungen2020_Berlin$Lockdown)] <- 0

# Maskenpflicht:

# in 2020 nur Medizinische Maskenpflicht vom 27.04.2020

covid_regelungen2020_Berlin$Medizinische_Maskenpflicht[18:53] <- 1
covid_regelungen2020_Berlin$Medizinische_Maskenpflicht[is.na(covid_regelungen2020_Berlin$Medizinische_Maskenpflicht)] <- 0
covid_regelungen2020_Berlin$FFP2_Maskenpflicht[1:53] <- 0

## 2021:

covid_regelungen2021_Berlin <- data.frame(matrix(ncol = 8, nrow = 47))

colnames(covid_regelungen2021_Berlin) <- c("Jahr", "KW", "Bundesland", "Medizinische_Maskenpflicht","FFP2_Maskenpflicht",
                                                       "Lockdown", "Drei_G", "Zwei_G")

covid_regelungen2021_Berlin <- covid_regelungen2021_Berlin %>% 
  mutate(Jahr = 2021, Bundesland = "Berlin")

x <- 1  
while (x <= nrow(covid_regelungen2021_Berlin)) {
  covid_regelungen2021_Berlin$KW[x] <- x
  x <- x + 1
}

# Lockdown 2:

covid_regelungen2021_Berlin$Lockdown[1:20] <- 1
covid_regelungen2021_Berlin$Lockdown[is.na(covid_regelungen2021_Berlin$Lockdown)] <- 0

# Maskenpflicht:

# ab Anfang April 2021 bis Mitte Juni 2021 FFP2 Maskenpflicht --> KW 13 - 23 
# ab Mitte Oktober FFP2 Maskenpflicht --> KW 41 bis jetzt
# dazwischen Medizinische Maske --> KW 24 - 40

# Quellen: 
# https://www.tagesspiegel.de/berlin/berliner-aergern-sich-ueber-kontrolleure-neue-maskenpflicht-gilt-nicht-fuer-das-bvg-personal/27064398.html
# https://www.tagesspiegel.de/berlin/medizinischer-mundschutz-statt-ffp2-diese-lockerungen-plant-berlin-bei-der-maskenpflicht/27285260.html
# https://www.tagesspiegel.de/berlin/welche-corona-regeln-gelten-in-berlin-masken-2g-oder-3g-freizeit-und-kultur-die-aktuellen-massnahmen-im-ueberblick/26844030.html

covid_regelungen2021_Berlin$Medizinische_Maskenpflicht[24:40] <- 1
covid_regelungen2021_Berlin$Medizinische_Maskenpflicht[is.na(covid_regelungen2021_Berlin$Medizinische_Maskenpflicht)] <- 0

covid_regelungen2021_Berlin$FFP2_Maskenpflicht[13:23] <- 1
covid_regelungen2021_Berlin$FFP2_Maskenpflicht[41:47] <- 1
covid_regelungen2021_Berlin$FFP2_Maskenpflicht[is.na(covid_regelungen2021_Berlin$FFP2_Maskenpflicht)] <- 0

# 2G wie in jedem Bundesland ab 24.11.2021

covid_regelungen2021_Berlin$Zwei_G[47] <- 1
covid_regelungen2021_Berlin$Zwei_G[is.na(covid_regelungen2021_Berlin$Zwei_G)] <- 0

# 3G nix gefunden

## Finaler Datensatz:

covid_regelungen_Berlin <- rbind(covid_regelungen2020_Berlin, covid_regelungen2021_Berlin)

######################################################## Covid-19 Einschränkungen Brandenburg: ############################################
###########################################################################################################################################

## 2020:

# alle Regelungen gleich wie in den anderen Bundesländern

covid_regelungen2020_Brandenburg <- data.frame(matrix(ncol = 8, nrow = 53))

colnames(covid_regelungen2020_Brandenburg) <- c("Jahr", "KW", "Bundesland", "Medizinische_Maskenpflicht","FFP2_Maskenpflicht",
                                           "Lockdown", "Drei_G", "Zwei_G")

covid_regelungen2020_Brandenburg <- covid_regelungen2020_Brandenburg %>% 
  mutate(Jahr = 2020, Bundesland = "Brandenburg", Drei_G = 0, Zwei_G = 0)

x <- 1  
while (x <= nrow(covid_regelungen2020_Brandenburg)) {
  covid_regelungen2020_Brandenburg$KW[x] <- x
  x <- x + 1
}

covid_regelungen2020_Brandenburg$Lockdown[12:24] <- 1
covid_regelungen2020_Brandenburg$Lockdown[45:53] <- 1
covid_regelungen2020_Brandenburg$Lockdown[is.na(covid_regelungen2020_Brandenburg$Lockdown)] <- 0

covid_regelungen2020_Brandenburg$Medizinische_Maskenpflicht[18:53] <- 1
covid_regelungen2020_Brandenburg$Medizinische_Maskenpflicht[is.na(covid_regelungen2020_Brandenburg$Medizinische_Maskenpflicht)] <- 0
covid_regelungen2020_Brandenburg$FFP2_Maskenpflicht[1:53] <- 0

## 2021

covid_regelungen2021_Brandenburg <- data.frame(matrix(ncol = 8, nrow = 47))

colnames(covid_regelungen2021_Brandenburg) <- c("Jahr", "KW", "Bundesland", "Medizinische_Maskenpflicht","FFP2_Maskenpflicht",
                                                "Lockdown", "Drei_G", "Zwei_G")

covid_regelungen2021_Brandenburg <- covid_regelungen2021_Brandenburg %>% 
  mutate(Jahr = 2021, Bundesland = "Brandenburg")

x <- 1  
while (x <= nrow(covid_regelungen2021_Brandenburg)) {
  covid_regelungen2021_Brandenburg$KW[x] <- x
  x <- x + 1
}

# Lockdown: identisch:

covid_regelungen2021_Brandenburg$Lockdown[1:20] <- 1
covid_regelungen2021_Brandenburg$Lockdown[is.na(covid_regelungen2021_Brandenburg$Lockdown)] <- 0

# Maskenpflicht:

# Es gab nie eine FFP2 Maskenpflicht in Brandenburg
# ganze Zeit medizinische Maske
# Quelle: https://www.swp.de/panorama/ffp2-maske-deutschland-op-corona-regeln-bw-bayern-brandenburg-berlin-sachsen-2g-theater-kino-restaurant-schule-3g-60762243.html

covid_regelungen2021_Brandenburg$Medizinische_Maskenpflicht[1:47] <- 1
covid_regelungen2021_Brandenburg$FFP2_Maskenpflicht[is.na(covid_regelungen2021_Brandenburg$FFP2_Maskenpflicht)] <- 0

# 3g Regelung an Inzidenzwert gebunden alles schwer anzugeben
# https://www.brandenburg.de/cms/detail.php/bb1.c.714169.de

# 2G ab 24.11.2021

covid_regelungen2021_Brandenburg$Zwei_G[47] <- 1
covid_regelungen2021_Brandenburg$Zwei_G[is.na(covid_regelungen2021_Brandenburg$Zwei_G)] <- 0

######################################################## Covid-19 Einschränkungen Bremen: #################################################
###########################################################################################################################################

## 2020:

# Quelle: https://www.butenunbinnen.de/nachrichten/politik/jahresrueckblick-corona-chronologie-bremerhaven-bremen-100.html

covid_regelungen2020_Bremen <- data.frame(matrix(ncol = 8, nrow = 53))

colnames(covid_regelungen2020_Bremen) <- c("Jahr", "KW", "Bundesland", "Medizinische_Maskenpflicht","FFP2_Maskenpflicht",
                                                "Lockdown", "Drei_G", "Zwei_G")

covid_regelungen2020_Bremen <- covid_regelungen2020_Bremen %>% 
  mutate(Jahr = 2020, Bundesland = "Bremen", Drei_G = 0, Zwei_G = 0)

x <- 1  
while (x <= nrow(covid_regelungen2020_Bremen)) {
  covid_regelungen2020_Bremen$KW[x] <- x
  x <- x + 1
}

covid_regelungen2020_Bremen$Lockdown[12:24] <- 1
covid_regelungen2020_Bremen$Lockdown[45:53] <- 1
covid_regelungen2020_Bremen$Lockdown[is.na(covid_regelungen2020_Bremen$Lockdown)] <- 0

covid_regelungen2020_Bremen$Medizinische_Maskenpflicht[18:53] <- 1
covid_regelungen2020_Bremen$Medizinische_Maskenpflicht[is.na(covid_regelungen2020_Bremen$Medizinische_Maskenpflicht)] <- 0
covid_regelungen2020_Bremen$FFP2_Maskenpflicht[1:53] <- 0

## 2021:


