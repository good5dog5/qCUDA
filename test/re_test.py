#!/usr/bin/env python3
# Jordan huang<good5dog5@gmail.com>

import os
import sys
import subprocess
import re

if __name__ == '__main__':
    out = '[Vector addition of 1000000 elements]\nCopy input data from the host memory to the CUDA device\nCUDA kernel launch with 3907 blocks of 256 threads\nCopy output data from the CUDA device to the host memory\nTest PASSED\ntime taken 188.919 msec\nDone\n'
    
    print(re.findall('\d+.\d+\ msec', out))

