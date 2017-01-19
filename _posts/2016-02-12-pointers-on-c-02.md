---
layout: post
title: Pointers on C, Notes
category: Categories
---
Pointers on C, Notes

* %d integer, 2^16

* when "=="+mistake-->'=', no systax error report.

* pointer define, pointer name in

rearrange( char *output, char const *input, in n_columns, int const columns[] ) //define as pointer, use as name input

* tips
putting function prototypes in #include files.
can't initialize 'i' in while or for
be careful with arrays' bounds.

* Enumerated Type
enum Jar_Type {CUP, PINT, QUART, HALF_GALLON, GALLON};
enum Jar_Type milk_jug, gas_can, medicine_bottle;

* declaring pointers

int *a; a pointer named 'a' point to a int.

char *message="Hello world!";
*"Hello world!" is assigned to message not *message *
//equals to 
char *message;
message="Hello world!"

int *pi; // pointer to integer
int const *pci; //pointer to a const int.
int * const cpi; // const pointer to a int.
int const * const cpci; // both pointer and int are constants

 * /#define vs const
 define can be used to define something like the size of array. 

* scope

block scope{}/ File Scope/prototype scope/Function scope

* Linkage
 
?? do not unstand

* storage class: ordinary memory, runtime stack and hardware register

variable declared outside block--> static memory

within block --> (automatic)on the stack

within block+static--> static, exist with the entire duration of the program

with key word *register* --> hardware register

* static variable's space exists at the beginning of the program, default initial to zero. While automatic variable have no default initialization, initialization at runtime.

   
 ###  array as input var=pointer ###

when array as input, the input variables are pointers indeed. The sizeof() return 1 for char, return 4 for pointer, return the size of a char array.
for the codes blow,

    main(void){
    	char src[]="abcdefghijklmnopqrsguvwxyz1234567890+-~";
    	char dst[30];
     	int i=0;
    
     	int rst=substr(dst,src,4,40);
     	printf("rst=%d  dst=%s\n",rst,dst);
    }
    
    int substr(char dst[], char src[], int start, int len){
    	int i=-1;
    
    	int srcLen=strlen(src);
    	int dstLen=strlen(dst);
    	if(start<0 || start>=srcLen || len<0) return i;	
    	if(len+start<srcLen){
    		for(i=start;i<len+start;i++) dst[i-start]=src[i];		
    		dst[len]='\0';
    
    	}else{
    		for(i=start;i<srcLen;i++) dst[i-start]=src[i];
    		dst[srcLen]='\0';
    	}
    	return i-start;
    }

the src[] and dst[] in substr are pointers. so, when you call sizeof(src) inside the substr, the return value is 4(the size of a pointer).

