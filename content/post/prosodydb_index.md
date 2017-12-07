+++
type = "post"
date = "2017-12-07T17:30:00+02:00"
title = "Prosody Datenbank Indizes"
author = "nico"
description = ""
keywords = [ "MariaDB", "Prosody", "MySQL" ]
tags = [ "Prosody", "mod_mam", "MariaDB", "maintenance", "Guide" ]
categories = [ "MariaDB", "Prosody" ]
banner = "/banner/mariadb.png"
+++
Prosody bietet die Möglichkeit persistente Userdaten bzw. seit [0.10](https://prosody.im/doc/release/0.10.0) MAM Daten in einer MySQL Datenbank zu sichern. Indizes in solchen Datenbanken, können Prozesse enorm beschleunigen. Bei Prosody werden diese, bei der [ersten Installation Prosodys](https://hg.prosody.im/0.10/file/e98b4352d7df/plugins/mod_storage_sql.lua#l426) eingefügt.<br>
Allerdings werden Indizes, die nachträglich, z.B. in aktuelleren Patches, hinzugefügt werden, nur in Datenbanken eingetragen die neu erstellt werden.<br>
Damit haben ältere Datenbanken einen enormen Nachteil da aktuelle Indizes fehlen.

#### Welche Indizes stehen aktuell zur Verfügung?
Um herauszufinden welche Indizes im Moment überhaupt vorhanden sind, lässt sich dieser Query verwenden.<br>
Hierbei ist natürlich **db_name** durch die zu testenden Datenbanknamen zu ersetzen.

```sql
SHOW INDEX FROM db_name
```
Sollte in der angezeigten Liste nur *prosodyarchive_index* enthalten sein, fehlen die zwei neuen Indizes `prosodyarchive_with` sowie `prosodyarchive_when` in der Datenbank. Sollten alle Indizes wie auf dem Bild vorhanden sein ist kein weiteres Zutun notwendig.

<img src="/images/prosodydb/prosodydb_index.png" width="100%">

### Hinzufügen der Indizes
<span style="color:red">_Wichtig_</span> : Je größer die Datenbank ist desto länger kann das hinzufügen von Indizes dauern. Auch die Rechenleistung der Datenbank Maschine stellt einen wichtigen Faktor für die Geschwindigkeit der Befehle dar.

In diesen Beispiel Querys verwende ich die Datenbank *prosody* mit der Tabelle *prosodyarchive*. Der Query ist für die jeweils persönlichen Namen der Tabellen / Datenbanken anzupassen.

```sql
CREATE INDEX `prosodyarchive_with` USING BTREE
ON prosody.prosodyarchive
(`host`(20), `user`(20), `store`(20), `with`(20));

---

CREATE INDEX `prosodyarchive_when` USING BTREE
ON prosody.prosodyarchive
(`host`(20), `user`(20), `store`(20), `when`);
```

Nachdem beide Querys erfolgreich ausgeführt wurden, kann mit dem `SHOW INDEX FROM db_name` Query erneut kontrolliert werden, ob alle Indizes erfolgreich hinzugefügt wurden. Für die Funktionalität von Prosody ist es nicht notwendig diesen neuzustarten. Die Indizes werden verwendet sobald sie erfolgreich hinzugefügt wurde.

### Testen der Indizes
Zum Testen der Indizes können diese Querys verwendet werden. Hierbei ist ebenfalls zu beachten das abweichende Bezeichnungen der Tabellen / Datenbanken anzupassen sind.

```sql
EXPLAIN SELECT * FROM prosody.prosodyarchive
WHERE `host` = 'magicbroccoli.de' AND
`store` = 'archive2' AND `when` > '1512662458'
AND `user` = 'username';

---

EXPLAIN SELECT * FROM prosody.prosodyarchive
WHERE `host` = 'magicbroccoli.de' AND
`store` = 'archive2' AND `with` > 'brokkoli@magicbroccoli.de'
AND `user` = 'username';
```

Relevant bei der Ausgabe sind die Ausgaben bei `possible_keys` und `key`. Diese sollen jeweils die neu hinzugefügten Indizes listen, sollten bei einem oder beiden der Querys `NULL` angezeigt werden wird kein Index verwendet.<br>
Das Ergebnis sollte diese Form haben. Das Bild zeigt mein Ergebnis für den *prosodyarchive_when* Test-Query.<br>

<img src="/images/prosodydb/prosodyarchive_when.png" width="100%">

## Quellen
Als Quelle ziehe ich hier die aktuellste stable Version von mod_storage_sql.lua zu Rate. Dieser spezielle Abschnitt ist zuständig beim ersten Laden die Datenbanken, falls noch keine vorhanden sind, zu erstellen.

- [mod_storage_sql.lua](https://hg.prosody.im/0.10/file/e98b4352d7df/plugins/mod_storage_sql.lua#l426)
