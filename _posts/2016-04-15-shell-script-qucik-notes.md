---
layout: post
title: Shell Script Quick Notes
category: Categories
---
Shell Script
-----------------------------
### Execute & Debug ###
Display each commends excuted.  
```$ bash -x <script> ```  
To avoide duplicate name, check with  
```$ what <scrpit name> ```   
runable  
```$ chmod +x <script> ```  
### variables ###
Defination:  
   
	NAME=value   
    #run date every time when MYDATE called  
    MYDATE= $(date) 
    #only when the variable is set  
    MYDATE= $`date` 
     

Escaping Characters  
\: escaping single character  
'': escaping a line inside  

variables refer to variables  
```BALANCE="$CurBalance"```  
When assigning variables, use only the variable name (for example, BALANCE). When you reference a variable,meaning you want the value of the variable, precede it with a dollar sign (as in $CurBalance). The result of the latter is that you get the value of the variable, not the variable name itself.  

Shell Parameters  
Just like main() in C language.  $0 is the command itself. %1~ %n is the 1~n parameters.  
 
    #!/bin/bash
    # Script to echo out command-line arguments
    echo "The first argument is $1, the second is $2."
    echo "The command itself is called $0."

the output  

    $ myscript foo bar
    The first argument is foo, the second is bar.
    The command itself is called /home/chris/bin/myscript. 

paramter number: ``` $# ```  
all paramter: ``` $@ ```  
last paramter excuted: ``` $? ```  0 means exit success. Other values indicate error.  

 
### if else ###
    
	#-ep for number, = for string.
	VARIABLE=1
    if [ $VARIABLE -eq 1 ] ; then
    echo "The variable is 1"
    fi
    
    STRING="Friday"
    if [ $STRING = "Friday" ] ; then
    echo "WhooHoo. Friday."
    else
    echo "Will Friday ever get here?"
    fi
	
	#!=
	STRING="FRIDAY"
	if [ "$STRING" != "Monday" ] ; then
	echo "At least it's not Monday"
	fi
	
	#elif
	filename="$HOME"
	if [ -f "$filename" ] ; then
	echo "$filename is a regular file"
	elif [ -d "$filename" ] ; then
	echo "$filename is a directory"
	else
	echo "I have no idea what $filename is"
	fi

###Difference between echo and @echo in unix shells###
That's a Makefile-specific thing; it has nothing to do with shell scripts.

Recipes that begin with @ do not echo the command. That is to say, with a Makefile

	foo:
    echo foo
You get

$ make foo        # <-- this is meant to be the command you enter in the shell
echo foo
foo
Whereas with a Makefile

	foo:
    @echo foo
it is

	$ make foo
	foo

###Make script excuatable everywhere


well you can make it by doing as

    chmod +x filename.sh
so it will execute when you call it will
    
    ./filename.sh
and you can access that script as application also .

open your terminal and type as below from your home directory .
    
    gedit .bashrc
then in the opened file , type this at last line.
    
    alias <Name_with which you wanna call it >='./filename.sh'
save and close .

Then type this in your terminal source ~/.bashrc to apply the changes you made . then simply type the name you have given there after alias to access your script .

make sure that you have placed in the home directory .

else
    
    alias <Name_with which you wanna call it >='./<path to your script >.sh'
    