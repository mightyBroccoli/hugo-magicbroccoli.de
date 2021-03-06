+++
type = "page"
date = "2017-06-27"
title = "Server Technik"
description = "verwendete Server Technik"
author = "nico"
keywords = [ "Prosody", "Debian", "XMPP", "MagicBroccoli XMPP"]
+++
## System
Das Hostsystem verwendet ![Debian](/icons/debian_icon.png) Debian 9.5 Stretch. Alle Komponenten werden regelmäßig aktualisiert. Teilweise nehme ich Rücksicht darauf, dass es zu keinen reboot in Stoßzeiten kommt. Wenn sich dies allerdings nicht verhindern lässt, wird es zu einer möglichst kleinen Downtime für wichtige Updates kommen.

### DNS
Die gesamte DNS-Zone von *magicbroccoli.de* ist mit DNSSEC signiert und lässt sich dahingehend überprüfen.

### nginx
Alle Dienste die per HTTPS erreichbar sind, werden durch einen [nginx](https://nginx.org/) Server veröffentlicht. Dieser ist konfiguriert ausschließlich [TLS verschlüsselte Verbindungen](https://de.wikipedia.org/wiki/Transport_Layer_Security) zuzulassen. Unverschlüsselte Verbindungen werden direkt zu einer verschlüsselten Verbindung aufgewertet. Ist dies nicht möglich, wird die Verbindung verweigert.<br>
Zur Verfügung stehen TLS1.2 sowie 1.3 mit einer definierten Auswahl an ciphers. Außerdem ist der Server in der Lage [HTTP 1.1](https://de.wikipedia.org/wiki/Hypertext_Transfer_Protocol#HTTP.2F1.1) sowie [HTTP 2.0](https://de.wikipedia.org/wiki/Hypertext_Transfer_Protocol#HTTP.2F2) Verbindungen zur Verfügung zu stellen.
```
ssl_prefer_server_ciphers	on;
ssl_ciphers 'ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:DHE-RSA-AES256-SHA:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-SHA256';
ssl_ecdh_curve	secp384r1:secp521r1;
```
Zusätzlich zu einer recht restriktiven TLS Konfiguration werden standartmäßig einige HTTP Header mitgesendet um die Sicherheit der Webpages zu gewährleisten.
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
Ähnlich zum XMPP Server, ist es möglich über externe Testsuites die Konfiguration auf Lücken bzw. Schwächen hin zu überprüfen.<br>
Besonders bekannt hierfür ist [Qualys SSL Labs](https://www.ssllabs.com) dort sind [meine Ergebnisse](https://www.ssllabs.com/ssltest/analyze.html?d=magicbroccoli.de) nachprüfbar. Die Ergebnisse werden dort leider nicht dauerhaft gespeichet.<br>
( _Der Test dauert ca. 1 Minute, daher kann der Test von jedem jederzeit wiederholt werden._ )

### Ejabberd
Bei der XMPP Serversoftware handelt es ich um ein Ejabberd 18.06-1~bpo9+1.<br>

#### Verschlüsselung
Es werden generell ausschließlich verschlüsselte Verbindungen zugelassen, zusätzlich dazu werden ausschließlich Verschlüsselungsverfahren angeboten, die [Perfect Forward Secrecy](https://wikipedia.org/wiki/Perfect_Forward_Secrecy) unterstützen. Hierdurch kann es vorkommen das einige Server nicht erreichbar sind. Der Admin des jeweiligen Servers kann Ihnen hierbei weiterhelfen, unzureichende Verschlüsselng für mich ein Ausschlusskriterium; [zulässige Verschlüsselungsverfahren](https://check.messaging.one/result.php?domain=magicbroccoli.de&type=client#ciphers).

##### Zertifikate
Dieser XMPP Server ist dahingehend konfiguriert ausschließlich gültige und korrekt ausgestellte Zertifikate zuzulassen. Selbstsignierte Zertifikate werden nicht unterstützt.

#### Passwörter
Alle Passwöter werden gehashed in einer Datenbank gespeichert, die nicht von außen erreichbar ist. Als Authentifizierungsverfahren wird [*SCRAM-SHA-1*](https://wikipedia.org/wiki/Salted_Challenge_Response_Authentication_Mechanism) verwendet.<br>
Das [*DIGEST-MD5*](https://wikipedia.org/wiki/HTTP-Authentifizierung#Digest_Access_Authentication) Verfahren ist explizit deaktiviert, welches ältere Clients und Bots häufiger verwenden.

#### Features
Der Server unterstützt eine Vielfalt an XMPP-Erweiterungen (XEPs). Jeder Client unterstützt dabei eine andere Teilmenge dieser Features. Speziell gebe ich Acht darauf, [Conversations (Android)](https://conversations.im/) in möglichst großem Umfang zu unterstützen.

##### Auszug aus den speziellern Server-Features:

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
- [XEP-0288: Bidirectional Server-to-Server Connections](https://xmpp.org/extensions/xep-0288.html)
- [XEP-0313: Message Archive Management](https://xmpp.org/extensions/xep-0313.html)
- [XEP-0352: Client State Indication](https://xmpp.org/extensions/xep-0352.html)
- [XEP-0357: Push Notifications](https://xmpp.org/extensions/xep-0357.html)
- [XEP-0363: HTTP File Upload](https://xmpp.org/extensions/xep-0363.html)
- [XEP-0368: SRV records for XMPP over TLS](https://xmpp.org/extensions/xep-0368.html)

##### XEP-0156: Alternative XMPP Connection Methods
- HTTP-Bind Adresse: [https://magicbroccoli.de/http-bind](https://magicbroccoli.de/http-bind)
- Websocket Adresse: [https://magicbroccoli.de/xmpp-websocket](https://magicbroccoli.de/xmpp-websocket)
- XMPP over TLS: [xmpps.magicbroccoli.de](https://xmpps.magicbroccoli.de)

##### TOR Hidden Service
Für Fans von [Tor](https://www.torproject.org/) biete ich nun einen Hidden Service an. Mit diesem ist es möglich Client-to-Server Verbindungen zum XMPP-Server durch onion routing aufzubauen. Die Adresse lautet: [dyy2lc2at2hqfir6.onion](dyy2lc2at2hqfir6.onion:5222).

<font color="red">_Hinweise_:</font>

- Es ist nicht möglich, ein gültiges TLS-Zertifikat für eine .onion-Adresse anzubieten.
- Die Funktion http_upload verwendet bei Nutzung, auch mit konfigurierter .onion-Adresse, den normalen DNS und klassischen Verbindungen ins Internet. Daher müsste für dessen Nutzung mindestens noch ein _normaler_ Zugang zum Internet bestehen.

#### Registrieren
Wenn Sie diese Dinge überzeugt haben XMPP zu probieren, ist es hier direkt möglich sich zu registrieren.
<center><a style="display: block; margin-top: 50px; margin-left: auto; margin-right: auto; margin-bottom: 50px; height: 50px; width: 300px; background-color: #0069a1; color: white; border-radius: 5px; line-height: 50px; text-align: center; font-weight: bold;" href="/register/">Registrieren</a></center>

#### IM Observer
IM Oberserver ist ein Testsuite die automatisiert XMPP Server auf verschiedene Faktoren hin testet. Die Ergebnisse für meinen Server sind wie folgt.<a href='https://check.messaging.one/result.php?domain=magicbroccoli.de&amp;type=client'>
	<img src='https://check.messaging.one/badge.php?domain=magicbroccoli.de' alt='IM observatory score' />
</a>

Mit dem Tool von [tls.imirhil.fr](https://tls.imirhil.fr) lässt sich ähnlich zum IM Observer ein Server prüfen. MagicBroccoli XMPP hat dort ein Rating von A+ [CryptCheck Score](https://tls.imirhil.fr/xmpp/magicbroccoli.de).

- - -
Last Edit 02.08.18
