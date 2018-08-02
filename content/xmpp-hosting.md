+++
type = "page"
date = "2017-11-07"
title = "Magical XMPP Hosting"
description = "MagicBroccoli XMPP Hosting"
keywords = [ "MagicBroccoli XMPP Hosting", "XMPP", "XMPP-Hosting", "MagicBroccoli XMPP", "Prosody", "Debian" ]
draft = true
+++
## MagicBroccoli XMPP Hosting
MagicBroccoli XMPP Hosting bietet einen freien XMPP Server der ausgelegt ist auf Datenschutz und Sicherheit unter Verwendung *deiner eigenen Domain*.<br>

### Administration
Zur Verwaltung des Jabber Servers stehen Ihnen 2 mögliche Wege zur Verfügung. Über das [Webinterface](/admin/) können User hinzugefügt, entfernt oder geändert werden. Verfügt der verwendete XMPP-Client über die Möglichkeit Ad-Hoc Kommandos zu verwenden, kann die Verwaltung auch komplett über den Client vorgenommen werden.

### Vorraussetzungen
Um einen verantwortungsvollen Umgang zu gewährleisten, bestehen einige Voraussetzungen damit das Hosting funktionieren kann.

- regelkonformes Verhalten nach den [Terms of Service](/termsofuse/)
- Aufklärung aller Nutzer über die [Datenschutzerklärung](/datenschutz/)

## Wie funktioniert es?
Damit der XMPP Server funktioniert müssten einige DNS SRV Einträge geändert/ hinzugefügt werden. Dies ist bei nahezu allen Providern möglich, falls nicht, müsste dies der betreffende Support des Providers übernehmen.<br>
Falls auch dies nicht möglich ist und dennoch der Wunsch besteht, ist ein Wechsel des DNS Hosting Partners unumgänglich. Kontaktieren Sie mich, dann kann ich Ihnen sicherlich auch da weiterhelfen.

### DNS
Die zur Verwendung benötigten DNS Einträge sind hier aufgelistet. Enthalten sind Einträge für Client zum Server, Server zu Server sowie XMPP over TLS Einträge.<br>
Im folgenden Beispiel habe ich die Domain *example.de* verwendet, diese müsste durch Ihre eigene ersetzt werden.

```dns
_xmpp-client._tcp.example.tld. IN SRV 0 0 5222 magicbroccoli.de.

_xmpp-server._tcp.example.tld. IN SRV 0 0 5269 magicbroccoli.de.

_xmpps-client._tcp.example.tld. IN SRV 0 0 443 xmpps.magicbroccoli.de.

_xmppconnect.example.tld. IN TXT "_xmpp-client-xbosh=https://magicbroccoli.de/http-bind"

_xmppconnect.example.tld. IN TXT "_xmpp-client-websocket=wss://magicbroccoli.de/xmpp-websocket"
```

Bei Problemen zörgere nicht mich zu [kontaktieren](/contact/).

### Zertifikat
Wenn der Wunsch besteht ein bereits bestehendes gültiges Zertifikat zu verwenden, bitte ich darum, das dieses mindestens 1 Jahr gültig ist. Falls kein Zertifikat zur Verfügung gestellt wird, wird das magicbroccoli.de Zertifikat verwendet.<br>
In dem Fall, dass eine Domain auf meinen Server zeigt, kann ein LetsEncrypt Zertifikat bereitgestellt werden.

- - -

<center>[![](/images/netcup-hlogo-b220h100.png)](https://www.netcup.de)</center>

Last Edit 02.08.18