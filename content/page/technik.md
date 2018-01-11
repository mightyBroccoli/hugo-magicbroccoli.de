+++
type = "page"
date = "2017-06-27"
title = "Server Technik"
description = "verwendete Server Technik"
author = "nico"
keywords = [ "Prosody", "Debian", "XMPP", "MagicBroccoli XMPP"]
url = "technik"
+++
## Sicherheit
Das Hostsystem läuft unter ![Debian](/icons/debian_icon.png) Debian 9.2 Stretch.
Das System und alle seine Komponenten werden regelmäßig aktualisiert. Dabei nehme ich teilweise Rücksicht darauf, dass es zu keinen reboot in Stoßzeiten kommt. Wenn es aber gar nicht anders geht, ist eine kurze Downtime für wichtige Updates vertretbar.

### DNS
Die gesamte Zone von *magicbroccoli.de* ist mit DNSSEC signiert und lässt sich überprüfen.

### nginx
Alle Dienste der per HTTP erreichbar sind, werden durch einen [nginx](https://nginx.org/) Server veröffentlicht. Dieser ist konfiguriert ausschließlich [TLS verschlüsselte Verbindungen](https://de.wikipedia.org/wiki/Transport_Layer_Security) zuzulassen. Unverschlüsselte Verbindungen werden direkt zu einer verschlüsselten Verbindung aufgewertet. Ist dies nicht möglich, ist eine Verbindung nicht möglich.<br>
Zur Verfügung stehen TLS1.2 sowie 1.3 mit eine definierten Auswahl an ciphers. Außerdem ist der Server in der Lage [HTTP 1.1](https://de.wikipedia.org/wiki/Hypertext_Transfer_Protocol#HTTP.2F1.1) sowie [HTTP 2](https://de.wikipedia.org/wiki/Hypertext_Transfer_Protocol#HTTP.2F2) Verbindungen zu erlauben.
```
ssl_prefer_server_ciphers	on;
ssl_ciphers 'ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:DHE-RSA-AES256-SHA:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-SHA256';
ssl_ecdh_curve	secp384r1:secp521r1;
```
Zusätzlich zu einer recht restriktiven TLS Konfiguration werden standartmäßig einige HTTP Header mitgesendet um die Sicherheit der Webpages zu erhöhen.
```
add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload;";
add_header X-Content-Type-Options nosniff;
add_header X-XSS-Protection "1; mode=block";
add_header X-Robots-Tag none;
add_header X-Download-Options noopen;
add_header X-Permitted-Cross-Domain-Policies none;
add_header Referrer-Policy "no-referrer-when-downgrade";
add_header Content-Security-Policy "frame-ancestors 'self'";
```
Ähnlich wie bei meinem XMPP Server, ist es möglich über externe Testsuites die Konfiguration auf Lücken bzw. Schwächen hin zu überprüfen.<br>
Besonders bekannt ist hierfür [Qualys SSL Labs](https://www.ssllabs.com) dort sind [meine Ergebnisse](https://www.ssllabs.com/ssltest/analyze.html?d=magicbroccoli.de) nachprüfbar. Die Ergebnisse werden dort leider nicht dauerhaft gespeichet.<br>
( _Der Test dauert ca. 1 Minute, daher kann der Test von jedem jederzeit wiederholt werden._ )

### Prosody
Bei der XMPP Serversoftware handelt es ich um ein Prosody 0.10 stable nightly.<br>
Mit stable nightly meine ich den aktuellsten Build im [branch 0.10](https://hg.prosody.im/0.10/). Auch der stable release wird mit diesem Branch gebildet, allerdings hängt dieser teilweise stark hinter dem aktuellen Build hinterher.<br>
Ich verwende den stable nightly um einen stabilen Server zu garantieren allerdings lege ich auch Wert auf aktuelle Entwicklungen. Da es sich nicht um den testing branch handelt sind diese Features als stable anzusehen.

### Verschlüsselung
Prosody ist so konfiguriert, ausschließlich verschlüsselte Verbindungen zuzulassen. Zusätzlich dazu ist der Server so konfiguriert ausschließlich Verschlüsselungsverfahren zu erlauben, die [Perfect Forward Secrecy](https://de.wikipedia.org/wiki/Perfect_Forward_Secrecy) unterstützen.
Ungesicherte Verbindungen, oder Verbindungen mit zu schwacher Verschlüsselung bei *c2s* oder *s2s* werden blockiert. Leider werden dadurch einige Server sowie einige ältere Clients ausgesperrt, allerdings ist unzureichende Verschlüsselng für mich ein Ausschlusskriterium.
Eine Ansicht welche Verschlüsselungsverfahren zum Verbindungsaufbau zulässig sind ist hier zu finden: [zulässige Verschlüsselungsverfahren](https://check.messaging.one/result.php?domain=magicbroccoli.de&type=client#ciphers)

### Zertifikate
Es gibt viele öffentliche XMPP Server, die unter selbstsignierten oder ungültigen Zertifikaten betrieben werden. Mein Server ist so konfiguriert ausschließlich Zertifikate zuzulassen, die gültig sind. Selbstsignierte Zertifikate werden nicht akzeptiert somit wird eine Verbindung blockiert.

### Passwörter
Alle Passwöter werden gehashed in einer Datenbank gespeichert, die nicht von außen erreichbar ist. Als Authentifizierungsverfahren wird entweder [*SCRAM-SHA-1*](https://en.wikipedia.org/wiki/Salted_Challenge_Response_Authentication_Mechanism) oder [*SCRAM-SHA-1-PLUS*](https://en.wikipedia.org/wiki/Salted_Challenge_Response_Authentication_Mechanism) verwendet.<br>
Speziell das [*DIGEST-MD5*](https://de.wikipedia.org/wiki/HTTP-Authentifizierung#Digest_Access_Authentication) Verfahren, welches ältere Clients und Bots häufiger verwenden, wird nicht unterstützt.

## Features
Der Server unterstützt eine Vielfalt an XMPP-Erweiterungen (XEPs). Jeder Client unterstützt dabei eine andere Teilmenge dieser Features. Speziell gebe ich Acht darauf, [Conversations (Android)](https://conversations.im/) in möglichst großem Umfang zu unterstützen.
Auszug aus den speziellern Server-Features:

- [XEP-0033: Extended Stanza Addressing](https://xmpp.org/extensions/xep-0033.html)
- [XEP-0045: Multi-User Chat](https://xmpp.org/extensions/xep-0045.html)
- [XEP-0055: Basic implementation of Jabber Search](https://xmpp.org/extensions/xep-0055.html)
- [XEP-0065: SOCKS5 Bytestreams](https://xmpp.org/extensions/xep-0065.html)
- [XEP-0115: Entity Capabilities](https://xmpp.org/extensions/xep-0115.html)
- [XEP-0124: Bidirectional-streams Over Synchronous HTTP (BOSH)](https://xmpp.org/extensions/xep-0124.html)
- [XEP-0156: Discovering Alternative XMPP Connection Methods](https://xmpp.org/extensions/xep-0156.html)
- [XEP-0163: Personal Eventing Protocol](https://xmpp.org/extensions/xep-0163.html)
- [XEP-0191: Blocking Command](https://xmpp.org/extensions/xep-0191.html)
- [XEP-0198: Stream Managment](https://xmpp.org/extensions/xep-0198.html)
- [XEP-0237: Roster Versioning](https://xmpp.org/extensions/xep-0237.html)
- [XEP-0280: Message Carbons](https://xmpp.org/extensions/xep-0280.html)
- [XEP-0313: Message Archive Management](https://xmpp.org/extensions/xep-0313.html)
- [XEP-0352: Client State Indication](https://xmpp.org/extensions/xep-0352.html)
- [XEP-0357: Push Notifications](https://xmpp.org/extensions/xep-0357.html)
- [XEP-0363: HTTP File Upload](https://xmpp.org/extensions/xep-0363.html)
- [XEP-0368: SRV records for XMPP over TLS](https://xmpp.org/extensions/xep-0368.html)

### XEP-0156: Alternative XMPP Connection Methods
- HTTP-Bind Adresse: [https://magicbroccoli.de/http-bind](https://magicbroccoli.de/http-bind)
- Websocket Adresse: [https://magicbroccoli.de/xmpp-websocket](https://magicbroccoli.de/xmpp-websocket)
- XMPP over TLS: [xmpps.magicbroccoli.de](https://xmpps.magicbroccoli.de)

## Registrieren
Wenn dich diese Dinge überzeugt haben XMPP für dich und deine Freunde zu probieren. Kannst du dich hier direkt anmelden.
<center><a style="display: block; margin-top: 50px; margin-left: auto; margin-right: auto; margin-bottom: 50px; height: 50px; width: 300px; background-color: #0069a1; color: white; border-radius: 5px; line-height: 50px; text-align: center; font-weight: bold;" href="/register/">Registrieren</a></center>

## IM Observer
IM Oberserver ist ein Testsuite die automatisiert XMPP Server auf verschiedene Faktoren hin testet. Die Ergebnisse für meinen Server sind wie folgt.<a href='https://check.messaging.one/result.php?domain=magicbroccoli.de&amp;type=client'>
	<img src='https://check.messaging.one/badge.php?domain=magicbroccoli.de' alt='IM observatory score' />
</a>

Mit dem Tool von [tls.imirhil.fr](https://tls.imirhil.fr) lässt sich ähnlich zum IM Observer ein Server prüfen. MagicBroccoli XMPP hat dort ein Rating von A+ [CryptCheck Score](https://tls.imirhil.fr/xmpp/magicbroccoli.de).

## Statistiken
<img src="https://magicbroccoli.de/munin-cgi/munin-cgi-graph/magicbroccoli.de/rosewood.magicbroccoli.de/prosody_c2s-day.png" width="45%"> <img src="https://magicbroccoli.de/munin-cgi/munin-cgi-graph/magicbroccoli.de/rosewood.magicbroccoli.de/prosody_s2s-week.png" width="45%">
<img src="https://magicbroccoli.de/munin-cgi/munin-cgi-graph/magicbroccoli.de/rosewood.magicbroccoli.de/prosody_stanzas-week.png" width="45%"> <img src="https://magicbroccoli.de/munin-cgi/munin-cgi-graph/magicbroccoli.de/rosewood.magicbroccoli.de/prosody_uptime-week.png" width="45%">

- - -
Last Edit 26.11.17
