
#
# Collect Data ####
#

## Set path and workingdir
# Expected to be run from within project
path <- getwd()
setwd(paste(getwd(), "data_truth/", sep = "/"))

## Python Stuff #### 

# if (!require("reticulate")) install.packages("reticulate")
# reticulate::py_run_file("./fetchdata.py")

## LMU ####

lmu_nowcasting <- read.csv('./LMU/nowcasting_lmu_hosp.csv', header = T)
saveRDS(lmu_nowcasting, './LMU/nowcasting_lmu_hosp.Rds')

## RKI ####

# from: https://github.com/robert-koch-institut/SARS-CoV-2_Infektionen_in_Deutschland
# Aktuell_Deutschland_SarsCov2_Infektionen
inzidenz_link <- "https://media.githubusercontent.com/media/robert-koch-institut/SARS-CoV-2_Infektionen_in_Deutschland/master/Aktuell_Deutschland_SarsCov2_Infektionen.csv"
inzidenz <- read.csv(inzidenz_link, header = T)

saveRDS(inzidenz, "./RKI/infektionen.Rds")

# from:https://github.com/robert-koch-institut/COVID-19-Hospitalisierungen_in_Deutschland
# Aktuell_Deutschland_COVID-19-Hospitalisierungen
hospitalisierung_link <- "https://raw.githubusercontent.com/robert-koch-institut/COVID-19-Hospitalisierungen_in_Deutschland/master/Aktuell_Deutschland_COVID-19-Hospitalisierungen.csv"
hospitalisierung <- read.csv(hospitalisierung_link, header = T)
colnames(hospitalisierung) <- c("Datum", "Bundesland", "Bundesland_Id", 
                                "Altersgruppe", "7T_Hospitalisierung_Faelle", 
                                "7T_Hospitalisierung_Inzidenz")

saveRDS(hospitalisierung, "./RKI/hospitalisierung.Rds")

# Aktuell_Deutschland_adjustierte-COVID-19-Hospitalisierungen
hospitalisierungnowcasting_link <- "https://raw.githubusercontent.com/robert-koch-institut/COVID-19-Hospitalisierungen_in_Deutschland/master/Aktuell_Deutschland_adjustierte-COVID-19-Hospitalisierungen.csv"
hospitalisierungnowcasting <- read.csv(hospitalisierungnowcasting_link, header = T)

saveRDS(hospitalisierungnowcasting, "./RKI/hospitalisierung_adjustiert.Rds")

# from: https://github.com/robert-koch-institut/COVID-19-Impfungen_in_Deutschland
# Aktuell_Deutschland_Landkreis_COVID-19-Impfungen
impfung_link <- "https://raw.githubusercontent.com/robert-koch-institut/COVID-19-Impfungen_in_Deutschland/master/Aktuell_Deutschland_Landkreise_COVID-19-Impfungen.csv"
impfung <- read.csv(impfung_link, header = T)

saveRDS(impfung, "./RKI/impfungen.Rds")

## KITMETRICSLAB ####

kit_bevoelkerung <- read.csv("https://raw.githubusercontent.com/KITmetricslab/hospitalization-nowcast-hub/main/other_data/population_sizes.csv", header = T)
colnames(kit_bevoelkerung) <- c("ID", "location", "age_group", "population")

kit_bevoelkerung$location <- unlist(sapply(kit_bevoelkerung$location, function(x) {
  switch(x,
         "DE-BW" = "Baden-Württemberg",
         "DE-BY" = "Bayern",
         "DE-BE" = "Berlin",
         "DE-BB" = "Brandenburg",
         "DE-HB" = "Bremen",
         "DE-HH" = "Hamburg",
         "DE-HE" = "Hessen",
         "DE-MV" = "Mecklenburg-Vorpommern",
         "DE-NI" = "Niedersachsen",
         "DE-NW" = "Nordrhein-Westfalen",
         "DE-RP" = "Rheinland-Pfalz",
         "DE-SL" = "Saarland",
         "DE-SN" = "Sachsen",
         "DE-ST" = "Sachen-Anhalt",
         "DE-SH" = "Schleswig-Holstein",
         "DE-TH" = "Thüringen",
         "DE" = "DE")
}))

saveRDS(kit_bevoelkerung, file = './KIT/kit_bevoelkerung.Rds')

# reset workingdir
setwd(path)
