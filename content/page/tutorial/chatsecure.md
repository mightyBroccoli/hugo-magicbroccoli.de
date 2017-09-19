+++
type = "page"
date = "2017-07-22"
title = "Chatsecure Tutorial"
description = "How to use Chatsecure"
author = "nico"
tags = [ "Guide" ]
categories = [ "XMPP", "Chatsecure" ]
keywords = [ "MagicBroccoli XMPP", "XMPP", "Chatsecure", "Chatsecure Tutorial", "iPhone" ]
+++
**Hinweis**: _Ein Dank geht an [5222.de](//5222.de) die netterweise die Screenshots zur Verfügung gestellt haben. Da ich selbst kein iPhone besitzte wäre mir ein Tutorial sonst nicht möglich gewesen._

## 1. Account Registrierung
Zuerst muss sich ein Account erstellt werden. Dafür ist die Web Registrierung ein Anlaufpunkt.
Speziell bei **magicbroccoli.de** sollten Sie sich das Passwort unbedingt merken, da eine Wiederherstellung nur dann durchgeführt wird, wenn eine eindeutige Identifizierung des Accountbesitzers möglich ist.
Durch den Klick auf "Registrieren" akzeptieren Sie die [Nutzungsbedingungen](/termsofuse/) sowie [Datenschutzbestimmungen](/datenschutz/).
![](/images/tutorials/webregister.png)

## 2. Installation
Chatsecure lässt sich einfach über den AppStore installieren.
<center>[![ChatSecure Download](/icons/apple_appstore.png)](https://itunes.apple.com/de/app/id464200063)
[![ChatSecure Download](/icons/google_appstore.png)](https://play.google.com/store/apps/details?id=info.guardianproject.otr.app.im)</center>

## 3. Client Login
Der Login zum Chat verläuft ähnlich zu jedem anderen Client. Da bereits ein Account in [Schritt 1](#1-account-registrierung) erstellt wurde, wird _Existing Account_ (en. bestehender Account) gewählt.<br>
Daraufhin werden in den Feldern die zuvor gewählten Daten eingetragen. Ein Spitzname muss nicht eingetragen werden, ist allerdings für die Kontakte später sehr hilfreich.<br>
Alle Einstellungen unter _Erweitert_ müssen nicht verändert werden, die Standarteinstellungen sind korrekt.<br>
Beim ersten Verbindungsaufbau erscheint eine Benachrichtung dem SSL Zertifikat zu vertrauen, dies ist für den weiteren Verbindungsaufbau zwingend notwendig zu akzeptieren.
<br><img src="/images/tutorials/chatsecure/login_existing_account.png" width="25%"><img src="/images/tutorials/chatsecure/login_creds.png" width="25%"><img src="/images/tutorials/chatsecure/login_trustssl.png" width="25%"><img src="/images/tutorials/chatsecure/login_successfull.png" width="25%">

## 4. Settings
Unter den Einstellungen von Chatsecure befinden sich einige Möglichkeiten, die sehr nützlich für den Chat Alltag sind.
Neben den aktiven Konten gibt es dort die Möglichkeit, die verwendeten Zertifkate einzusehen und zu kontrollieren. Außerdem ist es möglich eine automatisch Löschung der Nachrichten zu aktivieren. Je nach Belieben ist es damit möglich beim Trennen der Verbindung oder verlassen des Gesprächs alle Nachricht im Verlauf zu löschen.<br>
Das kleine gelbe Warndreieck symbolisiert, das ein Feature des Server verwendet wird diese aber Probleme hat. Sehr häufig handelt es sich hierbei um die Push Notifications.
<br><img src="/images/tutorials/chatsecure/settings.png" width="33%"><img src="/images/tutorials/chatsecure/settings_konto.png" width="33%"><img src="/images/tutorials/chatsecure/settings_profile.png" width="33%">
Unter _Meine Schlüssel verwalten_ ist es möglich seine eigenen Omemo Schlüssel zu akzeptieren oder zu misstrauen.

## 5. Plugins
Bei Plugins ist Chatsecure sehr nah an Conversations dran. Viele Einstellungen werden automatisch vom Server übernommen und müssen vom Benutzer gar nicht bedacht werden. Einige Einstellungen müssen, um den Betrieb möglichst reibungslos zu gewährleisten, von Hand einmalig eingestellt werden.

### 5.1 Push Notifications
Push Benachrichtigungen sind ein sehr nützliches Feature welches nicht alle Server Anbieter anbieten. Beim ersten verbinden erfragt das Telefon automatisch die verfügbaren Serverfeatures. Sollte sich darunter Push befinden, wird Ihr Telefon sie folgendes Fragen.
<br><img src="/images/tutorials/chatsecure/push_enable_1.png" width="50%"><img src="/images/tutorials/chatsecure/push_enable_2.png" width="50%">
Um erfolgreich Push Benachrichtigungen zu erhalten ist es notwendig beide Fragen zu akzeptieren. Diese Frage wird einmalig pro Account gestellt.
Es ist möglich die Erlaubnis in den Einstellungen zurückzusetzten oder sogar ganz zu verbieten.

### 5.2 Omemo
Das aktivieren von Omemo ist sehr einfach und schnell erledigt. Über das Profil ( Erreichbar über das kleine i oben rechts ) lässt sich über _Erweiterte Verschlüsselungseinstellungen_ auswählen welches Verfahren gewünscht ist.<br>
Dabei ist _Beste verfügbare_ die optimalste Option. Wichtig ist hierbei, dass dies eine Änderung ist die nur für diesen Kontakt gilt.<br>
Wenn der Account mobil genutzt wird ist Omemo definitiv die bessere Wahl, da die Verbindungsqualität bei OTR sehr sensibel ist.
<br><img src="/images/tutorials/chatsecure/omemo_profile.png" width="33%"><img src="/images/tutorials/chatsecure/omemo_enable_encrypt.png" width="33%"><img src="/images/tutorials/chatsecure/omemo_chat.png" width="33%">

## 6. Nützliche Links
Einige Webseiten die weitergehende Informationen zur Verfügung stellen.

#### Allgemein
- [ChatSecure Homepage](https://chatsecure.org/)
- [ChatSecure Github Repository](https://github.com/chatsecure)

[Zurück zur Übersicht](/xmpp/)

- - -
Last Edit 13.10.17
