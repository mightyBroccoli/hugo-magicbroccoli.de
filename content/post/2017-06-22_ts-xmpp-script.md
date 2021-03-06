+++
type = "post"
date = "2017-06-22T14:15:25+02:00"
title = "TeamSpeak XMPP Push"
author = "nico"
description = ""
keywords = [ "XMPP", "Teamspeak", "Push" ]
tags = [
	"mildly useful"
]
categories = [ "Bash", "TeamSpeak", "XMPP" ]
banner = ""
slug = "ts xmpp push"
+++
## Idee
Die Idee hinter diesem Skript ist, dass ein Admin/ Moderatoren nicht dauerhaft mit einem Server verbunden sein kann, um nach dem Rechten zu sehen.<br>
Dieses Problem versuche ich hiermit anzugehen. Dafür durchsucht dieses nach verschiedenen Regeln die Logfiles, gefundene Zeilen werden anschließend an definierte Kontakte per XMPP sendet.

### Nutzen
**IMHO** gibt es genügend Beispiele, in denen eine schnellstmögliche Benachrichtigung sehr praktisch ist. Viele Server unterstützen eine Reihe von "Automatischen Moderationen", dennoch finden User Möglichkeiten diese zu behindern oder sogar zu umgehen. Durch eine kurze Benachrichtigung ist es dem Admin/ Moderator möglich zu überblicken, was betroffen ist und ob sofortiges handeln notwendig ist.<br>
Je nach Häufigkeit der Ausführung können die Benachrichtigung innerhalb von Sekunden gepushed werden.

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
Leider besteht mit Debian Stretch ein Problem mit perl wodurch *sendxmpp*, das xmpp cli Modul des Skripts nicht mehr funktioniert. Leider kann ich da im Moment erst mal nichts machen, aber ich repariere das Skript für Debian Stretch, sobald es möglich ist.

-----
Update : 28.07.2017 Debian 9 Perl5 Problematik
{{< highlight bash >}}
Use of uninitialized value in numeric eq (==) at /usr/share/perl5/XML/Stream.pm line 631.
{{< /highlight >}}
Ich hab mit etwas debugging herausgefunden, welche Zeilen geändert werden müssen, um perl-xmlstream wieder zu fixxen.
Die Datei `/usr/share/perl5/XML/Stream.pm` müsste geändert werden. (Pfad kann abweichen je nach OS)
Mit nano lässt sich bequem nach der Zeile suchen, mit Shift + W. Danach ändert man Zeile 631.
{{< highlight perl >}}
$self->{SIDS}->{default}->{ssl_ca_path} = '';
{{< /highlight >}}
zu
{{< highlight perl >}}
$self->{SIDS}->{default}->{ssl_ca_path} = '/etc/ssl/certs';
{{< /highlight >}}
Nach dieser Änderung hat sich das Problem eingestellt und sendxmpp funktionierte wieder genauso tadellos wie zuvor.
