+++
title = "Gajim Tutorial"
date = "2017-07-22"
sidemenu = "true"
description = "How to use Gajim"
+++
### Account Registrierung
Zuerst muss sich ein Account erstellt werden. Dafür ist die Web Registrierung ein Anlaufpunkt.  
Speziell bei **magicbroccoli.de** sollte Sie sich das Passwort unbedingt merken, da eine Wiederherstellung nur dann durchgeführt wird, wenn eine eindeutige Identifiizierung des Accountbesitzters möglich ist.
Durch den Klick auf "Registrieren" akzeptieren Sie die [Nutzungsbedingungen](/termsofuse/) sowie [Datenschutzbestimmungen](/datenschutz/).
![](/images/tutorials/gajim/webregister.png)

### Installation
Gajim lässt sich unter Windows und Linux problemlos installieren.  
[Gajim Download](https://gajim.org/?lang=de)

##### Archlinux
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
Wenn Sie den Haken bei "Mein Profil setzten, wenn ich mich verbinde" setzen, bekommen Sie bei Ihrem ersten Login den möglichkeit Ihr Profil zu bearbeiten. Dies ist aber auch nachträglich noch möglich und ist 100% freiwillig und kann genauso kommplett leer gelassen werden.

### Gruppenchats
Aktionen > Chatraum betreten > Chatraum betreten führt zu einem Fenster das Ihnen einige Möglichkeiten bietet. 
![](/images/tutorials/gajim/muc.png)  

Das wichtigste Feld ist der Server. Dieser wird allerdings vom Server automatisch eingetragen, daher ist dort nichts weiter notwendig.

* Spitzname : Nickname unter dem Sie in dem Chatraum auftreten ( leer = username )
* Chatraum : Chatraum den Sie betreten möchten. Wenn dieser nicht vorhanden ist und sie auf Betreten drücken wird dieser für Sie erstellt.
* Diesen Chatraum merken : Sollten sie dieses Kästchen ankreuzen wird der Chatraum zu ihrer Kontaktliste hinzugefügt.
* Betrete diesen Chatraum automatisch... : Sobald der Client sich verbunden hat betreten sie diesen Chatraum

### Adhoc Befehle
![](/images/tutorials/gajim/howtoadhoc.png)  
![](/images/tutorials/gajim/adhoc.png)  
Bei den Adhoc Befehlen handelt es sich um Befehle, die Ihr Client dem Server zur ausführung geben kann, um bestimmte Funktionen zu erhalten. Wie das Befehlsmenu zu erreichen ist zeigen die Bilder.

#### Invite User
Die Invite Funktion ist eine besondere Funktion des Servers. Sie erlaubt einen speziellen Invite Link zu generieren, die zu einer gesonderten Registrierung führt. Der eingeladene User ist nach dieser Registrierung automatisch auf der Freundesliste der Person die ihn eingeladen hat.

#### Ping
Sendet einen Ping an der Server der mit einem Pong und der aktuellen Serverzeit antwortet.

#### Get Uptime
Zeigt die Zeit an die der Server online ist.

#### Archive Settings
**Default = OFF**  
Die Archive Funktion ermöglicht es Nachrichten für 1 Monat auf dem Server zu speichern. Sollten sie sich auf einem anderen Gerät einloggen, welches [Message Archive Management](https://xmpp.org/extensions/xep-0313.html) unterstützt sendet der Server Ihnen, ihre Chatverläufe von vor bis zu 1 Monat. Nach dieser Zeit werden die Nachrichten verworfen.  

*Verschlüsselte Nachrichten werden natürlich auch verschlüsselt gespeichert.* 

#### Search settings
**Default = OFF**  
Diese Funktion sollte man sie aktivieren erlaubt es sie über die generelle Benutzersuche zu finden.
![](/images/tutorials/gajim/search settings.png)  


