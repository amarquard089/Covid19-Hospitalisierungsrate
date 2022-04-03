# Variablenausprägungen 

Die Impfdaten enthalten die in der folgenden Tabelle abgebildeten Variablen und deren Ausprägungen:  

| Variable | Typ | Ausprägung | Beschreibung |
| -------- | --- | ---------- | ------------ |
|Impfdatum |Datum | ```JJJJ-MM-TT``` | Datum der Impfungen
| BundeslandId_Impfort | Text | ```01``` bis ```16``` : Bundesland ID<br/> ```17``` : Bundesressorts  | Identifikationsnummer des Bundeslandes basierend auf dem Amtlichen Gemeindeschlüssel (AGS). Impfungen des Bundesressorts werden separat ausgewiesen, da die Impfstellen des Bundes ohne exakte Angabe des Impfortes melden  |
|Impfstoff | Text | ```AstraZeneca```: AstraZeneca <br/> ```Moderna```: Moderna <br/> ```Comirnaty```: BioNTech/Pfizer <br/> ```Janssen```:&nbsp;Janssen&#8209;Cilag/Johnson&nbsp;&&nbsp;Johnson <br/> ```Novavax```: Novavax <br/>| Verabreichter Impfstoff | 
|Impfserie| Natürliche Zahl | ```1```: Erstimpfung <br/> ```2```: Zweitimpfung <br/> ```3```: Auffrischungsimpfung | Angabe zur Erst-, Zweit- oder Auffrischungsimpfung| 
|Anzahl| Natürliche Zahl | ```≥1``` | Anzahl der Impfungen in der Impfgruppe |
