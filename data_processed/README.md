## How to

- @Qian Datensatz wenn fertig abspeichern mit
  ```R
  saveRds(final_df ,'final_df.Rds')
  ```
  
  Der Datensatz wird dann hier im Ordner *data_processed* gespeichert und
  gilt für alle als Basis.
  
- Im Unterordner *Models* werden Modelle durchgeführt und ausprobiert.
  Wenn Modelle ausprobiert werden bitte spezifisch bei der Namensgebung sein
  und ruhig rum testen.
  
  Bsp:
  - alex_schmierblatt.R
  - alex_LM.R
  - alex_GAM.R
  
- Ziel ist es am Ende eine Wahl von Modellen zu haben aus der wir das beste 
  auswählen können
  