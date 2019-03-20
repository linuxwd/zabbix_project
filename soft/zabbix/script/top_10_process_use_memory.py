#!/usr/bin/env python
# -*- coding: utf-8 -*-
# author: huxianglin
#date:2015-09-11

import string
import sys

def read_line(line):
    line = line.strip('\n').strip()
    programname = line.split()[11]
    memoryuse = line.split()[5]
    cpuuse = line.split()[8]
    return programname,memoryuse,cpuuse

def getdate(file_path):
    with open(file_path) as f:
        for line in range(1,8):
            next(f)
        result=[]
        for line in f:
            result.append(list(read_line(line)))
    return result

def topprogram(file_path):
    date=getdate(file_path)
    top={}
    for i in date:
        if 't' in i[1]:
            i[1]=string.atof(i[1].split('t')[0])*1073741824
        elif 'g' in i[1]:
            i[1]=string.atof(i[1].split('g')[0])*1048576
        elif 'm' in i[1]:
            i[1]=string.atof(i[1].split('m')[0])*1024
        else:
            i[1]=string.atof(i[1])
        if top.get(i[0]):
            top[i[0]]=[top[i[0]][0]+i[1],top[i[0]][1]+string.atof(i[2])]
        else:
            top.setdefault(i[0],[i[1],string.atof(i[2])])
    return sorted(top.items(),key=lambda d:d[1][0])[-1:-11:-1]

def translatejson(file_path):
    data=topprogram(file_path)
    print'{"data":['
    for i in data:
        if i != data[-1]:
            print '{"{#TABLENAME}":"%s"},' %i[0]
        else:
            print '{"{#TABLENAME}":"%s"}]}' %i[0]

def printdata(file_path,key):
    data=topprogram(file_path)
    for i in data:
        if key[1] == 'cpu':
            if key[0] == i[0]:
                print i[1][1]
        else:
            if key[0] == i[0]:
                print i[1][0]

def main():
    file_path='/tmp/zabbix_top_10_process_use_memory.txt'
    if sys.argv[1] == 'json':
        translatejson(file_path)
    else:
        key = [sys.argv[1],sys.argv[2]]
        printdata(file_path,key)
if __name__=='__main__':
    main()
