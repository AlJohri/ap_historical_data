#!/usr/bin/env python3

import os, requests

with open("data/ids.txt") as f:
	for line in f:
		pol_id = int(line)
		filename = "%s.html" % pol_id
		filepath = "data/%s" % filename
		if os.path.isfile(filepath):
			print("%s already exists. skipping" % filename)
		else:
			url = "http://pre-election.ap.org/bios/%s" % filename
			print("downloading %s" % url)
			response = requests.get(url)
			with open(filepath, "wb") as f:
				f.write(response.content)
