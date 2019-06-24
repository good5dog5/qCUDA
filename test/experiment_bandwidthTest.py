#!/usr/bin/env python3
# Jordan huang<good5dog5@gmail.com>

import os
import sys
import random
from plumbum.cmd import grep, make, cut, awk
from plumbum import local, FG, BG
import numpy as np
from tqdm import tqdm
num_iterate = 10



def make_record():

    h2d_dict = dict()
    d2h_dict = dict()

    todo_list = [1024*(2**i) for i in range(0, 21)] * num_iterate
    random.shuffle(todo_list)

    print(todo_list)
    for size in tqdm(todo_list):


        arg = ['--mode=range', '--start='+str(size), '--end='+str(size), '--increment='+str(size), '--htod']
        run_it = local['./exe/bandwidthTest'] | grep[str(size)] | awk['{print $2}']
        output = run_it.popen(arg).communicate()[0].decode('utf-8').rstrip('\n')
        print("size:{0}, bandwidth:{1}".format(size,output))
        if size in  h2d_dict:
            h2d_dict[size] += float(output)
        else:
            h2d_dict[size] = float(output)

        arg = ['--mode=range', '--start='+str(size), '--end='+str(size), '--increment='+str(size), '--dtoh']
        run_it = local['./exe/bandwidthTest'] | grep[str(size)] | awk['{print $2}']
        output = run_it.popen(arg).communicate()[0].decode('utf-8').rstrip('\n')
        print("size:{0}, bandwidth:{1}".format(size,output))
        if size in  d2h_dict:
            d2h_dict[size] += float(output)
        else:
            d2h_dict[size] = float(output)


    for k in h2d_dict.keys():
        h2d_dict[k] = h2d_dict[k] // num_iterate

    for k in d2h_dict.keys():
        d2h_dict[k] = d2h_dict[k] // num_iterate

    return h2d_dict, d2h_dict

if __name__ == '__main__':

    h2d, d2h = make_record()
    print('H2D')
    for k,v in sorted(h2d.items()):
        print(v)

    print('\n\n')

    print('D2H')
    for k,v in sorted(d2h.items()):
        print(v)

    # print("H2D : {}".format(sorted(h2d.items())))
    # print("D2H : {}".format(sorted(d2h.items())))
