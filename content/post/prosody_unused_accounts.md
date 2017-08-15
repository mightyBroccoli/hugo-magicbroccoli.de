+++
date = "2017-06-30T16:25:00+02:00"
title = "Prosody Unused Accounts"
sidemenu = "true"
description = "Prosody Database Maintenance Skript"
tags = [ "Prosody", "Database", "Maintenance" ]
topics = [ "Development", "bash" ]
draft = true
+++








```bash
#!/bin/bash
#
# script to automatically delete registerd but unused accounts after x days
# dependencies
# prosody >= 0.9
# mod_storage_sql
# mod_lastlog

mysqluser=prosody user
mysqlpass=secret_passwort123
prosodydb=prosodydatabase
prosodytbl=prosodytable
maintenancetbl=maintenance


# collect the users who registered and never logged in
mysql -u $mysqluser --password=$mysqlpass -e "CREATE TABLE $prosodydb.$maintenancetbl SELECT * FROM $prosodydb.$prosodytbl WHERE value = 'registered' AND key = 'event'"

mysql -u $mysqluser --password=$mysqlpass -e "INSERT INTO $prosodydb.$maintenancetbl SELECT * FROM $prosodydb.$prosodytbl WHERE value = 'registered' AND key = 'event'"
```
