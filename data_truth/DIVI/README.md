## date:
# Min-date: 24.04.2020 Max-date: 02.11.2020, each observation equals one day

## bundesland:
# bundesland with the following coding:
# 01 Schleswig-Holstein
# 02 Freie und Hansestadt Hamburg
# 03 Niedersachsen
# 04 Freie Hansestadt Bremen
# 05 Nordrhein-Westfalen
# 06 Hessen
# 07 Rheinland-Pfalz
# 08 Baden-Württemberg
# 09 Freistaat Bayern
# 10 Saarland
# 11 Berlin
# 12 Brandenburg
# 13 Mecklenburg-Vorpommern
# 14 Freistaat Sachsen
# 15 Sachsen-Anhalt
# 16 Freistaat Thüringen


## gemeindeschluessel: Siehe PDF (u.U. keine Relevanz)

## anzahl_standorte:
# Die Anzahl der Standorte gibt an, wie viele Standorte des jeweiligen
# Landkreises eine Meldung abgegeben haben und in den aktuellen Datenstand
# einfließen.

# Was ist ein (Krankenhaus-)Standort?
#
# Jedes Krankenhaus kann einen oder mehrere Krankenhaus-Standorte haben.
# Die Standorte zugelassener deutscher Krankenhäuser sind im InEK-
# Standort-Verzeichnis (https://krankenhausstandorte.de/info) mit eindeutiger
# Standort-ID registriert.
# Diese Liste enthält keine Information darüber,
# ob ein Standort intensivmedizinische Betten besitzt oder nicht.


## anzahl_meldebereiche:
# Ein Meldebereich entspricht einer Intensivstation oder einem Intensivbereich, für welchen das dort
# arbeitende fachmedizinische Personal Meldungen im DIVI-Intensivregister (täglich) abgibt.
#
# Was ist ein Meldebereich?
# Ein Meldebereich ist ein von dem meldenden Arzt/Ärztin definierter Bereich für
# den eine bestimmte Anzahl von Intensivbetten zur Akutbehandlung
# (und nur Intensivbetten) in einem Krankenhaus-Standort gemeldet werden.


## faelle_covid_aktuell
# Anzahl aller aktuell in intensivmedizinischer Behandlung (beatmet und nicht beatmet)
# befindlichen COVID-19-Patient*innen (Erwachsene und Kinder) in den definierten
# ICU-Versorgungsstufen (low-high und ecmo). Dabei nur nachgewiesene Infektionen mit SARS-CoV-2 und
# keine reinen Verdachtsfälle.


## faelle_covid_aktuell_invasiv_beatmet
# Anzahl aktuell beatmeter COVID-19-Patient*innen (Erwachsene und Kinder) in
# intensivmedizinischer Behandlung, bezogen nur auf invasive Beatmung und ECMO.
#
# Hinweis: Diese Angabe bezieht sich auf COVID-19-Intensivpatient*innen mit
# invasiver Beatmung. Das bedeutet nicht, dass die anderen
# COVID-19-Intensivpatient*innen nicht beatmet werden. Evtl. erfolgt
# dort eine nicht-invasive Beatmung (z.B. über Sauerstoffmaske).


## betten_frei
# Anzahl der freien, betreibbaren Intensivbetten (Low- und High-Care)
# für Erwachsene und Kinder zur
# Behandlung von allen intensivpflichtigen Erkrankungen.


## betten_belegt
# Anzahl der belegten Intensivbetten (Low- und High-Care), unabhängig von der
# Behandlungsursache, für
# Erwachsene und Kinder


## betten_belegt_nur_erwachsen
# Anzahl der belegten Intensivbetten (Low- und High-Care), unabhängig von der
# Behandlungsursache, NUR
# für Erwachsene


## betten_frei_nur_erwachsen
# Anzahl der freien, betreibbaren Intensivbetten (Low- und High-Care) NUR für
# Erwachsene zur
# Behandlung von allen intensivpflichtigen Erkrankungen.

# **was bedeutet Low- und High-Care:
# Intensivbetten ohne invasive Beatmungsmöglichkeit (ICU low care),
# Intensivbetten mit invasiver Beatmungsmöglichkeit (ICU high care)