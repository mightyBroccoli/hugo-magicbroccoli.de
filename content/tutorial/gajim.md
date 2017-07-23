+++
title = "Gajim Tutorial"
date = "2017-07-22"
sidemenu = "true"
description = "How to use Gajim"
+++

## Account Registrierung
Zuerst muss sich ein Account erstellt werden. Dafür ist die Web Registrierung ein Anlaufpunkt.  
Speziell bei **magicbroccoli.de** sollte Sie sich das Passwort unbedingt merken, da eine Wiederherstellung nur dann durchgeführt wird, wenn eine eindeutige Identifizierung des Accountbesitzers möglich ist.
Durch den Klick auf "Registrieren" akzeptieren Sie die [Nutzungsbedingungen](/termsofuse/) sowie [Datenschutzbestimmungen](/datenschutz/).
![](/images/tutorials/gajim/webregister.png)

## Installation
Gajim lässt sich unter Windows und Linux problemlos installieren. --> [Gajim Download](https://gajim.org/?lang=de)

### Archlinux
Bei Archlinux ist die Installation einen Schritt länger aber nicht sonderlich schwierig.
Gajim lässt sich genauso über Pacman installieren allerdings wird für das Omemo Plugin zusätzlich das Packet [gajim-plugin-omemo](https://aur.archlinux.org/packages/gajim-plugin-omemo/) aus dem AUR benötigt.

Für das Gesamte Archlinux Tutorial; [Gajim Archlinux](https://wiki.archlinux.org/index.php/Gajim)

### Client Login
Der Client Login gestaltet sich ähnlich einfach. Sie wählen aus das Sie bereits einen Account besitzen, Jenen, den Sie in Schritt 1 erstellt haben.
![](/images/tutorials/gajim/clientlogin.png)  
Diesen tragen sie wie hier in die Felder ein. *Dabei ersetzen sie die Daten natürlich mit ihren eigenen.*
![](/images/tutorials/gajim/logindata.png)  
Sollten Ihre Daten korrekt sein folgt der eigentliche Login.
![](/images/tutorials/gajim/login.png)  
Wenn Sie den Haken bei "Mein Profil setzten, wenn ich mich verbinde" setzen, bekommen Sie bei Ihrem ersten Login, die Möglichkeit Ihr Profil zu bearbeiten. Dies ist aber auch nachträglich noch möglich und ist 100% freiwillig und kann genauso komplett leer gelassen werden.

* Spitzname : Nickname unter dem Sie in dem Chatraum auftreten ( leer = username )
* Chatraum : Chatraum den Sie betreten möchten. Wenn dieser nicht vorhanden ist und sie auf Betreten drücken wird dieser für Sie erstellt.
* Diesen Chatraum merken : Sollten sie dieses Kästchen ankreuzen wird der Chatraum zu ihrer Kontaktliste hinzugefügt.
* Betrete diesen Chatraum automatisch... : Sobald der Client sich verbunden hat betreten sie diesen Chatraum

## Plugins
Unter Ändern > Plugins lassen sich viele unterschiedliche Plugins installieren, die die Funktionalität von Gajim erweitern. Um alle Server Features effektiv nutzen zu können empfehle ich folgende Plugins zu installieren.

### Omemo
Bei Omemo handelt es sich um eine Weiterentwicklung der OTR ( Off the record ) Verfahrens, welches mehrere Ressource pro Account oder sogar Gruppenkonversationen verschlüsselt abwickeln kann.
Besonders ist, das auch versendete Medien komplett verschlüsselt versendet werden.

### HTTP Upload
HTTP Upload ist eine Funktion, wie sich auch WhatsApp und co verwenden. Dabei wird eine Medien Datei ( Bild, Video, etc. ) an den Server übertragen und dieser versendet dann einen Link zu der Datei an den/ oder die Empfänger. Mit diesem Plugin unterstützt Gajim dieses Verfahren.  
Wichtig zu beachten sind bei diesem Plugin die Serverrichtlinien. Meistens gibt, wie auch hier, gibt es bestimmt Grenzen wie groß eine einzelne versendete Datei sein kann, oder wie viele Dateien pro Zeiteinheit versendet werden können.

*Besonders bei diesem Plugin ist, dass es den verschlüsselten Versand von Medien unterstützt. Das heißt wird eine Omemo verschlüsselter Chat gestartet, sind auch mit HTTP Upload versendete Medien komplett verschlüsselt.*

Es ist darauf zu achten, dass das Plugin Images **kein** HTTP Upload Plugin ist sondern die Datei über das ältere Peer 2 Peer System überträgt, welchen viele mobile Geräte ablehnen.

### URL Image Preview
Erweiternd zum HTTP Upload ist das URL Image Preview Plugin. Dieses ermöglicht es Medien Dateien die über HTTP Upload versendet wurden direkt im Nachrichtenverlauf anzuzeigen. Damit ist der Medien Versand mit diesen beiden Plugins ( HTTP Upload / URL Image Preview ) vollständig.

*Besonders bei diesem Plugin ist, dass es das Öffnen von aesgcm// Links unterstützt. Das heißt das Medien die über Omemo versendet wurden, da sie verschlüsselt sind, erst herunterlädt sie dann entschlüsselt und danach anzeigt ohne das der User etwas dafür tun muss.*

## Gruppenchats
Aktionen > Chatraum betreten > Chatraum betreten führt zu einem Fenster das Ihnen einige Möglichkeiten bietet. 
![](/images/tutorials/gajim/muc.png)  

Das wichtigste Feld ist der Server. Dieser wird allerdings vom Server automatisch eingetragen, daher ist dort nichts weiter notwendig.

## Adhoc Befehle
![](/images/tutorials/gajim/howtoadhoc.png)  
![](/images/tutorials/gajim/adhoc.png)  
Bei den Adhoc Befehlen handelt es sich um Befehle, die Ihr Client dem Server zur Ausführung geben kann, um bestimmte Funktionen zu erhalten. Wie das Befehlsmenu aufzurufen ist zeigen die Bilder.

### Invite User
Die Invite Funktion ist eine besondere Funktion des Servers. Sie erlaubt einen speziellen Invite Link zu generieren, die zu einer gesonderten Registrierung führt. Der eingeladene User ist nach dieser Registrierung automatisch auf der Freundesliste der Person die ihn eingeladen hat.

### Ping
Sendet einen Ping an den Server der mit einem Pong und der aktuellen Serverzeit antwortet.

### Get Uptime
Zeigt die Zeit an die der Server online ist.

### Archive Settings
**Default = OFF**  
Die Archive Funktion ermöglicht es Nachrichten für 1 Monat auf dem Server zu speichern. Sollten sie sich auf einem anderen Gerät einloggen, welches [Message Archive Management](https://xmpp.org/extensions/xep-0313.html) unterstützt sendet der Server Ihnen, ihre Chatverläufe von vor bis zu 1 Monat. Nach dieser Zeit werden die Nachrichten verworfen.  

*Verschlüsselte Nachrichten werden natürlich auch verschlüsselt gespeichert.* 

### Search settings
**Default = OFF**  
Diese Funktion sollte man sie aktivieren erlaubt es sie über die generelle Benutzersuche zu finden.
![](/images/tutorials/gajim/search settings.png)  

## Nützliche Links
Einige Webseiten die weitergehende Tutorials bzw. ausführlichere Tutorials zur Verfügung stellen.

#### Allgemein
- [Datenschutzhelden.org - XMPP Server explained](https://datenschutzhelden.org/2017/07/12/daten-sparsame-xmpp-server/)

#### Omemo
- [Datenschutzhelden.org - Omemo für den Desktop](https://datenschutzhelden.org/2017/07/20/gajim-omemo-fuer-den-desktop/)
- [Maintainer Website von Omemo](https://conversations.im/omemo/)
- [Omemo Audit (PDF Download)](https://conversations.im/omemo/audit.pdf)
- [Omemo Wikipedia](https://de.wikipedia.org/wiki/OMEMO)

#### Technische Übersicht von XMPP
- [Eine Übersicht über XMPP](https://xmpp.org/about/technology-overview.html)



- - -
Last Edit 23.07.17