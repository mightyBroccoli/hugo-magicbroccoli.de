+++
type = "post"
date = "2017-08-28T13:30:00+02:00"
title = "CCC Jabber Connection"
author = "nico"
description = ""
keywords = [ "jabber.ccc.de", "Cert Error", "Prosody" ]
tags = [ "CA Bundle" , "CCC", "Cert Error", "Prosody" ]
categories = [ "XMPP", "Debian" ]
banner = "/banner/ccc-header.png"
+++
## Einleitung
Der XMPP Server vom [Chaos Computer Club](https://ccc.de) wird unter einem Zertifikat von [cacert.org](https://cacert.org) betrieben. Das root Zertifikat wird allerdings von den meisten Browsern / Betriebssystemen nicht anerkannt. Dies stellt für die Erreichbarkeit des XMPP Servers ein Problem da.

Speziell Server die auf Datenschutz und Sicherheit ausgelegt wollen keine unverschlüsselten Verbindung.Im Folgenden möchte daher ich aufzeigen, welche Änderungen notwendig wären, um Debian mit den entsprechenden Zertifikaten auszustatten.

Betroffen sind damit speziell Prosody Server, die folgende Konfiguration eingestellt haben.
```lua
s2s_require_encryption = true
s2s_secure_auth = true
```
Damit ist die Voraussetzung einer Verbindung ein Zertifikat, welches vom Server anerkannt wird. Da auch keine unverschlüsselte Verbindung aufgebaut werden kann, wird die Verbindung blockiert.
[Prosody S2S Security](https://prosody.im/doc/s2s#security)<br>

Ein Verbindungsaufbau würde im Log dann so aussehen.
```
mod_s2s	warn	Forbidding insecure connection to/from jabber.ccc.de
s2sin5637dae55f80	info	Incoming s2s stream jabber.ccc.de->magicbroccoli.de closed: Your server's certificate is invalid, expired, or not trusted by magicbroccoli.de
```

Es besteht die Möglichkeit Ausnahmen zu definieren, das Server trotz der Maßname, dass gültige Zertifikate präsentiert werden müssen, eine verschlüsselte Verbindung aufbauen können.<br>
**IMHO**: *Ich persönlich halte nichts davon Ausnahmen in einer Sicherheitsrichtlinie zu definieren. Ich weigere mich ein Pflaster System zu unterstützen, daher wird es unter [magicbroccoli.de](//magicbroccoli.de) keine Ausnahmen geben.*

- [Technik/Verschlüsselung](/technik/#verschlüsselung)
- [Technik/Zertifikate](/technik/#zertifikate)

## Root Zertifikate hinzufügen
Es wichtig die Integrität des Systems zu erhalten, daher werden keine Systemdateien geändert und Dateien nur an Stellen eingefügt, wo allein der Pfad schon erkennbar macht, dass diese eine *manuelle* Erweiterung sind.
```
/usr/local/share/ca-certificates
```
In diesem Verzeichnis sollten grundsätzlich keine Dateien oder Ordner vorhanden sein. Dieses Verzeichnis fügt für alle *lokalen* User Certificate Authorities ( *im Folgenden nur noch CA genannt* ) Zertifikate ein.

**Hinweis**: *Das Hinzufügen eines CA Root Zertifikats kann das System einem erhöhten Risiko aussetzen. Es sollte sehr vorsichtig mit der Beglaubigung von wildfremden CAs umgegangen werden. Da euer System mit den folgenden Änderungen auch allen beglaubigten Zertifikaten der CA vertraut.*

In diesem Verzeichnis ist ein Ordner zu erstellen mit dem Namen der CA.<br>
```#!/bin/bash
sudo mkdir /usr/local/share/ca-certificates/cacert.org
```

### Download der Zertifikate
```#!/bin/bash
sudo wget -P /usr/local/share/ca-certificates/cacert.org \
http://www.cacert.org/certs/root.crt \
http://www.cacert.org/certs/class3.crt
```

## Aktualisieren des Zertifikat Bündels
Zum Schluss muss der Zertifikat Speicher des System noch aktualisiert werden. Hierfür wird das Verzeichnis ausgelesen und alle Zertifikate die dort vorhanden sind werden hinzugefügt.
```#!/bin/bash
sudo update-ca-certificates
```

## Entfernen von CA Root Zertifikaten
_**VORSICHT**_<br>
Falls es, weswegen auch immer, gewollt ist einer CA und deren Zertifikaten nicht mehr zu vertrauen, sind die Schritte wie folgt.

Es ist hier eine enorme Vorsicht geboten. Lieber sollte ein move Befehl verwendet werden, wenn es auch nur den Hauch eins Zweifels gibt. Außerdem sollte nur jemand der genau weiß was er tut überhaupt an den Zertifikaten des Systems arbeiten.

Im Folgenden am Beispiel von cacert.org.

- Entfernen der Zertifikate/ des Zertifikat-Ordners aus
```#!/bin/bash
sudo rm -r /usr/local/share/ca-certificates/cacert.org/
```

- löschen und neuerstellen der Symlinks
```#!/bin/bash
sudo update-ca-certificates --fresh
```
Mit diesen beiden Befehlen ist es möglich, jegliche CA aus dem trust store zu entfernen.
