+++
type = "post"
date = "2017-06-22T14:15:25+02:00"
title = "TeamSpeak XMPP Push"
author = "nico"
description = ""
keywords = [ "TeamSpeak Script" ]
tags = [ "XMPP" ]
categories = [ "Development", "Bash", "TeamSpeak", "XMPP" ]
banner = ""
+++
## Idee
Die grundsätzliche Idee hinter diesem Skript ist, dass ein Admin/ Moderatoren nicht dauerhaft auf einem Server sein kann, um nach dem Rechten zu sehen.<br>
Für genau dieses Problem habe ich ein kleines Skript entwickelt, dass nach verschiedenen Regeln die Logfiles cyklisch durchsucht und gefundene Zeilen an definierte Kontakte per XMPP sendet.

## Nutzen
**IMHO** gibt es genügend Beispiele, in denen eine schnellstmögliche Benachrichtigung schnellstmöglichst sehr praktisch ist.
Viele Server unterstützen eine Reihe von "Automatischen Moderationen", trotzdem sollten User nicht in der Lage sein sich Gruppen zuzuweisen. Diese kurze Benachrichtigung sagt dem Admin/ Moderator, wer und welche Gruppe betroffen ist.<br>
Je nach Häufigkeit der Ausführung könnte die Benachrichtigung innerhalb von Sekunden gepushed werden.

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

## Github
Das Projekt ist gehostet auf [Github](https://github.com/mightyBroccoli/logwatch-scripts). Dort ist auch ein Bereich für [Github - Issues](https://github.com/mightyBroccoli/logwatch-scripts/issues), falls Probleme auftreten oder Verbesserungsvorschläge bestehen.

## Debian 9
Leider besteht mit Debian Stretch ein Problem mit perl wodurch *sendxmpp*, das xmpp cli Modul des Skripts nicht mehr funktioniert. Leider kann ich da im Moment erst mal nichts machen, aber ich repariere das Skipt für Debian Stretch, sobald es möglich ist.

-----

Update : 28.07.2017 Debian 9 Perl5 Problematik
```
Use of uninitialized value in numeric eq (==) at /usr/share/perl5/XML/Stream.pm line 631.
```
Ich hab mit etwas debugging herausgefunden, welche Zeilen geändert werden müssen, um perl-xmlstream wieder zu fixxen.
Die Datei `/usr/share/perl5/XML/Stream.pm` müsste geändert werden. (Pfad kann abweichen je nach OS)
Mit nano lässt sich bequem nach der Zeile suchen, mit Shift + W. Danach ändert man Zeile 631.
```
$self->{SIDS}->{default}->{ssl_ca_path} = '';
```
zu
```
$self->{SIDS}->{default}->{ssl_ca_path} = '/etc/ssl/certs';
```
Nach dieser Änderung hat sich das Problem eingestellt und sendxmpp funktionierte wieder genauso tadellos wie zuvor.
