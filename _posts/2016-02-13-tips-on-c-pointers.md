---
layout: post
title: tips on c pointers
category: Categories
---

# Troubleshooting Segmentation Violations/Faults #

A common run-time error for C programs by beginners is a "segmentation violation" or "segmentation fault." When you run your program and the system reports a "segmentation violation," it means your program has attempted to access an area of memory that it is not allowed to access. In other words, it attempted to stomp on memory ground that is beyond the limits that the operating system (e.g., Unix) has allocated for your program.

Any time your program gives a "segmentation violation" or "segmentation fault" error, review this document for tips on correcting the error.

##Common causes of this problem:##
**Improper format control string in printf or scanf statements:**

Make sure the format control string has the same number of conversion specifiers (%'s) as the printf or scanf has arguments to be printed or read, respectively, and that the specifiers match the type of variable to be printed or read. This also applies to fprintf and fscanf.

**Forgetting to use "&" on the arguments to scanf:**

Function scanf takes as arguments the format control string and the addresses of variables in which it will place the data that it reads in. The "&" (address of) operator is used to supply the address of a variable. It is common to forget to use "&" with each variable in a scanf call. Omitting the "&" can cause a segmentation violation.

**Accessing beyond the bounds of an array:**

Make sure that you have not violated the bounds of any array you are using; i.e., you have not subscripted the array with a value less than the index of its lowest element or greater than the index of its highest element.

**Failure to initialize a pointer before accessing it:**

A pointer variable must be assigned a valid address (i.e., appear on the left-hand-side of an assignment) before being accessed (i.e., appearing on the right-hand-side of an assignment). Make sure that you have initialized all pointers to point to a valid area of memory. Proper pointer initialization can be done several ways. Examples are listed below.

**Incorrect use of the "&" (address of) and "\*" (dereferencing) operators:**

Make sure you understand how these operators work. Know when they should be applied and when not to apply them. As mentioned above, it is common to forget to use "&" with each variable in a scanf call. Remember, scanf requires the address of the variables it is reading in. Especially, know when "&" and "*" are absolutely necessary and when it is better to avoid using them.

## Proper pointer initialization: ##
One common way is to assign the pointer an address to a previously defined variable. For example:


    int * ptr;
    int variable;
    ptr = &variable; 

Or, equivalently,

    
    int variable;
    int *ptr = &variable;

Other common ways include assigning the pointer the address of memory allocated with matrix, vector, calloc, or malloc or other equivalent allocation functions. Remember, a pointer must be initialized to a value (i.e., assigned a value by appearing on the left-hand-side of an assignment statement) BEFORE you attempt to access it!

## Minimizing the use of pointer variables. ##
Also, many times a function requires that an address (corresponding to a parameter of pointer type) be sent to it as an argument (as is true of many of the Numerical Recipes in C functions). The standard function scanf is an example of such a function.
In these cases, it is usually best to simply declare a variable of the correct type before calling the function and just sending the address of the variable to the function. In fact, that is what is intended in the vast majority of these cases. And, that's how you usually scanf:


    	double x_initial;/* initial guess */
    	scanf("%lf",&x_initial); /* Read the initial guess. */
    
For example, see how 'idum' is used below:


long idum = -1; /* initialize idum to be a negative integer */

/* generate a random number from the normal distn.*/
x = normal(&idum,average,stddev);

The function normal expects an address to a variable of type long. That's what we send it without explicitly using a pointer variable in the calling routine.

## Troubleshooting the problem: ##
Check EVERY place in your program that uses pointers, subscripts an array, or uses the address operator (&) and the dereferencing operator (*). Each is a candidate for being the cause of a segmentation violation. Make sure that you understand the use of pointers and the related operators.

**If the program uses many pointers and has many occurrences of & and \*, then add some printf statements to pinpoint the place at which the program causes the error and investigate the pointers and variables involved in that statement.**

Remember that printf statements for debugging purposes should have a new-line character (\n) at the end of their format control strings to force flushing of the print buffer.

 *From:[http://web.mit.edu/10.001/Web/Tips/tips_on_segmentation.html](http://web.mit.edu/10.001/Web/Tips/tips_on_segmentation.html "MIT.edu")*