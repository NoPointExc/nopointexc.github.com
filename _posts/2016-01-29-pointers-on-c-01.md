---
layout: post
title: pointers on c, chp1 notes
category: Categories
---
* gets(*char var) 
read one line of text and pass to char array, not 0--> not end, NULL--> end
int c, string is a char arry terminated by a NULL, for example, "hello"-->h e l l o NUL

* printf format

%d Print an integer value in decimal.

%o Print an integer value in octal. 

%x Print an integer value in hexadecimal.

%g Print a floating point value. 

%c Print a character. 

%s Print a character string.

\n Print a newline.

* EXIT_FAILURE & EXIT_SUCCESS
in stdlib. 0 for success, 1 for fail

* intinial value
for "int i;" i will be a unpredictable value.

* %d
stop at " "