library(dplyr)

## Set path and workingdir
# Expected to be run from within project
path <- getwd()
setwd(paste(getwd(), "data_truth/", sep = "/"))

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

saveRDS(covid_regelungen_Bayern, './zusaetzlich/regelungen.Rds')


# reset workingdir
setwd(path)
