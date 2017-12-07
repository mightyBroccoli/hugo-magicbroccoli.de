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
Prosody bietet die Möglichkeit persistente User Daten bzw. seit 0.10 MAM Daten in einer MySQL Datenbank zu sichern. Indizes in solchen Datenbanken, können Prozesse enorm beschleunigen. Bei Prosody werden diese, bei der ersten Installation Prosodys eingefügt.<br>
Allerdings werden Indizes, die nachträglich, z.B. in aktuelleren Patches, hinzugefügt werden, nur in Datenbanken eingetragen die neu erstellt werden.<br>
Damit haben ältere Datenbanken einen enormen Nachteil da aktuelle Indizes fehlen.

#### Welche Indexe hat meine Datenbank überhaupt?
Diese Frage lässt sich leicht mit einem bzw. zwei Querys beantworten.<br>
Hierbei ist natürlich **db_name** durch die Datenbanknamen zu ersetzen.

```sql
SHOW INDEX FROM db_name
```
<img src="/images/prosodydb/prosodydb_index.png" width="100%">

Sollte in der angezeigten Liste nur *prosodyarchive_index* enthalten sein, fehlen die zwei neuen Indizes `prosodyarchive_with` sowie `prosodyarchive_when` in der Datenbank.

### Hinzufügen der neuen Indexe
Meine Archiv Datenbank beinhaltet knapp 70000 Zeilen, bei mir hat das hinzufügen knapp 10 Minuten gedauert. Daher ist das schnelle hinzufügen bei größeren Installationen mit Vorsicht zu genießen.<br>

_Wichtig_ : Je größer die Datenbank ist desto länger kann das hinzufügen von Indizes dauern.

In diesen Beispiel Querys verwende ich die Datenbank *prosody* mit der Tabelle *prosodyarchive*. Der Query ist für die persönliche Konfiguration anzupassen.

```sql
CREATE INDEX `prosodyarchive_with` USING BTREE
ON prosody.prosodyarchive
(`host`(20), `user`(20), `store`(20), `with`(20));

---

CREATE INDEX `prosodyarchive_when` USING BTREE
ON prosody.prosodyarchive
(`host`(20), `user`(20), `store`(20), `when`);
```

Nachdem diese beiden Querys erfolgreich durchlaufen wurden, kann mit dem `SHOW INDEX` Query erneut kontrolliert werden, ob beide Indizes erfolgreich erstellt wurden.

### Testen der Indizes
Zum testen der Indizes können diese Querys verwendet werden. Hierbei ist ebenfalls zu beachten das abweichende Bezeichungen der Tabellen / Datenbanken anzupassen sind.

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

Relevant bei der Ausgabe sind die Ausgaben bei `possible_keys` und `key`. Sollten diese beiden bei einem der Querys `NULL` zeigen wird kein Index verwendet. Das Ergebnis sollte eine solche Form haben. Als Beispiel für den *prosodyarchive_when* Query ist hier mein Ergebnis.<br>

<img src="/images/prosodydb/prosodyarchive_when.png" width="100%">

## Quellen
Als Quelle ziehe ich hier die aktuellste stable Version von mod_storage_sql.lua. Dieser spezielle Abschnitt erstellt beim ersten laden die Datenbanken falls noch keine vorhanden sind, mit den ebenfalls aufgelisteten Indizes.

- [mod_storage_sql.lua](https://hg.prosody.im/0.10/file/e98b4352d7df/plugins/mod_storage_sql.lua#l426)
