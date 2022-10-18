#!/usr/bin/env python3

import fileinput, re

instr = ""
for line in fileinput.input():
    instr += line

rex = r"[\S|\s]*Path of the secret key file:\s*([0-9a-zA-Z\/\-\.\_]+)[\S|\s]*"

match = re.match(string=instr, pattern=rex)

if bool(match):
    print(match.group(1), end="")
else:
    exit(1)

