---
layout: post
title: "sed: The Stream Editor"
description: ""
category: 
tags: []
---
{% include JB/setup %}
**Basic Usage**

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