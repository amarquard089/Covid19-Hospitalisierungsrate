# Covid19-Hospitalisierungsrate
Statistisches Praktikum. Thema: Covid 19 - Vorhersage der Hospitalisierungsrate

## Nützliche Links

- [Cheatsheets](https://rstudio.com/resources/cheatsheets/)
- [Slideshow grammar_of_graphics](https://pkg.garrickadenbuie.com/gentle-ggplot2/#70)
- [Colorbrewser](https://colorbrewer2.org/)
  - [Doku zur Nutzung](https://rstudio-pubs-static.s3.amazonaws.com/177286_826aed2f00794640b301aeb42533c6f1.html)
- Und hoffentlich mehr :grimacing:

## Wichtig: Lesen

- [Covid19Trends-RKI](https://www.rki.de/DE/Content/InfAZ/N/Neuartiges_Coronavirus/Situationsberichte/COVID-19-Trends/COVID-19-Trends.html?__blob=publicationFile#/home)
- [RKI-Github](https://github.com/orgs/robert-koch-institut/repositories)

## Arbeit mit Github

1. Open R Studio
2. Click on File
3. Click on New Project...
4. Click on Version Control
5. Goto Github and open this Repo
6. Click on Code (green Button)
7. Copy HTTPS Url
8. Paste it into Repository in your RStudio window, that should still show which repository you would like to clone
9. Click Save (or Next)
10. Done

## Ordnerhierarchie

- ### Daten

  - Frageboge, Codebuch und Regionskürzel. Die .Rds wird **IMMER** von github ignoriert und nicht hochgeladen (Verschwiegenheit)

- ### Präsentation

  - Powerpoint, PDF, Auswertung (erst ganz zum Schluss)

- ### Auswertungen

  - Auswertungen betrefflich unseres Themas. Nach Themen geordnet

- ### Grafiken

  - Alle Grafiken (Grafiken sollten separat gespeichert werden)

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

- ### Abgabe

  - Order für die Abgabe. Alle relevanten Dateien sollten hier rein

## Einteilung

Alex
bis 04.11 Spalten beschreiben

Phu, Qian, Johannes, Alex
- bis 05.11 Fragen klären und aufschreiben
- Sich mit dem Thema auseinandersetzen
- 

## Todo

Bis zum 13.12:
- Deskriptive Datenauswertung
- Korrelation zwischen Kovariablen
- Können Variablen ausgeschlossen werden, die kein Korrelation mit der Zielvariable (Hosp.Rate) aufweisen 
  - Vorbereitungen für Modell

- Spalten beschreiben
- Daten aufräumen



