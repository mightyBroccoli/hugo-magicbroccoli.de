+++
type = "post"
date = "2018-03-30T13:37:00+02:00"
title = "Let's Encrypt Prosody Cert Hook"
author = "nico"
description = ""
keywords = [ "Prosody", "LetsEncrypt" ]
tags = [
	"maintenance",
	"mildly-usefull"
]
categories = [ "Prosody" ]
banner = "/banner/certbot-logo-1A.svg"
slug = "letsencrypt prosody cert hook"
+++
### Prosody + Let's Encrypt certificates
As of right now Prosody is not able to update a live certificate while running. For the complete update it is necessary to restart Prosody, which is inconvenient.<br>
With the [telnet console](https://prosody.im/doc/console) however, it is possible to reload the config such that a changed certificate is updated correctly. The biggest problem lies in reloading all possible locations the "old" certificate is still active in. I use the Prosody Telnet console to invoke a reload, due to the fact that `prosodyctl reload` is not actually reloading the modules just the config.<br>
For this matter I hacked together a little bash script, which together with the [Let'sEncrypt's certbot](https://certbot.eff.org/) and the default letsecrypt cli is used to import and update the Prosody certificate without a need to restart the instanc.

### Let'sEncrypt Setup
To use this script in a fully automatic way some configuration is needed.
On install Let'sEncrypt creates the directory `renewal-hooks`. Inside there are three subfolders which represent the time and/or occasion for invocation ([source](https://certbot.eff.org/docs/using.html#renewing-certificates)). This script uses the deploy hook to only run when the certificate is actually renewed. As I am not checking the domain name after deployment it is needed to add another subdirectory to the deploy directory.

{{< highlight bash >}}
/etc/letsencrypt/renewal-hooks/
└── deploy
    └── example.de
        └── prosody.sh
{{< /highlight >}}

#### Deploy-Hook
In this example code the hook is placed inside the `example.de` folder as `prosody.sh`. The script first imports the defined list of domains from the Let's Encrypt live directory. After this is finished reloading takes place. The import is done as described in the [Prosody Documentation](https://prosody.im/doc/letsencrypt).

{{< highlight bash >}}
#!/bin/bash

### Prosody Cert Import ###
# active domains
domains=("example.de" "example.com")

# import the new certs
for domain in "${domains[@]}"; do
	prosodyctl --root cert import $domain /etc/letsencrypt/live
done

# modules needing to be reloaded
modules=("s2s" "c2s" "http" "tls")

# loop over commands
(
for command in "${modules[@]}"; do
        echo "module:reload([[$command]])"
done
echo "config:reload()"
echo quit
)| nc localhost 5582 &>/dev/null

# exit gracefully
exit 0
{{< /highlight >}}

### Let'sEncrypt Renewal config
At this time certbot would not run any deploy hook after renewing a certificate. The default configuration invokes `/bin/run-parts` on the predefined folders `pre`, `post` and `deploy`. To run the script on deployment it is needed to add the directory to the renew config file of your domain. For this example I choose to use example.de which would resolve to `/etc/letsencrypt/renewal/example.de.conf`.

{{< highlight bash >}}
[renewalparams]
...
renew_hook = /bin/run-parts /etc/letsencrypt/renewal/example.de
...
{{< /highlight >}}

### TODO
- Prosody archives the "old" certificates when importing a new one. After a while the directory is pretty cluttered.
- implement $RENEWED_DOMAINS test to deploy hook without the need to reconfigure
