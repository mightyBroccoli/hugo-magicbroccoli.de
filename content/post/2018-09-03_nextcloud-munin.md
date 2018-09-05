+++
type = "post"
date = "2018-09-03T02:30:00+02:00"
title = "Nextcloud Munin Plugin"
author = "nico"
description = ""
keywords = [ "nextcloud", "munin", "munin-plugin", "rrd", "external-api" ]
tags = [
	"mildly-useful"
]
categories = [ "Nextcloud" ]
banner = "/banner/nextcloud-munin.png"
slug = "nextcloud-munin"
+++
# basic idea
For a longer period of time I was looking for a Munin plugin to monitor the activity, especially the user activity on my cloud instance. There are some plugins out there, but most of them depend on externally querying the database.<br>
With the [External API](https://docs.nextcloud.com/server/13/developer_manual/core/externalapi.html) and the [server info dashboard](https://github.com/nextcloud/serverinfo) Nextcloud itself presents an endpoint to gather data from. This way the database action is handled by the cloud and I can just grab the data from the endpoint. 

## why python?
I choose python to utilize the immensely strong [requests](https://github.com/requests/requests) module. In addition to that no extra json dump was necessary to work with the data which made the data extraction really easy.
```
# init requests session with specific header and credentials
s = requests.Session()
s.auth = auth
s.headers.update({'Accept': 'application/json'})

# request data from api
r = s.get(URL)
api_response = r.json()
```
In this example `auth` and `url` are passed as variables which were defined earlier in the plugin to specific environment variables. All together those 5 lines do the complete request and conversion to json action of the plugin.

## Munin config
On running the plugins for the first time Munin will correctly recognize the configuration, even if the URL and authentication information is not set up until that point.

### configuration
Both plugins need essentially the same configuration added to the the plugin-config `/etc/munin/plugin-config.d/munin-node`.
```
[nextcloud_*]
url = https://URL.TO.YOUR.NEXTCLOUD.tld/ocs/v2.php/apps/serverinfo/api/v1/info
username = username
password = password or logintoken
```

## results
If all necessary configuration parameters are set the resulting graphs should look something like this.
<br><img src="/images/posts/2018-09-03_nextcloud-munin/graph_share.png" width="50%"><img src="/images/posts/2018-09-03_nextcloud-munin/graph_user.png" width="50%">

---
Github : [nextcloud-munin-py](https://github.com/mightyBroccoli/nextcloud-munin-py)