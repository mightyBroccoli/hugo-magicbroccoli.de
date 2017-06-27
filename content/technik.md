+++
date = "2017-06-27"
title = "Server Technik"
sidemenu = "true"
tags = [ "Prosody", "Debian" ]
+++
## Sicherheit
Das Hostsystem läuft unter ![Debian](/icons/debian_icon.png) Debian Stretch.
Ich update das System und alle seine Komponenten regelmäßig. Dabei nehme ich teilweise Rücksicht darauf, dass es zu keinen reboot zu Stoßzeiten kommt. Wenn es aber gar nicht anders geht, ist eine kurze Downtime für wichtige Updates vertretbar.

### DNS
Die gesamte Domain *magicbroccoli.de* ist mit DNSSEC signiert und lässt sich überprüfen.

## Prosody
Der XMPP Server ist zur Zeit ein Prosody 0.10 nightly.

### Verschlüsselung
Prosody ist so konfiguriert, ausschließlich verschlüsselte Verbindungen zuzulassen. Zusätzlich dazu ist der Server so konfiguriert ausschließlich Verschlüsselungsverfahren zuzulassen, die [Perfect Forward Secrecy](https://de.wikipedia.org/wiki/Perfect_Forward_Secrecy) unterstützen.  
Ungesicherte Verbindungen, oder Verbindungen mit zu schwacher Verschlüsselung bei *c2s* oder *s2s* werden blockiert. Leider werden dadurch einige Server sowie einige ältere Clients ausgesperrt, allerdings ist Verschlüsselng für mich ein Ausschlusskriterium.  
Eine Ansicht welche Verschlüsselungsverfahren zum Verbindungsaufbau zulässig sind ist hier zu finden: [zulässige Verschlüsselungsverfahren](https://check.messaging.one/result.php?domain=magicbroccoli.de&type=client#ciphers)

### Zertifikate
Es gibt viele öffentliche XMPP Server, die unter selbstsignierten oder ungültigen Zertifikaten betrieben werden. Mein Server ist so konfiguriert ausschließlich Zertifikate zuzulassen, die anerkannt  "*valid*" sind. Selbstsignierte Zertifikate werden nicht anerkannt und somit wird eine Verbindung blockiert.

### Passwörter
Passwöter werden gehashed in einer Datenbank gespeichert, die nicht von außen erreichbar ist. Als Authentifizierungsverfahren wird entweder [*SCRAM-SHA-1* oder *SCRAM-SHA-1-PLUS*](https://en.wikipedia.org/wiki/Salted_Challenge_Response_Authentication_Mechanism).  
Speziell das [*DIGEST-MD5*](https://de.wikipedia.org/wiki/HTTP-Authentifizierung#Digest_Access_Authentication) Verfahren, welches ältere Clients häufiger verwenden, wird nicht unterstützt.

## Features
Der Server unterstützt eine große Vielfalt an XMPP-Erweiterungen (XEPs). Jeder Client unterstützt dabei eine andere Teilmenge dieser Features. Speziell gebe ich Acht darauf, [Conversations (Android)](https://conversations.im/) in möglichst großem Umfang zu unterstützen.  
Auszug aus den speziellern Server-Features:

- [XEP-0033: Extended Stanza Addressing](https://xmpp.org/extensions/xep-0033.html)
- [XEP-0035: SSL/TLS Integration](https://xmpp.org/extensions/xep-0035.html)
- [XEP-0055: Basic implementation of Jabber Search](https://xmpp.org/extensions/xep-0055.html)
- [XEP-0065: SOCKS5 Bytestreams](https://xmpp.org/extensions/xep-0065.html)
- [XEP-0124: Bidirectional-streams Over Synchronous HTTP (BOSH)](https://xmpp.org/extensions/xep-0124.html)
- [XEP-0136: Message Archiving](https://xmpp.org/extensions/xep-0136.html)
- [XEP-0198: Stream Managment](https://xmpp.org/extensions/xep-0198.html)
- [XEP-0280: Message Carbons](https://xmpp.org/extensions/xep-0280.html)
- [XEP-0313: Message Archive Management](https://xmpp.org/extensions/xep-0313.html)
- [XEP-0363: HTTP File Upload](https://xmpp.org/extensions/xep-0363.html)

### HTTP-Bind / Bosh

Adresse für HTTP-Bind:  https://magicbroccoli.de/http-bind

## Registrieren
<center> <p>
<a href="/register/">
<img src="/images/register.png" alt="Register" style="width: 200px;"/>
</a></p>
</center>