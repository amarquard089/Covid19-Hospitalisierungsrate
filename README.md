# Covid19-Hospitalisierungsrate
Ludwig Maximilian Universität München </br>
Institut für Statistik </br>
*Covid 19 - Vorhersage der Hospitalisierungsrate* </br>
Statistisches Praktikum </br>
</br>
Autoren: Alexander Marquard, Qian Feng, Phu Nguyen

# Dokumentation

## Ordner-Struktur

- data_processed
  - beinhaltet sämtliche Transformationen an den wahren Datensätzen, in den
  entsprechenden Datensätzen
  - beinhaltet das Rmd um die entsprechenden Datensätze zu erhalten
  - beinhaltet das Rmd zur modellierung
  - beinhaltet ein Rmd zur explorativen datenanalyse
  - Bilder, welche im abschließedenen Bericht verwendet wurden
  - Readme mit Informationen zu den Datensätzen
  
- data_truth
  - beinhaltet R und Python-Skripte um Daten zu erhalten
  - beinhaltet die wahren Datensätze in den entsprechenden Ordnern
  - zusätzlich R-Skript für zusätzliche Daten
  
- Praesentation
  - beinhaltet die Präsentation zum Stand am Tage der Präsentation


## Anwendung

In data_truth sind die entsprechenden R-Files um die wahren Datensätze zu 
erhalten. Das Python-Skript muss nicht separat ausgeführt werden.

In data_processed können die einzelnen RMD´s entsprechend ausgeführt werden
um die Ergebnisse mit den Daten zum Abgabestand: 13.04.2022 zu reproduzieren.

In modell.Rmd werden Filter entsprechend gesetzt, um neuer Ergebnisse zu erhalten
müssen diese in den einzelnen Chunks angepasst werden.

Bilder im Ordner Bilder werden bei Ausführung der RMD´s aktualisiert.
    
