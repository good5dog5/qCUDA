#!/usr/bin/env python3
# Jordan huang<good5dog5@gmail.com>

import os
import sys
import subprocess
import re
from subprocess import Popen, PIPE

time_to_run = 15
def run(val):
    CMD = ['./exe/vectorAdd'] + [str(val)]
    p = Popen(CMD, shell=False, stdout=PIPE, stderr=PIPE, stdin=PIPE)
    stdout, stderr = p.communicate()

    return stdout, stderr
if __name__ == '__main__':
    
    # val = [32000000, 64000000, 1280000000, 256, 512, 1024, 2048, 4096]
    val = [1,2,4,8,16,32,64,128,256]
    val = [i * (10**6) for i in val]
    

    for v in val:

        d = dict()
        time_sum = 0.0

        for i in range(time_to_run):
            d = dict()
            out, err = run(v)

            # 2.88 msec
            exec_time_str = re.findall(b'\d+.\d+\ msec', out)[0].decode('utf-8')
            time_sum      += float(re.findall('\d+.\d+', exec_time_str)[0]) 


        d['size'] = str(v)
        d['time'] = time_sum / time_to_run
        print(d)

    

