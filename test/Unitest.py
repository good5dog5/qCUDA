#!/usr/bin/env python3
# Jordan huang<good5dog5@gmail.com>

import os
import sys
import subprocess
import unittest
import re
from config import expected_results
from subprocess import Popen, PIPE

def execute_cuda_program(prg_name, *args):
    CMD = ['./' + prg_name] + list(args)
    p = Popen(CMD, shell=True, stdout=PIPE, stderr=PIPE, stdin=PIPE)
    stdout, stderr = p.communicate()

    return stdout, stderr

def isPass(prg_name, prg_stdout):
    for requirement in expected_results[prg_name]:
        if len(re.findall(requirement.encode(), prg_stdout)) == 0:
            print("[{}] {} not satisfied".format(prg_name, requirement))
            return False
    return True


class qCUDATest(unittest.TestCase):

    def test_vectorAdd(self):
        sout, serr = execute_cuda_program('vectorAdd')
        self.assertTrue(isPass('vectorAdd', sout))

    def test_matrixMul(self):
        sout, serr = execute_cuda_program('matrixMul')
        self.assertTrue(isPass('matrixMul', sout))

    def test_cudaGetDeviceCount(self):
        sout, serr = execute_cuda_program('cudaGetDeviceCount')
        self.assertTrue(isPass('cudaGetDeviceCount', sout))




if __name__ == '__main__':
    unittest.main()


