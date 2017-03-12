---
layout: post
title: "shell notes"
description: ""
category: 
tags: []
---
{% include JB/setup %}

# ```"$@"``` vs ```"$@"```  

Take this script for example (taken from the linked answer):  
```  
for var in "$@"
do
    echo "$var"
done
```  
Gives this:  

$ sh test.sh 1 2 '3 4'  
1  
2  
3 4  
Now change "$@" to $*:  
```  
for var in $*
do
    echo "$var"
done
And you get this:
```  

$ sh test.sh 1 2 '3 4'  
1  
2  
3  
4  

# for loops.  

```
echo "echo 1 2 3"
for i in 1 2 3
do
    echo $i
done
``` 
```
echo "echo all args passed in"
for i
do
    echo $i
done
echo "\$# holds number of argument. like args.length in Java main"
echo $#

#switch-case
case $# in
    0) echo "0 argument.";;
    1) echo "1 argument.";;
    *) echo "$# arguments.";;
esac

``` 
