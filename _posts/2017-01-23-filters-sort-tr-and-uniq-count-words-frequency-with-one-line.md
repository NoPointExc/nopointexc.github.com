---
layout: post
title: "filters, sort, tr and uniq, count words frequency with one line"
description: ""
category: 
tags: []
---
{% include JB/setup %}

### ```sort``` common usage :

`-f`: ignore case. lower--> upper.  
`-n`: sort with numeric value. `$ls -s | sort -n #sort by size`  
`-r`: reversed order.  
`-k`: sort by a which column and which key.   
e.g.   `$sort -k 2n [filename] #sort 2nd column with numeric order.`  

### one interesting on-liner.
This command count word frequency and print top 10.   
`$cat * | tr -sc A-Za-z '\012' | sort | uniq -c | sort -n | tail `      
`tr` translate or delete characters. here compress runs of non-letters into newline  
`uniq` list he uniq lines. with `uniq -c` can count appers of each line.  
