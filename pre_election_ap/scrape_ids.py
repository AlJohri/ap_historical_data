#!/usr/bin/env python3

import requests, lxml.html, csv

ap_ids = []

response = requests.get("http://pre-election.ap.org/bios/")
doc = lxml.html.fromstring(response.content)

ap_ids = [atag.get('href').replace(".html", "") for atag in doc.cssselect("body pre a") if ".html" in atag.get('href')]
with open("data/ids.txt", "w") as f:
    f.write("\n".join(ap_ids))
