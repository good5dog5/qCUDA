#!/usr/bin/env python3
# Jordan huang<good5dog5@gmail.com>

import os
import sys
import subprocess
import unittest
import re
from subprocess import Popen, PIPE

# EXE_PATH='exe'

expected_results = {
    'vectorAdd': ['Test PASSED'],
    'matrixMul': ['Result = PASS', 'Performance=', 'GFlop/s' ],
    'cudaGetDeviceCount': ['Device name: NVIDIA Tegra X2', 'Peak Memory Bandwidth' ],
    'cudaRegisterFunction':['cudaRegisterFunction PASSED'],
    'cdpSimpleQuicksort': ['Validating results:', 'OK'],
    'clock': ['Average clocks/block ='],
    'cudaPointerTest': ['PASSED']
}

def execute_cuda_program(prg_name, *args):
    CMD = ['./exe/{0}'.format(prg_name)] + list(args)
    p = Popen(CMD, shell=False, stdout=PIPE, stderr=PIPE, stdin=PIPE)
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
        sout, serr = execute_cuda_program('vectorAdd', str(128000000))
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

    def test_cudaPointerTest(self):
        for i in [4*1024*1024, 5*1024*1024, 2*1024*1024*1024]:
            with self.subTest(i=i):
                sout, serr = execute_cuda_program('cudaPointerTest', str(i), str(0))
                self.assertTrue(isPass('cudaPointerTest', sout))


if __name__ == '__main__':
    unittest.main()


