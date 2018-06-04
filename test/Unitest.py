#!/usr/bin/env python3
# Jordan huang<good5dog5@gmail.com>

import os
import sys
import subprocess
import unittest
import re
from config import expected_results
from subprocess import Popen, PIPE

# EXE_PATH='exe'

def execute_cuda_program(prg_name, *args):
    CMD = ['./exe/' + prg_name] + list(args)
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

    def setup(self):
        os.chdir('exe')
        print(os.abspath('.'))


    def test_vectorAdd(self):
        sout, serr = execute_cuda_program('vectorAdd')
        self.assertTrue(isPass('vectorAdd', sout))

    def test_matrixMul(self):
        sout, serr = execute_cuda_program('matrixMul')
        self.assertTrue(isPass('matrixMul', sout))

    def test_clock(self):
        sout, serr = execute_cuda_program('clock')
        self.assertTrue(isPass('clock', sout))

    def test_cdpSimpleQuicksort(self):
        sout, serr = execute_cuda_program('cdpSimpleQuicksort')
        self.assertTrue(isPass('cdpSimpleQuicksort', sout))

    def test_cudaGetDeviceCount(self):
        sout, serr = execute_cuda_program('cudaGetDeviceCount')
        self.assertTrue(isPass('cudaGetDeviceCount', sout))

    def test_cudaRegisterFunction(self):
        sout, serr = execute_cuda_program('cudaRegisterFunction')
        self.assertTrue(isPass('cudaRegisterFunction', sout))




if __name__ == '__main__':
    unittest.main()


