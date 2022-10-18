#!/usr/bin/env python3

import fileinput, re

instr = ""
for line in fileinput.input():
    instr += line

rex = r"[\s|\S]*credentialManager[\s|\S]+contract\saddress:\s+(0x[a-zA-Z0-9]+)[\s|\S]+HealthRecords[\s|\S]+contract\saddress:\s+(0x[a-zA-Z0-9]+)[\S|\s]*"

match = re.match(string=instr, pattern=rex)

if bool(match):
    print(match.group(1))
    print(match.group(2))
else:
    exit(1)

