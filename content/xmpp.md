+++
date = "2017-06-21"
title = "Magical XMPP Server"
sidemenu = "true"
description = "Powered by Prosody"
tags = [ "Prosody", "XMPP", "Jabber" ]
+++
## Einführung
Ich betreibe einen XMPP Instant Messaging Server, der ursprünglich ausschließlich für die Besucher meines TeamSpeak gedacht war. Allerdings nun auch öffentlich zugänglich ist. Hier möchte ich einige Dinge erläutern die für eine Verbindung, sowie Nachrichten Versand/Empfang notwendig sind.


##### How to:
```
server/ domain: magicbroccoli.de
port: 5222
ressource: random generiert oder ASCI Text
BOSH URL: magicbroccoli.de:5281/http-bind/
encryption: always required
SOCKS5 Proxy: proxy.magicbroccoli.de
jabber search: search.magicbroccoli.de
conference server: conference.magicbroccoli.de
```

Eine ausführliche Liste von Clients für unterschiedlichste Systeme gibt es hier [XMPP Clients](https://xmpp.org/software/clients.html).  

**INHO** : Die folgende Liste bezieht sich auf die Clients, die die meisten Features abdecken und möglichst vielen Standarts konform sind:

- Android: [Conversations](https://conversations.im/) (€ 2,39 im [Google Play Store](https://play.google.com/store/apps/details?id=eu.siacs.conversations&referrer=utm_source%3Dwebsite) oder gratis auf [F-Droid](https://f-droid.org/repository/browse%20/?fdid=eu.siacs.conversations))
- iOS (iPhone): [ChatSecure](https://itunes.apple.com/de/app/chatsecure-verschl%C3%BCsselter-nachrichtendienst/id464200063?mt=8)
- Linux: [Gajim](https://gajim.org/?lang=de)
- Linux (console): [mcabber](https://mcabber.com/) oder [Profanity](http://www.profanity.im/)
- macOS (Mac OS X): [Adium](https://adium.im/)
- Web (im Browser): [Converse.js](https://conversejs.org/)
- Windows: [Gajim](https://gajim.org/?lang=de)

Eine kurze Einführung eine Registrierung / Benutzen eines solchen Clients aussieht:  

[Beispiel Gajim DE](https://dev.gajim.org/gajim/gajim/wikis/help/GajimHelpDe)  
[Beispiel Pidgin DE](https://uwetrottmann.com/software/pidgin-jabber-icq)

Auszug aus den spezieller Server Features:

- [XEP-0033: Extended Stanza Addressing](https://xmpp.org/extensions/xep-0033.html)
- [XEP-0035: SSL/TLS Integration](https://xmpp.org/extensions/xep-0035.html)
- [XEP-0055: Basic implementation of Jabber Search](https://xmpp.org/extensions/xep-0055.html)
- [XEP-0065: SOCKS5 Bytestreams](https://xmpp.org/extensions/xep-0065.html)
- [XEP-0124: Bidirectional-streams Over Synchronous HTTP (BOSH)](https://xmpp.org/extensions/xep-0124.html)
- [XEP-0136: Message Archiving](https://xmpp.org/extensions/xep-0136.html)
- [XEP-0198: Steam Managment](https://xmpp.org/extensions/xep-0198.html)
- [XEP-0280: Message Carbons](https://xmpp.org/extensions/xep-0280.html)
- [XEP-0313: Message Archive Management](https://xmpp.org/extensions/xep-0313.html)
- [XEP-0363: HTTP File Upload](https://xmpp.org/extensions/xep-0363.html)

### Datenschutz
Heutzutage ist eine Datenschutzerklärung wichtiger den je. Da es sich außerdem um persönliche Daten handelt ist hier die [Datenschutzerklärung](/datenschutz/).