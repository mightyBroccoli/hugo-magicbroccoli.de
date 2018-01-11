+++
type = "post"
date = "2017-12-07T17:30:00+02:00"
title = "Prosody Datenbank Indizes"
author = "nico"
description = ""
keywords = [ "MariaDB", "Prosody", "MySQL" ]
tags = [
	"Prosody",
	"XEP-313",
	"MariaDB",
	"maintenance",
	"Guide"
]
categories = [ "XMPP", "Prosody", "Guide", "MariaDB" ]
banner = "/banner/mariadb.png"
+++
Prosody bietet die Möglichkeit persistente Userdaten bzw. seit [0.10](https://prosody.im/doc/release/0.10.0) auch MAM Archive in einer MySQL Datenbank zu sichern. Prosody erstellt beim ersten Laden des [Moduls](https://hg.prosody.im/0.10/file/e98b4352d7df/plugins/mod_storage_sql.lua#l426) alle relevanten Datenbanken sowie Indizes. Allerdings werden Indizes, die nachträglich, z.B. in [aktuelleren Patches](https://hg.prosody.im/0.10/rev/e98b4352d7df), hinzugefügt werden, nur in Datenbanken eingetragen, die neu erstellt werden. Damit fehlen in den allermeisten älteren Datenbanken die aktuellen Indizes.

#### Notwendigkeit von Indizes
Indizes können Datenbankabfragen enorm beschleunigen, da sie es bei einer Abfrage ermöglichen eine deutlich kleinere Anzahl an Zeilen zu vergleichen. Dadurch wird ein schnelleres, effizienteres und vor allem performanteres Ergebnis erzielt. Die [MySQL Dokumentation](https://dev.mysql.com/doc/refman/5.5/en/mysql-indexes.html) beschreibt es wie folgt:

<blockquote>Indexes are used to find rows with specific column values quickly. Without an index, MySQL must begin with the first row and then read through the entire table to find the relevant rows. The larger the table, the more this costs. If the table has an index for the columns in question, MySQL can quickly determine the position to seek to in the middle of the data file without having to look at all the data. This is much faster than reading every row sequentially.</blockquote>

Für den Betrieb sind die Indizes daher von größerer Wichtigkeit. Bei wachsender Größe der `prosodyarchive` Datenbank werden die Abfragen Performance hungriger. Diese Abfragen möglichst effizient abzuarbeiten ist essentiell.

#### Abfrage bestehender Indizes
Um herauszufinden welche Indizes im Moment überhaupt vorhanden sind, lässt sich dieser Query verwenden.<br>
In diesem Beispiel verwende ich **prosody.prosodyarchive**. Der Query ist für die jeweils persönlichen Namen der Tabellen / Datenbanken anzupassen.

```sql
SHOW INDEX FROM prosody.prosodyarchive;
```
<img src="/images/prosodydb/prosodydb_index.png" width="100%">

Sollten alle Indizes wie auf dem Bild vorhanden sein ist kein weiteres Zutun notwendig. Ist allerdings nur *prosodyarchive_index* gelistet, fehlen die zwei neuen Indizes `prosodyarchive_with` sowie `prosodyarchive_when` in der Datenbank.

### Hinzufügen der fehlenden Indizes
<span style="color:red">_Wichtig_</span> : Je mehr Zeilen die Datenbank enthält desto länger kann das Hinzufügen von Indizes dauern.
Der folgende Abschnitt beschreibt die notwendigen Schritte, um die aktuellen Indizes zur Datenbank hinzuzufügen. Anschließend sind noch Query beschrieben um zu testen, ob das Hinzufügen erfolgreich verlaufen ist.

In diesen Beispiel Querys wird die Datenbank *prosody* mit der Tabelle *prosodyarchive* verwendet. Der Query ist für die jeweils persönlichen Namen der Tabellen / Datenbanken anzupassen.

```sql
CREATE INDEX `prosodyarchive_with` USING BTREE
ON prosody.prosodyarchive
(`host`(20), `user`(20), `store`(20), `with`(20));

---

CREATE INDEX `prosodyarchive_when` USING BTREE
ON prosody.prosodyarchive
(`host`(20), `user`(20), `store`(20), `when`);
```
```sql
Query OK, 0 rows affected (0.30 sec)
Records: 0  Duplicates: 0  Warnings: 0
```
Nach dem Ausführen jedes Querys wird ein solches Ergebnis angezeigt. Dies ist normal, da durch das Hinzufügen von Indizes keine Zeilen verändert werden.

Nachdem beide Querys erfolgreich ausgeführt wurden, kann mit dem `SHOW INDEX FROM db_name` Query kontrolliert werden, ob alle Indizes erfolgreich hinzugefügt wurden.

### Testen der Indizes
Zum Testen der Indizes können diese Querys verwendet werden. Hierbei ist zu beachten das abweichende Bezeichnungen der Tabellen / Datenbanken anzupassen sind.

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
<img src="/images/prosodydb/prosodyarchive_when.png" width="100%">

Relevant bei der Ausgabe sind die Angaben für `possible_keys` und `key`. Diese sollen die neu hinzugefügten Indizes auflisten. Sollten bei einem oder beiden der Spalten `NULL` angezeigt werden, wird kein Index verwendet. Es sollte nochmal kontrolliert werden ob alle Indizes erfolgreich hinzugefügt wurden.<br>
Das Ergebnis sollte diese Form haben. Das Bild zeigt mein Ergebnis für den *prosodyarchive_when* Test-Query.<br>

#### Prosody neustart?
Für Prosody ist es *nicht* notwendig neu zu starten. Die Indizes werden von der Datenbank verwendet und nicht von Prosody direkt. Daher ist es nicht notwendig.

## Quellen
Als Quelle ziehe ich hier die aktuellste stable Version von mod_storage_sql.lua zu Rate. Dieser spezielle Abschnitt ist zuständig beim ersten Laden die Datenbanken, falls noch keine vorhanden sind, zu erstellen.

- [Patch vom 21. November 17](https://hg.prosody.im/0.10/rev/e98b4352d7df)
- [mod_storage_sql.lua](https://hg.prosody.im/0.10/file/e98b4352d7df/plugins/mod_storage_sql.lua#l426)
- [MySQL Dokumentation](https://dev.mysql.com/doc/refman/5.5/en/mysql-indexes.html)
