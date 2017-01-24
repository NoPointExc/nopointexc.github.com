---
layout: post
title: "The Stream Editor, sed and awk"
description: ""
category: 
tags: []
---
{% include JB/setup %}
### sed Basic Usage

`sed` is come from `ed` which is a line by line editor for old days when people edit files line by line(screens and large memory is not aviable).   

`ed` almost useless not.. We use vim, sublime or some other wired editor like Ema*. However, sed are still usefull.  The idea of `sed` is stream orientation editing(a script applied to file line by line). However, the logic and syntax of the script is pattern match which seldom friendly to reader.  

`sed [OPTION]... {script-only-if-no-other-script} [input-file]...`  
E.g.  
`sed 's/To-be-replace/replace with/' filename > output`  

one more example from the "Blue Unix book" is:

```
$ who
user1  tty7  2017-01-24 09:58 (:0)  
user2  tty7  2017-01-24 09:58 (:0)  
user3  tty7  2017-01-24 09:58 (:0)  

$ who | sed 's/ .* / /'
user1 (:0)  
user2 (:0)  
user3 (:0)  
```  

The pattern ` .* ` match any text start with space and end with space and replce it with a single space.  So all the output in the middle part is replaced.   

Hard to read, right? At last, when I first see thisa detailed sed usaget get the author's point immediately.    

a detailed sed usage: http://www.grymoire.com/Unix/Sed.html  

### awk usage  
Just like `sed`, `awk` is another line-by-line filter which is based on C style language. So, I perfer `awk` personally.  

The basic usage is same:  
`awk 'program' filenames...`  
However, the program looks like `pattern {action} ...`   

The default pattern is match everything(if pattern ommited) and default action is print. 

One useful option is `-f` which read prgram from a file.  
E.g `awk -f rm_space.awk filenames...`  

**fild**  
input of awk is split into filds.  E.g.  

```
joey:~$ who
joey     tty7         2017-01-24 09:58 (:0)

joey:~$ who | awk '{print $4, $1}' 
09:58 joey
``` 

Easy, right?  `$1, $2...` just works like you think and `$NF` means number of fileds.  However, the "Blue Unix Book" says `sed` is faster than `awk`.  According to this post : https://lyness.io/the-functional-and-performance-differences-of-sed-awk-and-other-unix-parsing-utilities  , `awk` works as fast as python and slower than `ed`,  but no significant distance between `awk` and `sed`.  

The default splitor here is white space, you can replce it with `-F` option.  See awk(1).  

**build-in variable**    
`$0`: whole line.  
`$NR`: line number e.g. `awk '{ print NR, $0}' #add line number`   
`$1`: 1st field.  
`$NF`: number of field.  
`$FILENAME`: current file name.  
`$FS`: field seprator character.  
`$RS`: input record seprator. Default newline.  So, awk read in file line by line.  
`$OFS`: output field seprator character.  
`$ORS`: output record seprator.
`$OFMT`: output format of number.

**build-in Fuctions**  
`printf`: c-style printf, see *printf(3)*  
`length($variable)`: return length of variable.  
`substr(str, start, [end])`: get substring. default end = length(str)  


**Arithmetic and variables**  
e.g. `wc` with awk:   	
```
joey:~/test$ awk '{ char_num += length($0) + 1
> word_num += NF
> }
> END{ print NR, word_num, char_num}' abc
17 22 102
joey:~/test$ wc abc
 17  22 102 abc
```






