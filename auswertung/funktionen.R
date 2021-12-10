## Funktionen ####

# Für die leichtere Handhabe mit den Daten

# dateColumns are expected to be of type date. Only one date type column per dataset
# provide dfnames as vector: c('nowcast_lmu', 'nowcast_rki')
# Input: ... = Dataframes, so viele wie gewünscht,
#       dfnames als Vektor
# Beispiel:
# compareDatesAndCleanup(nowcast_rki, nowcast_lmu, 
#                        dfnames = c('nowcast_rki', 'nowcast_lmu'))
#
# Kein output -> Datensätze werden direkt verändert

compareDatesAndCleanup <- function(..., dfnames) {
  listOfDFs <-  list(...)
  listOfDFs <- lapply(listOfDFs, as.data.frame)
  dateCols <- which.isDate(...)
  dateColsAsList <- Map(list, dateCols, listOfDFs)
  maxDate <- character(0)
  minDate <- character(0)
  for (i in dateColsAsList) {
    colname <- i[[1]]
    df <- i[[2]]
    maxDate <- append(maxDate, df[which.max(df[, colname]), colname])
    minDate <- append(minDate, df[which.min(df[, colname]), colname])
  }
  j <- 1
  for (i in dateColsAsList) {
    colname <- i[[1]]
    df <- i[[2]]
    lowestMaxDate <- maxDate[which.min(maxDate)]
    highestMinDate <- minDate[which.max(minDate)]
    rowsToDeleteMax <- which(df[, colname] > lowestMaxDate)
    rowsToDeleteMin <- which(df[, colname] < highestMinDate)
    if (length(rowsToDeleteMax) > 0) {
      df <- df[-rowsToDeleteMax, ]  
    }
    if (length(rowsToDeleteMin) > 0) {
      df <- df[-rowsToDeleteMin, ]  
    }
    assign(dfnames[[j]], df, .GlobalEnv)
    j <- j + 1
  }
}

# Ergänze Jahreszeiten entsprechend der Monate/Kalenderwochen
# input: df: dataframe/tibble 
#       date.col.as.string: datum spalte als String
#       useWeeks: optional
#       sep = seperator für tagesdaten (-.,|)
# output:
#   vektor der einfach mit df$Seasons <- add.Seasons(...) angehängt werden kann
# beispiel:
#  add.Seasons(divi_tagesreport, 'date', useWeeks = FALSE, sep = '-') 
#  add.Seasons(inzidenz_hospitalisiert, 'Meldewoche', useWeeks = TRUE)
#  add.Seasons(someSampleDfWithDotNotationInTheDateColumn, 'date', sep = '.')

add.Seasons <- function(df, date.col.as.string, useWeeks = FALSE, sep = '-') {
  df <- as.data.frame(df)
  if (!useWeeks) {
    season.list <- lapply(df[, date.col.as.string], function(x) {
      month <- str_split(x, sep)[[1]][[2]]
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
    }
    )
  }
  else if (useWeeks) {
    season.list <- lapply(df[, date.col.as.string], function(x) {
      switch(as.character(ceiling(x/4.345)), 
             '1' = 'Winter',
             '2' = 'Winter',
             '3' = 'Spring',
             '4' = 'Spring',
             '5' = 'Spring',
             '6' = 'Summer',
             '7' = 'Summer',
             '8' = 'Summer',
             '9' = 'Autumn',
             '10' = 'Autumn',
             '11' = 'Autumn',
             '12' = 'Winter',
             '13' = 'Winter' #in case of 53 weeks
      )
    }
    )
  }
  return(unlist(season.list))
}


## Helperfunktionen ####

# Helperfunktionen, werden vrstl nicht einzeln gebraucht, sondern nur in Funktionen
# der Übersichtlichkeit halber verwendet.

which.isDate <- function(...) {
  listOfDFs <-  list(...)
  dateCols <- lapply(lapply(listOfDFs, isDate), which)
  return(names(unlist(dateCols)))
}

isDate <- function(df) {
  return(sapply(df, function(x) inherits(x, 'Date')))
} 
