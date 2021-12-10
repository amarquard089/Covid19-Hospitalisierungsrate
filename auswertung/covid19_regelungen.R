# Covid19 Regelungen, nur Lockdown
# title: "Covid19_Regelungen_Datensätze"
# author: "Johannes Pfeifer (12129959)"
# date: "25 11 2021"


covid_regelungen2020_Bayern <- data.frame(matrix(ncol = 8, nrow = 53))

colnames(covid_regelungen2020_Bayern) <- c("Jahr", "KW", "Bundesland", "Medizinische_Maskenpflicht","FFP2_Maskenpflicht",
                                           "Lockdown", "Drei_G", "Zwei_G")

covid_regelungen2020_Bayern <- covid_regelungen2020_Bayern %>% 
  mutate(Jahr = 2020, Bundesland = "Bayern", Drei_G = 0, Zwei_G = 0)

x <- 1  
while (x <= nrow(covid_regelungen2020_Bayern)) {
  covid_regelungen2020_Bayern$KW[x] <- x
  x <- x + 1
}

covid_regelungen2020_Bayern$Lockdown[12:24] <- 1
covid_regelungen2020_Bayern$Lockdown[45:53] <- 1
covid_regelungen2020_Bayern$Lockdown[is.na(covid_regelungen2020_Bayern$Lockdown)] <- 0

covid_regelungen2020_Bayern$Medizinische_Maskenpflicht[18:53] <- 1
covid_regelungen2020_Bayern$Medizinische_Maskenpflicht[is.na(covid_regelungen2020_Bayern$Medizinische_Maskenpflicht)] <- 0
covid_regelungen2020_Bayern$FFP2_Maskenpflicht[1:53] <- 0

# 2021 Datensatz:

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

covid_regelungen2021_Bayern$Lockdown[1:20] <- 1
covid_regelungen2021_Bayern$Lockdown[is.na(covid_regelungen2021_Bayern$Lockdown)] <- 0

covid_regelungen2021_Bayern$Drei_G[21:46] <- 1
covid_regelungen2021_Bayern$Drei_G[is.na(covid_regelungen2021_Bayern$Drei_G)] <- 0

covid_regelungen2021_Bayern$Zwei_G[47] <- 1
covid_regelungen2021_Bayern$Zwei_G[is.na(covid_regelungen2021_Bayern$Zwei_G)] <- 0

covid_regelungen2021_Bayern$Medizinische_Maskenpflicht[36:44] <- 1
covid_regelungen2021_Bayern$Medizinische_Maskenpflicht[is.na(covid_regelungen2021_Bayern$Medizinische_Maskenpflicht)] <- 0

covid_regelungen2021_Bayern$FFP2_Maskenpflicht[1:35] <- 1
covid_regelungen2021_Bayern$FFP2_Maskenpflicht[45:47] <- 1
covid_regelungen2021_Bayern$FFP2_Maskenpflicht[is.na(covid_regelungen2021_Bayern$FFP2_Maskenpflicht)] <- 0

# Finaler Datensatz:

covid_regelungen_Bayern <- rbind(covid_regelungen2020_Bayern, covid_regelungen2021_Bayern)