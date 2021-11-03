


divi_tagesreport <- read.csv("https://www.divi.de/divi-intensivregister-tagesreport-archiv-csv/viewdocument/6071/divi-intensivregister-2021-11-02-12-15")

divi_tagesreport$bundesland_fact <- as.factor(divi_tagesreport$bundesland)


# Klinische Aspekte Excel
## Bitte Tabelle anschauen ##

library(readxl)

Klinische_Aspekte <- read_excel("Klinische_Aspekte.xlsx", 
                                sheet = "Klinische_Aspekte", skip = 2)

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