+++
type = "page"
date = "2017-07-22"
title = "Gajim Tutorial"
author = "nico"
description = "Guide on how to use Gajim"
keywords = [ "MagicBroccoli XMPP", "XMPP", "Gajim", "Gajim Tutorial" ]
tags = [
	"Gajim"
]
categories = [ "XMPP", "Guide" ]
+++
## 1. Account Registrierung
Zuerst muss sich ein Account erstellt werden. Hierfür ist die Web Registrierung der Anlaufpunkt.
Speziell für **magicbroccoli.de** sollten Sie sich das Passwort unbedingt merken, da eine Wiederherstellung nur dann durchgeführt wird, wenn eine eindeutige Identifizierung des Accountbesitzers möglich ist. Durch den Klick auf "Registrieren" akzeptieren Sie die [Nutzungsbedingungen](/termsofuse/) sowie [Datenschutzbestimmungen](/datenschutz/).
![](/images/tutorials/webregister.png)

## 2. Installation
Gajim lässt sich unter Windows und Linux problemlos installieren. --> [Gajim Download](https://gajim.org/?lang=de)

### 2.1 Archlinux
Bei Archlinux ist die Installation einen Schritt länger, aber nicht sonderlich schwierig.
Gajim lässt sich genauso über Pacman installieren `sudo pacman -S gajim`. Allerdings wird für das Omemo Plugin zusätzlich das Packet [gajim-plugin-omemo](https://aur.archlinux.org/packages/gajim-plugin-omemo/) aus dem Arch AUR benötigt.

Ein deutlich ausfürlicheres Tutorial finden Sie hier: [Gajim Archlinux](https://wiki.archlinux.org/index.php/Gajim)

### 2.2 Ubuntu/Debian
Je nach Wahl der Apt Repositories ist möglich und empfehlenswert Gajim direkt zu installieren.
Hierfür wird meistens ein Administrator oder ein Benutzer mit Zugriff auf `sudo` benötigt. Anschließend lässt sich mit `sudo apt-get install gajim` Gajim installieren.

Ein deutlich ausfürlicheres Tutorial finden Sie hier: [Gajim Ubuntu/Debian](https://wiki.ubuntuusers.de/Gajim/)

## 3. Client Login
Der Client Login gestaltet sich ähnlich einfach. Sie wählen aus, dass Sie bereits einen Account besitzen, jenen aus Schritt 1 oder einen bestehenden.
Diesen tragen sie wie hier in die Felder ein. *Dabei ersetzen sie die Daten natürlich mit ihren eigenen.*
Sollten Ihre Daten korrekt sein folgt der eigentliche Login.
Wenn Sie den Haken bei "Mein Profil setzten, wenn ich mich verbinde" setzen, bekommen Sie bei Ihrem ersten Login, die Möglichkeit Ihr Profil zu bearbeiten. Dies ist aber auch nachträglich noch möglich und ist 100% freiwillig und kann genauso komplett leer gelassen werden.

<img src="/images/tutorials/gajim/clientlogin.png" width="100%">
<img src="/images/tutorials/gajim/logindata.png" width="50%"><img src="/images/tutorials/gajim/login.png" width="50%">
## 4. Plugins
Viele Funktionalitäten lassen sich bei Gajim mithilfe von Plugins stark erweitern. Unter Ändern > Plugins lassen sich unterschiedlichste Plugins installieren. Um alle Server Features effektiv nutzen zu können, empfehle ich mindestens folgende Plugins zu installieren.

### 4.1 Omemo
Bei [Omemo](https://conversations.im/omemo/) handelt es sich um eine Weiterentwicklung des OTR ([Off the record](https://wikipedia.org/wiki/Off-the-Record_Messaging)) Verfahrens. Besonders hierbei ist, dass mehrere Ressourcen pro Account und auch Gruppenkonversationen verschlüsselt werden können. Zusätzlich dazu können auch verschickte Medien verschlüsselt versendet werden.

### 4.2 HTTP Upload
HTTP Upload ist eine Funktion des Medienversands, wie sie auch WhatsApp und Co verwenden. Dabei wird eine Mediendatei ( Bild, Video, etc. ) an den Server übertragen und dieser versendet anschließend einen Link zu der Datei an den/die Empfänger.

Bei diesem Plugin sind die Serverrichtlinien zu beachten. Meistens gibt es vorgegebene Grenzen, wie groß eine einzelne versendete Datei sein darf bzw wie viele Dateien pro Zeiteinheit versendet werden können.

*Wie [4.1](#4-1-omemo) erwähnt lässt dieses Plugin einen verschlüsselten Upload eines versendeten Mediums zu. Damit sind die versendeten Dateien, nach den Spezifikationen von Omemo nur für die*

**Wichtig** : Das Plugin [Images](https://dev.gajim.org/gajim/gajim-plugins/wikis/ImagePlugin) verwendet **kein** HTTP Upload. Hierbei wird die Datei über das ältere Peer 2 Peer System übertragen. Viele mobile Geräte unterstützen diese Art der Übertragung nicht.

### 4.3 URL Image Preview
Um die volle Funktionalität von HTTP Upload auszuschöpfen kann das [URL Image Preview Plugin](https://dev.gajim.org/gajim/gajim-plugins/wikis/UrlImagePreviewPlugin) verwendet werden. Dieses ermöglicht Medien Dateien, die über HTTP Upload versendet wurden, direkt im Nachrichtenverlauf anzuzeigen. Damit ist der Medien Versand/Empfang mit diesen beiden Plugins ( HTTP Upload / URL Image Preview ) vollständig integriert.

*Besonders nützlich ist, dass dieses Plugin das  Öffnen von aesgcm:// Links unterstützt. Damit können auch mit Omemo verschlüsselt übertragene Medien direkt angezeigt werden.*

## 5. Gruppenchats
Aktionen > Chatraum betreten > Chatraum betreten führt zu einem Fenster das Ihnen einige Möglichkeiten bietet.
![](/images/tutorials/gajim/muc.png)

* Spitzname : Nickname unter dem Sie in dem Chatraum auftreten ( leer = username )
* Chatraum : Chatraum den Sie betreten möchten, wenn dieser nicht vorhanden ist wird dieser für Sie erstellt.
* _Diesen Chatraum merken_ : Sollten sie dieses Kästchen ankreuzen wird der Chatraum zu ihrer Kontaktliste hinzugefügt.
* _Betrete diesen Chatraum automatisch..._ : Nach dem Login betreten Sie diesen Raum automatisch.
* Server : Adresse unter welchen die Chaträume zu erreichen sind.
*
*Hinweis* : Dieser wird allerdings vom Server automatisch eingetragen, daher ist dort nichts weiter notwendig.

## 6. Adhoc Befehle
<img src="/images/tutorials/gajim/howtoadhoc.png" width="40%"><img src="/images/tutorials/gajim/adhoc.png" width="60%">

Bei den Adhoc Befehlen handelt es sich um Befehle, die Ihr Client dem Server zur Ausführung geben kann, um bestimmte Funktionen zu erhalten. Wie das Befehlsmenu aufzurufen ist zeigen die Bilder.

### 6.1 Ping
Sendet einen Ping an den Server der mit einem Pong und der aktuellen Serverzeit antwortet.

### 6.2 Get Uptime
Zeigt die Zeit an die der Server online ist.

### 6.3 Archive Settings
**Default = OFF**
Die Archive Funktion ermöglicht es Nachrichten für 1 Monat auf dem Server zu speichern. Sollten sie sich auf einem anderen Gerät einloggen, welches [Message Archive Management](https://xmpp.org/extensions/xep-0313.html) unterstützt sendet der Server Ihnen, ihre Chatverläufe von vor bis zu 1 Monat. Nach dieser Zeit werden die Nachrichten verworfen.

*Verschlüsselte Nachrichten werden natürlich auch verschlüsselt gespeichert.*

### 6.4 Search settings
**Default = OFF**
Diese Funktion sollte man sie aktivieren erlaubt es sie über die generelle Benutzersuche zu finden.
<img src="/images/tutorials/gajim/search settings.png" width="100%">

## 7. Nützliche Links
Einige Webseiten die weitergehende Tutorials bzw. ausführlichere Tutorials zur Verfügung stellen.

#### Allgemein
- [Datenschutzhelden.org - XMPP Server explained](https://datenschutzhelden.org/2017/07/12/daten-sparsame-xmpp-server/)

#### Omemo
- [Datenschutzhelden.org - Omemo für den Desktop](https://datenschutzhelden.org/2017/07/20/gajim-omemo-fuer-den-desktop/)

[Zurück zur Übersicht](/xmpp/)

- - -
Last Edit 30.03.18
