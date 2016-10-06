#!/usr/bin/env python3

import re, csv, os, lxml.html

def remove_extra_spaces(s):
	return re.sub("\s\s+", " ", s).strip()

def process_name(name):

	name = remove_extra_spaces(name)

	nickname = ''
	nicknamecheck = re.search("^.*'(.*)'.*$", name)
	if nicknamecheck:
		nickname = nicknamecheck.groups()[0]
		name = name.replace("'%s'" % nickname, "")
	name = remove_extra_spaces(name)

	suffix = ''
	suffixcheck = re.search("^.*(I|II|III|IV|Jr\.|Sr\.)$", name)
	if suffixcheck:
		suffix = suffixcheck.groups()[0]
		name = name.replace(suffix, "")
	name = remove_extra_spaces(name)

	return name, nickname, suffix

rows = []

filenames = [x for x in os.listdir("data") if ".html" in x]
for filename in filenames:
	pol_id = int(filename.replace(".html", ""))
	filepath = "data/%s" % filename
	with open(filepath) as f:
		doc = lxml.html.fromstring(f.read())

		if doc.cssselect(".preeln-entitypic"):
			nametag = doc.cssselect('.preeln-entityname')[0]
			name = nametag.text
			party = nametag.tail.replace("(", "").replace(")", "").strip()
			name = remove_extra_spaces(name)

			name, nickname, suffix = process_name(name)

		elif doc.cssselect("h2.preeln-secthead"):
			raw_name = doc.cssselect("h2.preeln-secthead")[0].text
			name, party = raw_name.strip().split("\n")
			party = party.replace("(", "").replace(")", "").strip()

			name, nickname, suffix = process_name(name)

		row = [pol_id, name, nickname, suffix, party]
		rows.append(row)

rows.sort(key=lambda x: x[0])
with open("data/pol_ids.csv", "w") as f:
	writer = csv.writer(f)
	writer.writerow(['pol_id', 'name', 'nickname', 'suffix', 'party'])
	writer.writerows(rows)
