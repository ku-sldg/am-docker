#!/usr/bin/env python3

import fileinput, re

instr = ""
for line in fileinput.input():
    instr += line

rex = r"[\S|\s]*Public address of the key:\s*(0x[a-zA-Z0-9]+)[\S|\s]*"

match = re.match(string=instr, pattern=rex)

if bool(match):
    print(match.group(1)[2:], end="")
else:
    exit(1)

