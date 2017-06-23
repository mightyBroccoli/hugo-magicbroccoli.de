+++
date = "2017-06-22"
title = "TeamSpeak XMPP Push"
sidemenu = "true"
description = "TeamSpeak Script"
tags = [ "XMPP" ]
topics = [ "Development", "bash", "TeamSpeak" ]
+++
## Idee
Die grundsätzliche Idee hinter diesem Skript ist, dass ein Admin/ Moderatoren nicht dauerhaft auf einem Server sein kann, um nach dem Rechten zu sehen.  
Für genau dieses Problem habe ich ein kleines Skript entwickelt, dass nach verschiedenen Regeln die Logfiles cyklisch durchsucht und gefundene Zeilen an definierte Kontakte per XMPP sendet.

## Nutzen
**IMHO** Gibt es genügend Beispiele, in denen eine Benachrichtigung schnellstmöglichst sehr praktisch ist.  
Viele Server unterstützen eine Reihe von "Automatischen Moderationen", trotzdem sollten User nicht in der Lage sein sich Gruppen zuzuweisen. Diese kurze Benachrichtigung sagt dem Admin/ Moderator wer und welche Gruppe betroffen ist.  
Je nach Haufigkeit der Ausführung könnte die Benachrichtigung innerhalb von Sekunden gepushed werden.

```
---- Group change ----
--- added ---
2017-05-12 18:56:38.609377|INFO    |VirtualServer |1  |client (id:USER A) was added to servergroup 'SERVERGROUP NAME'(id:SERVERGROUP ID) by client 'USERNAME'(id:USER B)
2017-05-12 22:09:01.658969|INFO    |VirtualServer |1  |client (id:USER ID) was added to servergroup 'SERVERGROUP NAME'(id:SERVERGROUP ID) by client 'USERNAME'(id:USER ID)
---- Group change End ----
```
## Filter
#### Server
- Accounting
- ServerMain
- Warning
- ERROR

#### User spezifisch
- Complaint
- Kick
- Ban ( added and deleted )
- Group change

#### Channel
- creation
- deletion
- changed

## Bitbucket
Das Projekt ist gehostet [Bitbucket](https://bitbucket.org/mightyBroccoli/logwatch-scripts/src/6551365b8135/teamspeak_scripts/?at=master) dort ist auch ein Bereich für [Issues](https://bitbucket.org/mightyBroccoli/logwatch-scripts/issues?status=new&status=open), falls Probleme auftreten oder Verbesserungsvorschläge bestehen.

## Debian 9
Leider besteht mit Debian Stretch ein Problem mit perl wodurch *sendxmpp*, das xmpp cli Modul des Skripts nicht mehr funktioniert. Leider kann ich da im Moment erst mal nichts machen, aber ich repariere das Skipt für Debian Stretch sobal es möglich ist.
