+++
date = "2017-08-25T23:30:00+02:00"
title = "Datenbank Zusammenbruch"
linktitel = "db_failure"
sidemenu = "true"
tags = [ "MariaDB" ]
topics = [ "MariaDB" ]
description = "Database Failure"
+++
## Bekanntmachung

Heute, am 25 August, kam es zu dem bisher größten Ausfall meiner Services. Leider ist aufgrund eines Fehler, der mir bisher nicht weiter bekannt ist, eine Platte des Server ausgefallen. Die Datenbank hat das ganze nicht sonderlich gut aufgenommen.

Ich fahre regelmäßig Backups und die binlogs waren auch wiederherstellbar, daher kam es zu *keinem* Datenverlust. Allerdings musste ich die Datenbank neu aufbauen, was sich als zeitintensiv herausstellte.

Gegen 23:30, nach fast 5 Stunden, ist es mir nun gelungen alle Datenbanken wiederherzustellen und alle Services vollständig wieder in Betrieb zu nehmen.
