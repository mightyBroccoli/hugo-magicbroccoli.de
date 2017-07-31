+++
date = "2017-07-31"
title = "We support Omemo"
sidemenu = "true"
description = "Stellungnahme zur aktuellen Entwicklung um Omemo"
tags = [ "Prosody" , "Omemo" , "XMPP" ]
categories = [ "Prosody" , "Omemo" ]
author = [ "nico" ]
+++
Hallo zusammen,

Daniel Gultsch hat vor ein paar Tagen die [Compliance Liste](https://gultsch.de/compliance_ranked.html) um die Spalte *XEP-0384: OMEMO Encryption* erweitert. Derzeit suggeriert diese, auf Grund einer fehlenden Erklärung, das nur conversations.im OMEMO Encryption unterstützen würde. Dies entspricht natürlich nicht der Wahrheit.  

Hintergrund ist, dass [Daniel Gultsch empfiehlt](https://twitter.com/iNPUTmice/status/888826898335322113), das das [PEP-Modul](https://xmpp.org/extensions/xep-0163.html) der Server [publish-options](https://xmpp.org/extensions/xep-0060.html#publisher-publish-options) unterstützen sollte ([ausführlichere Beschreibung](https://gist.github.com/iNPUTmice/7c52785ed69787516abb60e31703dbd2)). Dies bewirkt, dass User in Conversations ab Version 1.20+, auch Personen verschlüsselt anschreiben kann, ohne sie vorher in seinen Roster hinzufügen zu müssen. Auch wir finden dieses Feature gut und würden es gern unterstützen, allerdings unterstützt das PEP Modul von prosody publish-options derzeit noch nicht.  

Herr Gultsch selbst, schreibt an mehreren Stellen, dass es sich hierbei um **kein** [Security Risiko](https://github.com/iNPUTmice/ComplianceTester/issues/112#issuecomment-319008031), handelt, sondern lediglich um ein [Usability Problem](https://github.com/iNPUTmice/ComplianceTester/issues/112#issuecomment-319008031). Das heißt, dass es sich nicht um eine Vorraussetzung handelt, sondern um eine Empfehlung.{{< tweet 888826898335322113 >}}
[Der Vorschlag](https://github.com/iNPUTmice/ComplianceTester/issues/112) eine kurze Erklärung zu der Spalte in seiner Liste hinzuzufügen, da das ganze sonst so eine falsche Aussage über die Server wiederspiegelt, wurde mit den folgenden Sätzen einfach ignoriert und das Ticket geschlossen:

> While not a security problems the lack of publish-options is a huge usability problem as this limits OMEMO to contacts you have mutual presence subscription with.
> Conversations users will except OMEMO to work with everyone. That’s why Conversations requires publish-options.

Hauptproblem hierbei ist, das die Darstellung für alle Server sehr „rufschädigend“ sein kann. Ich und einige andere Hoster haben versucht Daniel Gultsch darauf aufmerksam zu machen, dies wird von ihm allerdings komplett ignoriert.

*Lange Rede kurzer Sinn* – Ihr könnt mit Conversations und anderen Clients weiterhin OMEMO über unseren und die anderen Server verwenden, nur eben derzeit noch ohne das Feature Kontakte außerhalb eurer Kontaktliste direkt verschlüsselt anzuschreiben, ohne diese vorher zu adden.


**Danke geht an Sebiastian von [5222.de](https://blog.5222.de/compliance-liste-wir-unterstuetzen-omemo/) für die Textgrundlage.**
