library(tidyverse)
library(ggpubr)


### Fälle Hospitalisierung nach Alter im Jahr 2020 und 2021:

## Datensatz:
Faelle_Hosp_Alter <- readRDS("C:/Users/elvis/Desktop/Covid19-Hospitalisierungsrate/daten/Faelle_Hosp_Alter.Rds")

## 2020:

# Gefilterter Datensatz mit besseren Variablennamen:

faelle_hosp_alter_2020 <- Faelle_Hosp_Alter %>% 
  filter(Faelle_Hosp_Alter$...1 == 2020)

colnames(faelle_hosp_alter_2020) <- c("Meldejahr", "Meldewoche", "bis4jahre", "bis14jahre", "bis34jahre", "bis59jahre", "bis79jahre", 
                                "ab80jahre")

# Plot:

faelle_hosp_alter_2020_plot <- ggplot(faelle_hosp_alter_2020, aes(x = as.numeric(Meldewoche))) + 
  geom_line(aes(y = as.numeric(bis4jahre), colour = "0 - 4 Jahre")) + geom_line(aes(y = as.numeric(bis14jahre), colour = "5 - 14 Jahre")) + 
  geom_line(aes(y = as.numeric(bis34jahre), colour = "15 - 34 Jahre")) + geom_line(aes(y = as.numeric(bis59jahre), colour = "35 - 59 Jahre")) +
  geom_line(aes(y = as.numeric(bis79jahre), colour = "60 - 79 Jahre")) + geom_line(aes(y = as.numeric(ab80jahre), colour = "80+ Jahre")) + 
  xlab("Meldewoche") + ylab("Fälle Hospitalisierung") + labs(color = "Alter") + ggtitle("2020") + ylim(0, 6000)
  

## 2021:

# Gefilterter Datensatz mit besseren Variablennamen:

faelle_hosp_alter_2021 <- Faelle_Hosp_Alter %>% 
  filter(Faelle_Hosp_Alter$...1 == 2021)

colnames(faelle_hosp_alter_2021) <- c("Meldejahr", "Meldewoche", "bis4jahre", "bis14jahre", "bis34jahre", "bis59jahre", "bis79jahre", 
                                      "ab80jahre")

# Plot:

faelle_hosp_alter_2021_plot <- ggplot(faelle_hosp_alter_2021, aes(x = as.numeric(Meldewoche))) + 
  geom_line(aes(y = as.numeric(bis4jahre), colour = "0 - 4 Jahre")) + geom_line(aes(y = as.numeric(bis14jahre), colour = "5 - 14 Jahre")) + 
  geom_line(aes(y = as.numeric(bis34jahre), colour = "15 - 34 Jahre")) + geom_line(aes(y = as.numeric(bis59jahre), colour = "35 - 59 Jahre")) +
  geom_line(aes(y = as.numeric(bis79jahre), colour = "60 - 79 Jahre")) + geom_line(aes(y = as.numeric(ab80jahre), colour = "80+ Jahre")) + 
  xlab("Meldewoche") + ylab("Fälle Hospitalisierung") + labs(color = "Alter") + ggtitle("2021") + ylim(0, 6000)


## Finaler Plot

combined_faelle_hosp_plot <- ggarrange(faelle_hosp_alter_2020_plot, faelle_hosp_alter_2021_plot, common.legend = TRUE)
combined_faelle_hosp_plot <- annotate_figure(combined_faelle_hosp_plot, top = text_grob("Hospitalisierungsfälle in 2020 und 2021", size = 16))

combined_faelle_hosp_plot


### Inzidenz der Krankenhäuser (Hospitalisierung) nach Alter und Impfstatus:

## Datensatz:
inzidenz_hosp <- readRDS("C:/Users/elvis/Desktop/Covid19-Hospitalisierungsrate/daten/inzidenz_hosp.Rds")

## Alter 18 - 59 Jahre:

# Gefilterter Datensatz mit besseren Variablennamen:

inzidenz_hosp_bis59jahre <- inzidenz_hosp %>%
  select("Meldewoche", "Ungeimpfte 18-59 Jahre", "Vollständig Geimpfte  18-59 Jahre")

colnames(inzidenz_hosp_bis59jahre) <- c("meldewoche", "ungeimpft", "geimpft")

# Plot: 

inzidenz_hosp_bis59jahre_plot <- ggplot() + geom_line(data = inzidenz_hosp_bis59jahre, aes(x = meldewoche, y = ungeimpft, colour = "Ungeimpft")) + 
  geom_line(data = inzidenz_hosp_bis59jahre, aes(x = meldewoche, y = geimpft, colour = "Geimpft")) + xlab("Meldewoche") + ylab("Inzidenz") +
  ggtitle("18 - 59 Jahre") + ylim(0, 15) + labs(color = "Impfstatus")


## Alter 60+ Jahre:

# Gefilterter Datensatz mit besseren Variablennamen:

inzidenz_hosp_ab60jahre <- inzidenz_hosp %>%
  select("Meldewoche", "Ungeimpfte 60+ Jahre", "Vollständig Geimpfte 60+ Jahre")

colnames(inzidenz_hosp_ab60jahre) <- c("meldewoche", "ungeimpft", "geimpft")

# Plot:

inzidenz_hosp_ab60jahre_plot <- ggplot() + geom_line(data = inzidenz_hosp_ab60jahre, aes(x = meldewoche, y = ungeimpft, colour = "Ungeimpft")) + 
  geom_line(data = inzidenz_hosp_bis59jahre, aes(x = meldewoche, y = geimpft, colour = "Geimpft")) + xlab("Meldewoche") + ylab("Inzidenz") +
  ggtitle("60+ Jahre") + ylim(0, 15) + labs(color = "Impfstatus")

## Finaler Plot:

combined_inzidenz_plot <- ggarrange(inzidenz_hosp_bis59jahre_plot, inzidenz_hosp_ab60jahre_plot, common.legend = TRUE)
combined_inzidenz_plot <- annotate_figure(combined_inzidenz_plot, top = text_grob("Inzidenz der hospitalisierten Covid-19 Fälle", size = 16))              

combined_inzidenz_plot

