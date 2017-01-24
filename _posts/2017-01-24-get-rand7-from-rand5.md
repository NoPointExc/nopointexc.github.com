---
layout: post
title: "get rand7 from rand5"
description: ""
category: 
tags: []
---
{% include JB/setup %}
The origina question from here:  

https://www.quora.com/Given-a-random-number-generator-rand5-that-generates-a-random-integer-in-the-set-0-1-2-3-4-how-would-someone-use-this-to-generate-a-function-rand7-that-outputs-an-int-in-0-1-2-3-4-5-6#

There are also a same question here:  
http://stackoverflow.com/questions/137783/expand-a-random-range-from-1-5-to-1-7 

To be clear, I define as rand5 = [0, 1, 2,3,4], rand7=[0,1,2,3,4,5,6].  

To make the distrubtion evenly, we need a evens' union have 7 * k (k is any position integer) elements with even distrubtion.  

rand5 in fact is a 5 * k events union.

We can get a 5 * 5 =25 events union, then we discard 4 events. Then we have 21 events. Then we can combine 3 events togher, then we can get a even-distrubted 7-even-union.  

**How to get a 25 events union and discard 4 events?**  
My solution is really stright forward.  generate random number 2 times, r1, r2.  r1 and r2 are independ events. So they are 25 possible event(r1, r2).  They we discard event(7,7), event(7,6), event(7,5), event(7,4). If we get these two events, we repeat the random process again.  

unfortunately, this is a random algorithm. Which means this algorithm may never stop.  

**A clean and elegant solution**   
The geekforgeek.com give a much more clean solution.  
http://www.geeksforgeeks.org/generate-integer-from-1-to-7-with-equal-probability/ .  

The fundamental idea is same-> create a even distrubtion  7 * k evets union. But their solution are much smart than my solution.   

Their idea is `rand7() = 4 * rand5() + rand5() - 1`  

Their codes.
```
#include <stdio.h>
 
int foo() // given method that returns 1 to 5 with equal probability
{
    // some code here
}
 
int my_rand() // returns 1 to 7 with equal probability
{
    int i;
    i = 5*foo() + foo() - 5;
    if (i < 22)
        return i%7 + 1;
    return my_rand();
}
```


