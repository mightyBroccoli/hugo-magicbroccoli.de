+++
type = "post"
date = "2017-10-02T13:30:00+02:00"
title = "Prosody housekeeping"
author = "nico"
description = ""
keywords = [ "Prosody", "mod_mam", "MariaDB", "unused accounts", "old accounts", "xep-0313" ]
tags = [
	"xep-0313",
	"MariaDB",
	"maintenance",
	"mildly usefull"
]
categories = [ "Bash", "XMPP", "Prosody", "Guide" ]
banner = "/banner/prosody.png"
slug = "Prosody housekeeping"
+++
# Grundidee
Ich habe mich in den letzen paar Tagen damit beschäftigt Dinge rund um den Prosody Server zu automatisieren.
Daher möchte ich hier einfach mal meine Lösung einiger kleiner Probleme vorstellen.

# Problem
Das grundsätzliche Problem, welches so ziemlich alle Server mit offener Registrierung teilen, sind Zombie Accounts. Sprich Accounts die erstellt wurden, allerdings nie verwendet werden. Oder Accounts die erstellt wurden und irgendwann von ihrem Nutzer/in nicht mehr verwendet werden. Solche Accounts verursachen eine vermeidbare Last für das System.<br>
Die zweite größere Quelle liegt in einem Problem Prosodys Dateien oder Datenbank Einträge korrekt bzw. überhaupt zu löschen. Namentlich sind hier [mod_http_upload](https://modules.prosody.im/mod_http_upload.html) und [mod_mam](https://modules.prosody.im/mod_mam.html) zu nennen.
Vor allem bei dem Modul mam bestehen Probleme, da die Einträge eines jeden Users einzeln bearbeitet werden. Daher steigt die Bearbeitungszeit bei größeren Userzahlen enorm an.

# Lösungsansatz
Als Lösungsansatz habe ich ein einfaches Skript geschrieben, das tägliche "housekeeping" Aufgaben für mich übernimmt.<br>
[Thomas Leister](https://thomas-leister.de/) hat vor einiger Zeit einen sehr ähnlichen [Lösungsansatz](https://thomas-leister.de/prosody-inaktive-accounts-loeschen) veröffentlicht, den ich in meinem Skript erweitert habe, um ihn vollständig zu automatisieren.<br>
Das im Folgenden beschriebene Skript steht auf [Github](https://github.com/mightyBroccoli/prosody_housekeeping) zur Verfügung.

**WARNUNG**: Das Skript verfügt über einen _configtest_; durch das ausführen mit `--configtest` oder `-t` werden alle Filter angewendet, ohne das Einträge gelöscht werden. So ist es möglich anschauenlich zu sehen was bei einem ausführen passiert wäre. Es ist äußerste Vorsicht geboten beim konfigurieren des Skripts, daher ist ein testen der Konfiguration sehr empfohlen.

# Skript
Das Skript arbeitet nacheinander alle diese Probleme ab und beseitigt diese Probleme in mehreren Schritten ohne das Usereingaben notwendig sind.<br>

## Konfiguration
Für die Verwendung des Skriptes werden zwei Module benötigt. Diese sollten im Modul Verzeichnis von Prosody vorhanden sein.

- [mod_list_inactive](https://modules.prosody.im/mod_list_inactive.html)
- [mod_lastlog](https://modules.prosody.im/mod_lastlog.html)

mod_lastlog lässt sich einfach in die modules_enabled{} Sektion der Prosody Konfiguration eintragen. Für das Modul ist keine weitere Konfiguration notwendig.
Der einfachste Weg ist, das gesamte Mercurial Archiv der Community Module zu klonen und in der Prosody Konfiguration zu referenzieren. Eine Anleitung wie das geht findet sich in der Prosody [Dokumentation](https://prosody.im/doc/installing_modules#prosody-modules).<br>

Nun sollte im Skript selbst, über die Variabeln, eingestellt werden was für Zeiteinheiten gewünscht sind. Außerdem sollten eventuell abweichende Pfade auf die jeweiligen Systemverhältnisse angepasst werden.<br>
Der Folgende Abschnitt zeigt einen Ausschnitt aus dem Skript, welcher die Konfigurationsvariablen, die Filter sowie den `--configtest` catch zeigt.
{{< highlight bash >}}
#!/bin/bash

###### CONFIGURATION ######
# configuration variables
tmp_directory=/tmp/prosody/
junk_to_delete=$tmp_directory/accounts_to_delete.txt

# maximum timeframe for accounts registered but not logged in
# needs to be in the syntax 1day 2weeks 3months 4years
unused_accounts_timeframe="14days"
# maxium timeframe for accounts since last login
old_accounts_timeframe="1year"

# maximum age of mod_mam messags stored in the database
enable_mam_clearing=false
# needs to be in mysql syntax 1 DAY 2 MONTH 3 YEAR
mam_message_live="2 MONTH"

# prosody mysql login credentials
prosody_db_user="prosody"
prosody_db_password="super_secret-password1337"

# http upload path
http_upload_path="/var/lib/prosody/http_upload"
# http upload lifetime in days
http_upload_expire="31"

catch_configtest()
{
	# test your configuration first to see what would have be deleted
	if [ "$1" == "-t" ] || [ "$1" == "--configtest" ]; then
		filter_unused_accounts
		filter_old_accounts
		filter_mam_messages --test

		cat $junk_to_delete
		exit
	fi
}

###### FILTER SECTION ######
filter_unused_accounts()
{
	# filter all registered but not logged in accounts older then $unused_accounts_timeframe
	prosodyctl mod_list_inactive magicbroccoli.de "$unused_accounts_timeframe" event | grep registered | sed 's/registered//g' | sed -e 's/^/prosodyctl deluser /' >> $junk_to_delete
}

filter_old_accounts()
{
	# filter all inactive accounts older then $old_accounts_timeframe
	prosodyctl mod_list_inactive magicbroccoli.de "$old_accounts_timeframe" | sed -e 's/^/prosodyctl deluser /' >> $junk_to_delete
}

filter_mam_messages()
{
	# only run this filter if $enable_mam_clearing is set to true
	if [ "$enable_mam_clearing" = "true" ]; then
		# catch config test
		if [ "$1" = "--test" ]; then
			# this is currently a workaround caused by the extrem slowness of prosodys own clearing mechanism
			# filter all expired mod_mam messages from archive
			echo "SELECT * FROM prosody.prosodyarchive WHERE \`when\` < UNIX_TIMESTAMP(DATE_SUB(curdate(),INTERVAL $mam_message_live));" | mysql -u $prosody_db_user -p$prosody_db_password &>> $junk_to_delete
			return 1
		fi
		# this is currently a workaround caused by the extrem slowness of prosodys own clearing mechanism
		# delete all expired mod_mam messages from archive
		echo "DELETE FROM prosody.prosodyarchive WHERE \`when\` < UNIX_TIMESTAMP(DATE_SUB(curdate(),INTERVAL $mam_message_live));" | mysql -u $prosody_db_user -p$prosody_db_password
	fi
}

filter_expired_http_uploads()
{
	# currently a workaround as the mod_http_uploud is not removing the folder which holds the file
	find $http_upload_path/* -maxdepth 0 -type d -mtime +$http_upload_expire | sed -e 's/^/rm -rf /' >> $junk_to_delete
}
{{< /highlight >}}
