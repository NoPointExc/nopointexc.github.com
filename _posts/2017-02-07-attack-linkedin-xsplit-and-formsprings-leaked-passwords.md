---
layout: post
title: "Crack some passwords from Linkedin, formspring and xsplit"
description: ""
category: 
tags: []
---
{% include JB/setup %}

# homework 1.b Report



### Linkedin

- attack: dictionary attack + brute force with my python script.   
- password storage: sha1(password)   
- result: get 1970982/6143145 passwords with in 24.7 minus  

### xsplit  
- attack: dictionary attack + brute force with my python script.  
- password storage: sha1(password)  
- result: get 1919658/2499999 within 24.7 minus.  

### formspring
- attack:   
	- dictionary attack + brute force with my **python script**. cost about **10 hours** to **get 9178 / 419564 results**.  
	- dictionary attack **with hashcat** get **2034 results** in about **1 hours**(except 20 hours to get all).   
- password storage: sha256([00-99] + password)  
- result: get about 10000 / 419564 password, need about 20 hours to get all.  

### diffculities.  

formspring >>> (Linkedin = xsplit)   

The formspring passwords are salted and encrypt with more time consuming hash function. Even though it also can be crack in reasonable time(about 20 hours with hashcat), however, this result is much better than Linkedin & xsplit's unsalted passwords (cracked in less than 30 minutes with python script).  


### Tools..

