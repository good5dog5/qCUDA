#!/usr/bin/env python3
# Jordan huang<good5dog5@gmail.com>

import os
import sys
import subprocess
import unittest
import re
from subprocess import Popen, PIPE
import shlex

if __name__ == '__main__':
    CMD = ['./exe/{0}'.format('cudaPointerTest')] + list([str(400), str(3)])
    print(CMD)
    # p = Popen('./exe/cudaPointerTest 400 0', shell=True, stdout=PIPE, stderr=PIPE, stdin=PIPE)
    cmd = "./exe/cudaPointerTest 400 0"
    CMD = shlex.split(cmd)
    p = Popen(CMD, shell=False, stdout=PIPE, stderr=PIPE, stdin=PIPE)
    stdout, stderr = p.communicate()
    print(stdout, stderr)

