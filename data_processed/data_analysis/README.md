## How to

- Bitte workingdirectory entsprechend setzen, wenn mit R-Files gearbeitet wird.
    Zu beginn des files:
    ```R
    ## Set path and workingdir
    # Expected to be run from within project
    path <- getwd()
    setwd(paste(getwd(), 'data_analysis/', sep = "/"))
    ```
    Am Ende des files
    ```R
    # reset workingdir
    setwd(path)
    ```
    
    RMarkdown files setzten selbstständig das richte workingdirectory
    
- Entsprechende Rds-files einlesen
    als ersten Chunk, bzw als erste Kommandos in R-Files 
    entsprechend Files einlesen, die analysiert werden sollen
    
    Bsp:
    ```R
    infektionen <- readRDS('../data_truth/RKI/infektionen.Rds')
    # bzw
    final_df <- readRDS('../data_processed/final_df.Rds')
    ´´´
    
- Analysen entsprechend durchführen

- Werden weitere Daten benötigt dann werden die Daten zunächst in data_truth eingelesen
  um eine einheitliche Code-Basis zu gewährleisten.
  
  Sollte Hilfe dabei gebraucht werden einfach mir schreiben 
  
- Bilder werden im Unterordner *Bilder* gespeichert.
  Das Vorgehen hierbei ist analog, d.h
  
  ```R
  png(file="./Bilder/hist_temperatur",width=600, height=350)
  hist(Temperature, col="gold")
  dev.off()
  ```


  
  



