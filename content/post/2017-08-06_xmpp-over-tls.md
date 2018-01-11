+++
type = "post"
date = "2017-08-06T15:00:00+02:00"
title = "XMPP over TLS Tutorial"
author = "nico"
description = ""
keywords = [ "Prosody", "XMPP", "XEP-0368", "XMPP over TLS" ]
tags = [
	"XMPP",
	"Prosody",
	"XEP-0368"
]
categories = [ "Prosody", "XMPP", "Guide" ]
banner = ""
slug = "xmpp over tls guide"
+++
## How to setup XEP-0368
### Was ist XEP-0368
Bei [XEP-0368](https://xmpp.org/extensions/xep-0368.html) handelt es sich um ein Verfahren welches XMPP-Clients ermöglicht über SRV Einträge im DNS, alternative Verbindungsmöglichkeiten zu entdecken. Dies ist äußerst nützlich, falls die regulären Verbindungswege blockiert sind zb. durch Firewalls.

<blockquote cite="https://xmpp.org/extensions/xep-0368.html">XMPP Core specifies the use of xmpp-client/xmpp-server SRV records as the method of discovering how to connect to an XMPP server. This XEP extends that to include new xmpps-client/xmpps-server SRV records pointing to direct TLS ports and combine priorities and weights as if they were a single SRV record similar to RFC 6186. It also provides an easy way for clients to bypass restrictive firewalls that only allow HTTPS, for servers to host multiple protocols/services on a single port, and for servers and clients to take advantage of less round trips and existing direct TLS loadbalancers.</blockquote>

### Was wird benötigt?
- Prosody Server
- **optional** gültiges SSL Zertifikat ( LetsEncrypt / oä )
- 2 IPv4 Adressen ( **Hinweis beachten** )
- iptables und iptables-persistent
- **optional** Webserver
- Kontrolle über eure DNS Zone

<span style="color:red">*Hinweis*: Notwendigkeit 2 IPv4 Adressen</span>
Es werden 2 IP Adressen benötigt, wenn Ihre IP Adresse bereits auf Port 443 lauscht. Sprich eine **https** Website via Apache2 / nginx gehostet wird. Da für diese Methode der Port verpflichtend benötigt wird. Ist dies nicht der Fall reicht eine einzelne IP Adresse vollkommen aus.

- - -

### 1. DNS Einstellungen
Den Anfang machen die DNS Einstellungen, da die Publizierung der neuen DNS Einstellungen bis zu 48 Stunden dauern kann.
Zusätzlich zu den [Standard SRV Einträgen](https://prosody.im/doc/dns) wird ein weiterer `_xmpps-client._tcp` Eintrag benötigt. Außerdem ein weiterer A Record für die gewünschte Subdomain.

In diesem Beispiel ist die Domain `example.com` und XMPP over TLS soll über die SubDomain `xmpps.example.com` erreichbar sein.

```
# Standard Settings
_xmpp-client._tcp.example.com. 18000 IN SRV 0 5 5222 example.com.
_xmpp-server._tcp.example.com. 18000 IN SRV 0 5 5269 example.com.

# XMPP over TLS Settings
_xmpps-client._tcp.example.com. 18000 IN SRV 10 5 xmpps.example.com.

# A record
xmpps.example.com. 18000 IN A $zweite_ip_adresse
```

### 2. Prosody Server Konfiguration
Für den Verbindungsaufbau muss in der Prosody Konfiguration *legacy_ssl_ports* definiert werden, damit das `http` Modul auch auf dem gewählten Port lauscht. Das Modul *mod_legacyauth* wird hierfür allerdings nicht benötigt.
Ein Neustart des Prosody Services ist nach dem setzen dieser Einstellung zwingend **erforderlich**.
```
-- XEP-0368: SRV records for XMPP over TLS
legacy_ssl_ports = { 5223 }
```

### 3. SSL Zertifikat ( *optional* )
Hier wäre der Zeitpunkt das bestehende Zertifikat für `example.com` auf `xmpps.example.com` auszuweiten, um keinen `common name error` zu erzeugen. Dieses erweiterte Zertifikat ist dem Prosody zur Verfügung zu stellen. Die Ausstellung eines neuen LetEncrypt Zertifikats ist nach [Schritt 5: Webserver](#5-webserver) deutlich einfacher.

*Hinweis* : Dieser Teil ist vollkommen optional. Die [Prosody Dokumentation](https://prosody.im/doc/certificates) zeigt auf, dass kein Zertifikat notwendig wäre.
**IMHO** Es macht das Gesamtbild einheitlicher, wenn auch an diesem Endpunkt ein gültiges SSL Zertifikat präsentiert wird.<br>
In Section [5. Webserver](#5-webserver) gehe ich darauf noch einmal genau ein.

### 4. iptables Regeln
Für das Umleiten der Pakete wird die PREROUTING und POSTROUTING Kette von `iptables` verwendet. Dabei werden Pakete noch bevor sie überhaupt geroutet werden umgeleitet.
Dafür werden 2 Regeln verwendet um einen `malformed xml-error` zu vermeiden.
Regel Nr. 1 leitet den gesamten Traffic der zweiten IP von Port 443, ohne Veränderung an Port 5223 der ersten IP weiter.

Für die Antwort des Prosody Servers wird allerdings eine zweite Regel benötigt, die sich in der POSTROUTING Kette befindet. Diese stellt sicher, dass das Antwort-Paket wieder über Port 443 der zweiten IP Adresse den Server verlässt.<br>
*Sollte bei der Prosody Konfiguration ein anderer Port gewählt werden als der default Port, muss dieser natürlich in den iptables Regeln ausgetauscht werden.*

In diesem Beispiel ist erste_ip, jene IP-Adresse auf der auch der httpd Server lauscht. zweite_ip bezeichnet somit die zweite Adresse speziell für XMPP over TLS.
```#!/bin/bash
# PREROUTING
iptables -t nat -A PREROUTING -d zweite_ip -p tcp --dport 443 -j DNAT --to-destination erste_ip:5223

# POSTROUTING
iptables -t nat -A POSTROUTING -p tcp -d  zweite_ip --dport 5223 -j SNAT --to-source erste_ip:5223
```

Abschließend sollten diese Regeln mit `iptables-save` gespeichert werden, damit diese bei einem reboot erneut angewendet werden.
```#!/bin/bash
iptables-save > /etc/iptables/rules.v4
```

### 5. Webserver
Die Konfiguration des Webserver ist grundsätzlich nicht notwendig, macht das testen der vorgenommenen Änderungen, sowie erzeugen bzw. erweitern bestehender Zertifikate allerdings bedeutend einfacher.<br>
Im Folgenden habe ich die simpelste Möglichkeit eins vHosts angenommen. Dabei ist als Beispiel immer example.de verwendet worden.

##### nginx 
```
server {
	listen zweite_ip:80;
	server_name xmpps.example.de;
	#hier kann je nach wunsch eine weiterleitung stattfinden
	return 301 https://example.de;

	# letsencrypt love
	location ^~ /.well-known/acme-challenge/ {
    	default_type "text/plain";
	}

	location = /.well-known/acme-challenge/ {
    	return 404;
	}
}
```
##### apache2
```
<VirtualHost zweite_ip:80>
	ServerName xmpps.example.de

	# hier kann je nach wunsch eine weiterleitung stattfinden
	Redirect / https://example.de;

</VirtualHost>
```
Sind diese Änderungen vorgenommen, ist es leicht möglich via LetsEncrypt ein Zertifikat für die SubDomain auzustellen. Zusätzlich dazu ist es nun möglich direkt zu testen ob XMPP over TLS funktioniert.

## Abschluss
Sollten alle diese Schritte erfolgreich abgeschlossen sein, ist es sehr leicht möglich zu testen ob alles so funktioniert wie es soll. Hierfür lässt sich `curl -i` verwenden.
```#!/bin/bash
curl -i https://xmpps.example.com
```
**Hinweis**: Falls es an diesem Endpunkt keine gültigen Zertifikate gibt, sollte hier der Befehl `curl -ik` gewählt werden, um den TLS Error zu ignorieren.

Als Ergebnis sollte ein *xml stream error* zu sehen sein, **ohne** Apache2 / nginx header.

```xml
<?xml version='1.0'?>
<stream:stream xmlns:stream='http://etherx.jabber.org/streams' xml:lang='en' xmlns='jabber:client'>
	<stream:error>
		<not-well-formed xmlns='urn:ietf:params:xml:ns:xmpp-streams'/>
	</stream:error>
</stream:stream>
```
<span style="color:red">**Hinweis**:</span> Für das Testen via curl sollte eine andere Maschine gewählt werden. Ausgeführt auf der gleichen Maschine durchlaufen die Pakete nicht die PREROUTING bzw. POSTROUTING Kette, daher wird die Verbindung abgelehnt.