Hashcat 3.30  
Python(see script below):  
awk(see script below)
dictionary: [http://md5decrypt.net/en/Password-cracking-wordlist-download/]  


*to crack with dict attack and brute force attack, I coded the cracy.py*  

```
#!/usr/bin/python
import urllib2
import hashlib
import time
from sets import Set

code="bdcf8d40eebd142d"
email="js8510@nyu.edu"
hash_type="sha256"
HASH="5fcee7b96e925c9c97efba302056f6a0c3d2a1a7"
api="http://md5decrypt.net/en/Api/api.php"

DEBUG = False

filePth = "/home/joey/GoogleDrive/course/ComputerSecurity/hw2/passwordList/xsplit_pwd.txt"
#dictPth = "/home/joey/GoogleDrive/course/ComputerSecurity/hw2/passwordList/Md5decrypt-awesome-wordlist"
dictPth = "/home/joey/GoogleDrive/course/ComputerSecurity/hw2/passwordList/pwd6.txt"
outPth = "/home/joey/GoogleDrive/course/ComputerSecurity/hw2/passwordList/xsplit_pwd.out"

def query(url, debug = False):
    rsp = None
    if debug:
        print url
    else:
       rsp = urllib2.urlopen(url).read();
    return rsp

def url(hashArr):
    rst = api+ "?hash_type="+hash_type+"&email="+email+"&code="+code + "&hash="
    for i in range(0, len(hashArr)):
        if i == 0:
            rst = rst + hashArr[i]
        else:
            rst = rst + ";" + hashArr[i]
    return rst

#print urllib2.urlopen(url(HASH)).read(); 

def write_back(hashTable, filePath):
    with open(filePath, "a") as f:
        for h in hashTable:
            f.writelines(h + "  " + hashTable[h] + "\n")
    print "write back {0} hashes".format(len(hashTable))

def rm_found(hashset, filePth):
    with open(filePth, 'r') as f:
        for line in f:
            h = line.split()[0]
            if h in hashset:
                hashset.remove(h)
    return hashset
                
def load(filePth):
    rst = Set()
    with open(filePth, 'rw') as f:
        for line in f:
            #print line[:-1]
            rst.add(line[:-1])
    print "{0} hashs loaded from {1}".format(len(rst), filePth)
    return rst



def sha1_crack():
    startTime = int(round(time.time() * 1000))
    #hashSet = rm_found(load(filePth), outPth)
    hashSet = load(filePth)
    hashTable = {}
    with open(dictPth, "r") as f:
        count = 0
        for line in f:     
            h = hashlib.sha1(line[:-1]).hexdigest();
            #print "{1} {0}".format(line[:-1], h)
            if(h in hashSet):
                hashTable[h] = line[:-1]
                count = count + 1
                if(count % 10000  == 0): 
                    print "found {0}. hash({1}) = {2}".format(count, line[:-1], h)
                    write_back(hashTable, outPth)
                    hashTable.clear()
        write_back(hashTable, outPth)
    print "total found {0} password".format(count)
    print "{1} over {0} not found :(".format(len(hashSet), count)
    print "cost {0}ms".format(int(round(time.time() * 1000)))


def sha256_salted():
    startTime = int(round(time.time() * 1000))
    hashSet = rm_found(load(filePth), outPth)
    hashTable = {}
    with open(dictPth, "r") as f:
        count = 0
        for line in f:

            #crack formspring
            for i in range(0, 101):
                salt = '{:02d}'.format(i)
                if i == 100:
                    salt = ""
                h = hashlib.sha256(salt + line[:-1]).hexdigest();
                #print "word={0}, hash={1}".format(salt + line[:-1], h) 
                if(h in hashSet):
                    hashTable[h] = line[:-1]
                    count = count + 1
                    if(count % 1 == 0): 
                        print "found {0}. hash({1}) = {2}".format(count, line[:-1], h)
                        write_back(hashTable, outPth)
                        hashTable.clear()
        write_back(hashTable, outPth)
    print "total found {0} password".format(count)
    print "{0} over {1} not found :(".format(len(hashSet), count)
    print "cost {0}ms".format(int(round(time.time() * 1000)))

sha1_crack()

```


*to combine result*     

```
#!/usr/bin/python

CURRENT_PTH = "/home/joey/GoogleDrive/course/ComputerSecurity/hw2/passwordList/js8510/"
LIN_RST_PTH =  CURRENT_PTH + "Linkedin.out"
XPL_RST_PTH = CURRENT_PTH + "xsplit_pwd.out"
SPR_RST_PTH = CURRENT_PTH + "formspring.out"

LIN_IN_PTH = CURRENT_PTH + "Linkedin.txt"
XPL_IN_PTH = CURRENT_PTH + "xsplit_leak.txt"
SPR_IN_PTH = CURRENT_PTH +  "formspring.txt"

LIN_OUT_PTH = CURRENT_PTH + "Linkedin_out.txt"
XPL_OUT_PTH = CURRENT_PTH + "xsplit_cracked.txt"
SPR_OUT_PTH = CURRENT_PTH +  "formspring_cracked.txt"

#   print LIN_IN_PTH

def load(pth):
    
    """
    return a hash table {hash : pwd}
    """
    
    table = {}
    with open(pth, 'r') as f:
        for line in f:
            arr = line[:-1].split()
            if(len(arr) == 2):
                #print arr
                table[arr[0]] = arr[1]
    print "load {0} from {1}".format(len(table), pth)
    #print table
    return table

def match_and_write(hashTable, inPth ,outPth):
    """
    padding pwd after hashs of [inPth] and output to [outPth]
    """
    
    print "matching and writing....."
    with open(inPth, 'r') as inFile, open(outPth, 'a') as outFile:
        lnum = 0
        fnum = 0
        for line in inFile:
            #rm \n
            lnum = lnum + 1
            #print line
            line = line[:-1]
            fileds = line.split()
            pwd = ""
            if len(fileds) != 0 and fileds[-1] in hashTable:
                fnum = fnum + 1
                pwd = hashTable[fileds[-1]]
                #print "writing line {0} and found {1}".format(lnum, fnum)
            outFile.write(line + " " +pwd + "\n")
            if (lnum % 10000 == 0):
                print "writed {0} lines and found {1}".format(lnum, fnum)

#hashTable = load(LIN_RST_PTH)
#match_and_write(hashTable, LIN_IN_PTH, LIN_OUT_PTH)

# hashTable = load(XPL_RST_PTH)
# match_and_write(hashTable, XPL_IN_PTH, XPL_OUT_PTH)

hashTable = load(SPR_RST_PTH)
match_and_write(hashTable, SPR_IN_PTH, SPR_OUT_PTH)

```

*to generated salted input for Hashcat, I use follow awk script*   

```
{	
    for (i = 0 ; i<=50; i++){
	    printf("%s:%d\n", $0, i) 
    }
}
```

*to do brute foce attack*  
```
#!/usr/bin/python
import itertools
import string

pwdPth = "/home/joey/GoogleDrive/course/ComputerSecurity/hw2/passwordList/pwd7.txt"
LETTERS = string.ascii_letters + string.digits

def gen(length = 7,outPth = pwdPth):
    with open(outPth,'w') as f:
        comb = itertools.combinations_with_replacement(LETTERS,length)
        while(True):
            pwd = "".join(comb.next())
            f.write(pwd + '\n')

gen()
```


