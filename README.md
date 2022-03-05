# Covid19-Hospitalisierungsrate
Statistisches Praktikum. Thema: Covid 19 - Vorhersage der Hospitalisierungsrate

## Nützliche Links

- [Cheatsheets](https://rstudio.com/resources/cheatsheets/)
- [Slideshow grammar_of_graphics](https://pkg.garrickadenbuie.com/gentle-ggplot2/#70)
- [Colorbrewser](https://colorbrewer2.org/)
  - [Doku zur Nutzung](https://rstudio-pubs-static.s3.amazonaws.com/177286_826aed2f00794640b301aeb42533c6f1.html)
- [ggplot Colors and Fills](http://sape.inf.usi.ch/quick-reference/ggplot2/colour)
- Und hoffentlich mehr :grimacing:

## Wichtig: Lesen

- [Covid19Trends-RKI](https://www.rki.de/DE/Content/InfAZ/N/Neuartiges_Coronavirus/Situationsberichte/COVID-19-Trends/COVID-19-Trends.html?__blob=publicationFile#/home)
- [RKI-Github](https://github.com/orgs/robert-koch-institut/repositories)


## How to

Bitte nur data_processed für Auswertungen nutzen. Hier werden finale Datensätze 
bereitsgestellt.
Einlesen des finalen Datensatzes über `readRDS(...)` 

Bitte ebenfalls sicherstellen, das im richtigen working directory gearbeitet
wird.
Hierzu die entsprechenden Readmes in den Ordnern lesen.


## Ordnerhierarchie

- ### Data_truth
  
  - Beinhaltet unveränderte Daten und Parser um entsprechende Daten zu erhalten
  
- ### Data_processed
  
  - Beinhaltet Änderungen an den Daten (z.B. erstellen eines neues Datensatzes @Qian)
  
  - ### (Unterordner) models
  
  - Beinhaltet verschiedene Modelle basierend auf den processed Daten
  
- ### data_analysis
  
  - Beinhaltet ausschließlich analysen (deskriptiv)
  
  - ### (Unterordner) Bilder
    
    - Ort zum Abspeichern der Bilder aus Daten Analysen
  
- ### documentation
  
  - Beinhaltet Dokumentation

- ### Praesentation

  - Powerpoint, PDF
  
- ### Abgabe

  - Order für die Abgabe. Alle relevanten Dateien sollten hier rein

## Grafiken

  - Grafiken werden separat gespeichert

    Dafür kann in R folgender Befehl genutzt werden:

    ```R
    jpeg(file="saving_plot1.jpeg")
    hist(HISTOGRAMM, col="darkgreen")
    dev.off() 
    ```

    bzw.

    ```R
    png(file="path_for_saving_plot2.png",width=600, height=350)
    hist(Temperature, col="gold")
    dev.off()
    ```
    
