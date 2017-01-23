---
layout: post
title: grep and so on
category: Categories
---

# grep family.

basic usage: ```grep pattern filenames```  
Search for pattern and print the line found the input.  
  
### usefull options:
- ```grep -n variable *.[ch] # search for varibale in c source with line number```  
- ```grep -i variable *.py # search ignore case. ```  
- ```ls | grep -v temp # filenames that don't contain temp```

### regular expressions.  

*basic rule*  
```c``` : any non-special character c matches itself.  
```\c``` : turn off any special meaning of c.  

```^```: beginning of the line.  
```$```: end of line.  
```.```: any **single** character.  
```[abc]```: any single character match a, b or c.  
```[^abc]```: any single character **doesn't match** a, b nor c.  
```r*```: zero of more **occurence of r**.  
```r+```: one of more **occurence of r**(egrep only). 
```r?```: zero of one **occurence of r**(egrep only).  
```r1|r2```: match r1 or r2(egrep only).  

### grep ,egrep and fgrep

These greps are different accourding to the blue cover unix manual. They are different execuable under bin in old times.  

Now, according to my Linux man(1) page:

```$egrep = $grep -E ``` : e is extended-regexp.   
```$fgrep = $grep -F ``` : f fixed strings.  Interpret PATTERN as a list of fixed strings (instead of regular expressions), separated by newlines, any of which is to be matched.  

According to the blue unix, *fgrep can look efficiently for thousands of words in parallel.* 

See also: 
- http://unix.stackexchange.com/questions/17949/what-is-the-difference-between-grep-egrep-and-fgrep  
- The Unix Programming Environment, chp4: Filters  


