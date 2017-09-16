+++
type = "post"
date = "2017-08-06T15:00:00+02:00"
title = "XMPP over TLS Tutorial"
author = "nico"
description = ""
keywords = [ "TeamSpeak Script", "XEP-0368", "XMPP" ]
tags = [ "XMPP", "Prosody", "Guide" ]
categories = [ "XEP-0368", "Prosody", "XMPP" ]
banner = ""
+++
## How to setup XEP-0368
### Was ist XEP-0368
Bei [XEP-0368](https://xmpp.org/extensions/xep-0368.html) handelt es sich um ein Verfahren von XMPP-Clients, über SRV Einträge im DNS, alternative Verbindungsmöglichkeiten zu entdecken, falls die regulären Wege blockiert sind, zb. durch Firewalls.

<blockquote cite="https://xmpp.org/extensions/xep-0368.html">XMPP Core specifies the use of xmpp-client/xmpp-server SRV records as the method of discovering how to connect to an XMPP server. This XEP extends that to include new xmpps-client/xmpps-server SRV records pointing to direct TLS ports and combine priorities and weights as if they were a single SRV record similar to RFC 6186. It also provides an easy way for clients to bypass restrictive firewalls that only allow HTTPS, for servers to host multiple protocols/services on a single port, and for servers and clients to take advantage of less round trips and existing direct TLS loadbalancers.</blockquote>

### Was wird benötigt?
- Prosody Server
- **optional** gültiges SSL Zertifikat ( LetsEncrypt / oä )
- 2 IPv4 Adressen ( **Hinweis beachten** )
- iptables und iptables-persistent
- **optional** Webserver
- Kontrolle über eure DNS Zone

<span style="color:red">*Hinweis*: Notwendigkeit 2 IPv4 Adressen</span>
Es werden 2 IP Adressen benötigt wenn Ihre IP Adresse bereits auf Port 443 lauscht. Sprich eine **https** Website via Apache2 / nginx hostet. Da für diese Methode der Port verpflichtend benötigt wird. Ist dies nicht der Fall reicht eine IP Adresse vollkommen aus.

- - -

### 1. DNS Einstellungen
Den Anfang machen die DNS Einstellungen, da die Publizierung der neuen DNS Einstellungen bis zu 48 Stunden dauern kann.
Zusätzlich zu den [Standard SRV Einträgen](https://prosody.im/doc/dns) wird ein weiterer `_xmpps-client._tcp` Eintrag benötigt, sowie ein A Record für die Subdomain.

In diesem Beispiel ist die Domain `example.com` und XMPP over TLS soll über `xmpps.example.com` erreichbar sein.

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
In der Prosody Konfiguration muss *legacy_ssl_ports* definiert werden. Damit das `http` Modul auch auf dem gewählten Port lauschen soll. *mod_legacyauth wird hierfür nicht benötigt.*
Ein Neustart des Prosody Services ist nach dem setzen dieser Einstellung **erforderlich**.
```
-- XEP-0368: SRV records for XMPP over TLS
legacy_ssl_ports = { 5223 }
```

### 3. SSL Zertifikat ( *optional* )
Hier wäre der Zeitpunkt das bestehende Zertifikat für `example.com` auf `xmpps.example.com` auszuweiten, um keinen `common name error` zu erzeugen. Dieses erweiterte Zertifikat ist dem Prosody zur Verfügung zu stellen.

*Hinweis* : Dieser Teil ist vollkommen optional. Die [Prosody Dokumentation](https://prosody.im/doc/certificates) zeigt auf, dass kein Zertifikat notwendig wäre.
**IMHO** Es macht das Gesamtbild einheitlicher, wenn auch diesem Endpunkt ein gültiges SSL Zertifikat präsentiert wird.<br>
In Section [5. Webserver](#5-webserver) gehe ich darauf noch einmal genau ein.

### 4. iptables Regeln
Für das Umleiten wird die PREROUTING und POSTROUTING Kette von `iptables` verwendet. Dabei werden Pakete, noch bevor sie überhaupt geroutet werden, umgeleitet.
Dafür werden 2 Regeln verwendet um einen `malformed xml-error` zu vermeiden.
Regel Nr. 1 leitet den gesamten Traffic der zweiten IP der auf Port 443 ankommt, ohne Veränderung an Port 5223 der ersten IP weiter.

Für die Antwort des Prosody Servers wird allerdings eine zweite Regel benötigt, die sich in der POSTROUTING Kette befindet. Diese stellt sicher das, dass Antwort Paket auch wieder über Port 443 der zweiten IP Adresse den Server verlässt und nicht mit 5223.
*Sollte bei der Prosody Konfiguration ein anderer Port gewählt werden als der default Port, muss dieser natürlich in den iptables Regeln ausgetauscht werden.*

In diesem Beispiel ist $erste_ip, die IP auf der auch der httpd Server lauscht. zweite_ip bezeichnet daher die zweite Adresse für XMPP over TLS.
```#!/bin/bash
# PREROUTING
iptables -t nat -A PREROUTING -d zweite_ip -p tcp --dport 443 -j DNAT --to-destination $erste_ip:5223

# POSTROUTING
iptables -t nat -A POSTROUTING -p tcp -d  zweite_ip --dport 5223 -j SNAT --to-source $erste_ip:5223
```

Abschließend lassen sich diese Regeln mit `iptables-save` speichern, damit bei einem reboot die Regeln wieder geladen werden.
```#!/bin/bash
iptables-save > /etc/iptables/rules.v4
```

### 5. Webserver
Die Konfiguration des Webserver ist grundsätzlich nicht notwendig, macht das testen der vorgenommenen Änderungen allerdings bedeutend einfacher.<br>
Im Folgenden habe ich die simpelste Möglichkeit eins vHosts angenommen. Dabei ist als Beispiel immer example.de genommen worden.

##### nginx 
```
server {
	listen zweite_ip:80;
	server_name xmpps.example.de;
	#hier kann je nach wunsch eine weiterleitung stattfinden
	return 301 https://example.de;

	# letsnecrypt love
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
Sind diese Änderungen vorgenommen ist es leicht möglich via LetsEncrypt ein Zertifikat für die SubDomain auzustellen. Zusätzlich dazu ist es nun möglich direkt zu testen ob XMPP over TLS funktioniert.

## Abschluss
Sollten alle diese Schritte erfolgreich abgeschlossen sein. Ist es sehr leicht möglich herauszufinden, ob alles so funktioniert wie es soll. Dafür lässt sich `curl -i` verwenden.
```#!/bin/bash
curl -i https://xmpps.example.com
```
**Hinweis**: Falls es keine gültigen Zertifikate gibt, sollte hier der Befehl `curl -ik` gewählt werden um den TLS Error zu ignorieren.

Als Ergebnis sollte ein *xml stream error* zu sehen sein, **ohne** Apache2 / nginx header. Ist außerdem keine Fehlermeldung über ein ungültiges SSL Zertifikat dabei ist das Zertifikat auch für die Subdomain gültig und funktioniert.

```xml
<?xml version='1.0'?>
<stream:stream xmlns:stream='http://etherx.jabber.org/streams' xml:lang='en' xmlns='jabber:client'>
	<stream:error>
		<not-well-formed xmlns='urn:ietf:params:xml:ns:xmpp-streams'/>
	</stream:error>
</stream:stream>
```
<span style="color:red">**Hinweis**:</span> Für das Testen via curl sollte eine anderer Host gewählt werden. Wenn dieser auf der Maschine, die die iptables und Prosody hostet, ausgeführt wird, durchlaufen die Pakete nicht die PREROUTING bzw. POSTROUTING Kette daher wird die Verbindung nicht möglich sein.