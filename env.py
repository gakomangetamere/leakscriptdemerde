#!/usr/bin/env python3

import sys
import requests
import random
from multiprocessing.dummy import Pool

requests.urllib3.disable_warnings()

try:
    domains = [i.strip() for i in open(sys.argv[1], mode='r').readlines()]
except IndexError:
    exit('Où est ta liste?')

def check(domain):
    try:
        r = requests.get('https://'+domain+'/.env', timeout=5, allow_redirects = False)
        if "DB_HOST" in r.text:
            with open("envrez.txt", "a+") as f:
                print('https://'+domain+'/.env', file=f)
    except:pass

mp = Pool(100)
mp.map(check, domains)
mp.close()
mp.join()
