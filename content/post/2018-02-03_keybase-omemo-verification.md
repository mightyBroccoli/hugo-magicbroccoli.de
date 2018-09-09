+++
type = "post"
date = "2018-02-03T15:00:00+02:00"
title = "Omemo Verification mit Keybase.io"
author = "nico"
description = ""
keywords = [ "Omemo", "xep-0384", "keybase.io", "verification" ]
tags = [
	"omemo",
	"xep-0384",
	"keybase.io"
]
categories = [ "XMPP" ]
banner = "/banner/keybase-logo.png"
slug = "Keybase Omemo verify"
+++
## Omemo Key Verification
Um eine möglichst reibungslose Kommunikation zu ermöglichen, vertraut Conversations in der Standardeinstellung neuen OMEMO-Keys zuerst blind. Wenn aber eine spezifische Verifikation - über das Scannen eines QR-Codes - stattgefunden hat, werden neue Keys grundsätzlich misstraut. Dies bietet einen weitere Möglichkeit um Man-In-The-Middle-Angriffe zu unterbinden. Dieses Vertrauensmodell heißt [Blind Trust Before Verification](https://gultsch.de/trust.html). Ohne Verifizierung ist eine explizit vertrauliche Kommunikation nur eingeschränkt möglich.

> After such a verification happened Conversations will no longer blindly trust new devices that are created after the verification. By doing verification the user has proven three things a) they are capable of scanning barcodes b) they have some sort of out-of-band channel where such a verification can happen c) they have some interest in verified communication.

Aber wie kann man die eigenen Keys an andere verteilen, ohne zu großen Aufwand und das möglichst sicher? Die Lösung: Keybase.io

### Keybase.io
[Keybase.io](https://keybase.io) ermöglicht es Accounts auf anderen Plattformen bzw. PGP Keys gegeneinander zu verifizieren. Auch ist es möglich mit dem persönlichen PGP Key signierte Dateien abzulegen. Dadurch ist eine vertrauenswürdige Verifikation der zugehörigen Keys möglich.
Dies ist nur ein sehr kleiner Bruchteil der Funktionalität von Keybase.io. Für ein deutlich ausführlicheres Bild kann ich [secitem.eu](https://secitem.eu/blog/keybase-basics/) empfehlen. In dem Beitrag werden die basics zu Keybase ausführlich erklärt.

### Conversations
Für Conversations gibt es die Möglichkeit jeden Key einzeln zu verifizieren oder mit nur einem QR-Code alle Keys gleichzeitig. Um den Aufwand möglichst gering zu halten, bietet Conversations die Möglichkeit einen solchen QR-Code direkt zu erstellen. Damit in diesem QR-Code alle eigenen Keys enthalten sind ist es notwendig, dass die eigenen Omemo Keys alle angenommen und verifiziert sind. Ist dies der Fall, ist es möglich mit Conversations einen einzelnen QR-Code zu erstellen der alle eigenen verifizierten Keys enthält.<br>
Da nicht alle Clients im Moment ein direktes Verifizieren unterstützen (eg. Gajim, Pidgin), ist zusätzlich dazu noch ein Textdokument hinterlegt in dem die Fingerprints aufgelistet sind. Mit diesem Textdokument ist ein manueller Abgleich möglich.

### Struktur
Um eine möglichst einheitliche bzw. übersichtliche Struktur zu schaffen, habe ich die Ordner Struktur wie dargestellt gewählt. Das Namensschema ist ziemlich eindeutig aber prinzipiell auch egal, da nur ein Bild und eine einzelne Textdatei verwendet werden, die anhand der Dateiendung unterscheidbar sind.

{{< highlight bash >}}
omemo-verification
    ├── broccoli@magicbroccoli.de_omemo-verification-fingerprints.txt
    └── broccoli@magicbroccoli.de_omemo-verification.jpg
{{< /highlight >}}

### Ergebnis
Ich habe für meine eigenen Schlüssel nach diesem Verfahren einen QR-Code sowie ein Textdokument zur Verifizierung veröffentlicht. Diese öffentliche Dateien können per Link an Kontakte verteilt werden, damit sie die Verifizierung durchführen können. Um selbst darauf zuzugreifen - etwa um sie aktuell zu halten - gibt es unterschiedliche Methoden.<br>

- Ist der [Keybase.io Client](https://keybase.io/download) installiert kann mit `cd /keybase/public/mightybroccoli/omemo-verification/`, oder dem für das System entsprechende Befehl zum Öffnen eines Ordners, auf den öffentlichen Ordner zugegriffen werden.<br>
- Ist der Keybase.io Client nicht installiert, kann auch durch einen Webbrowser auf den Ordner zugegriffen werden; [Omemo-Verification mightyBroccoli](https://keybase.pub/mightybroccoli/omemo-verification/).
