#
#### Zusätzliche Daten ####
#

# Library
library(dplyr)

## Set path and workingdir
# Expected to be run from within project
path <- getwd()
setwd(paste(getwd(), "data_truth/", sep = "/"))

## Bevölkerungsdichte und -Daten

# Bevölkerungsdaten Deutschland:
# Quelle:https://www-genesis.destatis.de/genesis/online?operation=ergebnistabelleQualitaetSeparatAUS&levelindex=2&levelid=1636663183136&downloadname=12411-0010#abreadcrumb
# Stand 31.12.2020

# fläche bundesländer deutschland:
# Quelle: https://de.statista.com/statistik/daten/studie/154868/umfrage/flaeche-der-deutschen-bundeslaender/
# Stand 31.12.2020

bundeslaender_einwohner <- "Baden-Württemberg	11103043\t35748
Bayern	13140183\t70542
Berlin	3664088\t891
Brandenburg	2531071\t29654
Bremen	680130\t420
Hamburg	1852478\t755
Hessen	6293154\t21116
Mecklenburg-Vorpommern	1610774\t23295
Niedersachsen	8003421\t47710
Nordrhein-Westfalen	17925570\t34112
Rheinland-Pfalz	4098391\t19858
Saarland	983991\t2571
Sachsen	4056941\t18450
Sachsen-Anhalt	2180684\t20459
Schleswig-Holstein	2910875\t15804
Thüringen	2120237\t16202"

bundeslaender_einwohner <- unlist(strsplit(strsplit(bundeslaender_einwohner, "\t")[[1]], "\n"))

bundeslaender <- bundeslaender_einwohner[seq(length(bundeslaender_einwohner)) %% 3 == 1]
bevoelkerung <- bundeslaender_einwohner[seq(length(bundeslaender_einwohner)) %% 3 == 2]
flaeche_qkm <- bundeslaender_einwohner[seq(length(bundeslaender_einwohner)) %% 3 == 0]

bevoelkerungsdichte <- data.frame(bundesland = bundeslaender, 
                                  bevoelkerung = as.numeric(bevoelkerung),
                                  flaeche_qkm = as.numeric(flaeche_qkm))

bevoelkerungsdichte <- bevoelkerungsdichte %>% mutate(b_dichte = bevoelkerung / flaeche_qkm)

saveRDS(bevoelkerungsdichte, file = './zusaetzlich/bevoelkerungsdichte.Rds')

# reset workingdir
setwd(path)





