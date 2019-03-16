#!/usr/bin/env python3
# Jordan huang<good5dog5@gmail.com>

import os
import sys
import subprocess
import re
from subprocess import Popen, PIPE

time_to_run = 15
def run(wA, hA, wB, hB):
    CMD = ['./exe/matrixMul'] + ['-wA={0}'.format(str(wA)), '-hA={0}'.format(str(hA)), '-wB={0}'.format(str(wB)), '-hB={0}'.format(str(hB)) ]
    p = Popen(CMD, shell=False, stdout=PIPE, stderr=PIPE, stdin=PIPE)
    stdout, stderr = p.communicate()

    return stdout, stderr
if __name__ == '__main__':
    
    val = [32, 64, 128, 256, 512, 1024, 2048, 4096]

    for v in val:

        d = dict()
        time_sum = 0.0

        for i in range(time_to_run):
            d = dict()
            out, err = run(v, v, v, v,)

            # 2.88 msec
            exec_time_str = re.findall(b'\d+.\d+\ msec', out)[0].decode('utf-8')
            time_sum      += float(re.findall('\d+.\d+', exec_time_str)[0]) 


        d['size'] = str(v)
        d['time'] = time_sum / time_to_run
        print(d)

    

