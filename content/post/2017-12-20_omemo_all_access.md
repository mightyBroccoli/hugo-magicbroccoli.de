+++
type = "post"
date = "2017-12-20T10:00:00+02:00"
title = "Omemo Complicance"
author = "nico"
description = ""
keywords = [ "Omemo", "xep-0384", "omemo_all_access", "Prosody", "publish-options", "Daniel Gultsch" ]
tags = [
	"omemo",
	"xep-0384",
	"publish-options",
	"omemo_all_access"
]
categories = [ "Prosody", "XMPP" ]
banner = "/images/posts/2017-12-20_omemo_all_access/omemo_logo.png"
slug = "Omemo Complicance"
+++
Seit gestern ist auf meinem Server ein neues OMEMO Modul aktiviert. Dieses ermöglicht es OMEMO verschlüsselte Konversationen zu beginnen, ohne das dafür eine gegenseitige presence subscription bestehen muss. Desweiteren hat dies Auswirkungen auf Chaträume, da es nun möglich ist in einem Chatraum OMEMO zu aktivieren ohne das sich alle Parteien hinzugefügt haben.

{{< tweet 943181435120340992 >}}

Dieses Modul wird bereitgestellt von Daniel Gultsch ( Entwickler der App [Conversations](https://conversations.im/) ) und steht auf GitHub unter {{< github "iNPUTmice/omemo_all_access" >}} zur Verfügung. Vielen Dank an Daniel! Dies ist ein weiter wichtiger Schritt in Richtung *OMEMO by default*.
