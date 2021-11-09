##### Auswertung
# Autor: Alex
# Projekt: Covid 19 - Vorhersage der Hospitalisierungsrate

divi_tagesreport <- readRDS('./daten/divi_tagesreport')
head(divi_tagesreport)

str(divi_tagesreport)
summary(divi_tagesreport)

summary(Klinische_Aspekte$`Fälle gesamt`)

Nowcasting <- read.csv("Nowcasting.csv")
head(Nowcasting)

results_hosp_2021_11_04 <- read.csv("results_hosp_2021-11-04.csv")
head(results_hosp_2021_11_04)

results_hosp_2021_11_04 <- results_hosp_2021_11_04[, c(1, 2, 3)]

results_hosp_2021_11_04 <- results_hosp_2021_11_04[results_hosp_2021_11_04$age60 != 'alle', ]

head(results_hosp_2021_11_04)

results_hosp_new <- results_hosp_2021_11_04 %>% group_by(date) %>% 
  mutate(total = reported + lead(reported)) %>%
  select(date, total)

results_hosp_new <- results_hosp_new[!is.na(results_hosp_new$total),]
names(results_hosp_new) <- c('Datum', 'Total')

merged_df <- inner_join(Nowcasting, results_hosp_new, by = 'Datum')

library(tidyverse)

ggplot(merged_df) + aes(x = as.Date(Datum), y = PS_COVID_Faelle) + geom_line(col = 'red') +
  geom_line(aes(y = PS_COVID_Faelle_ma4), col = 'blue') +
  geom_line(aes(y = Total), col = 'yellow') +
  scale_y_log10()

lm(Total ~ PS_COVID_Faelle, data = merged_df)

# add times

summary(as.Date(merged_df$Datum))

# input
# df: dataframe. expected to has a least one column: date in the format YYYY-MM-DD
# date.col.as.string: name of col
add.Seasons <- function(df, date.col.as.string) {
  index <- 0
  season.list <- lapply(df[, date.col.as.string], function(x) {
    index <<- index + 1
    month <- str_split(x, '-')[[1]][[2]]
    switch (month,
            '01' = 'Winter',
            '02' = 'Winter',
            '03' = 'Spring',
            '04' = 'Spring',
            '05' = 'Spring',
            '06' = 'Summer',
            '07' = 'Summer',
            '08' = 'Summer',
            '09' = 'Autumn',
            '10' = 'Autumn',
            '11' = 'Autumn',
            '12' = 'Winter'
            
    )
  })
  return(unlist(season.list))
}


merged_df$Season <- add.Seasons(merged_df, 'Datum')
merged_df$Season <- as.factor(merged_df$Season)

lin.mod <- lm(Total ~ PS_COVID_Faelle + Season, data = merged_df)

predicted_df <- data.frame(total_pred = predict(lin.mod, merged_df), Total=merged_df$Total, Datum = merged_df$Datum)

# this is the predicted line of multiple linear regression
ggplot(data = df, aes(x = mpg, y = hp)) + 
  geom_point(color='blue') +
  geom_line(color='red',data = predicted_df, aes(x=mpg_pred, y=hp))

ggplot(predicted_df) + aes(x = as.Date(Datum), y = total_pred) +
  geom_line() +
  geom_point(aes(y = Total))

# add mean age

head(merged_df)

merged_df_with_age <- left_join(merged_df)

