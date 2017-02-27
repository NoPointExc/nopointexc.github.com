---
layout: post
title: Store Password Securely
tags: []
---
{% include JB/setup %}
## Save MySql user/password in php.   

Generally speaking, never save password in source code. Even the encrypted password. 

The reason is, anyone can get access to the source code and get the password. However, If I insist to that, what should I do?

For my doyouhavemypwd.com, I going to 
Save the password in a separate file outside the git tracked directory.   
Set the password only readable/writable for server root user.  

## Hashing word-list in MySql.

 Ref:  
  [1](https://alias.io/2010/01/store-passwords-safely-with-php-and-mysql/)   
  [2](https://crackstation.net/hashing-security.htm)   

  hash(password + salt).

  Hash can’t be something like md5(too weak) or use encryption algorithm to replace hash-function.  
  Salt: should randomly generated. 
  Use Cryptographically hash solution instead of invent your own.  
  Generate long salt cspring instead of use your own random algorithm, or even worth, use contains or a loop. 
  Salt can store in plain text just with the hashed password.  


  Platform
  CSPRNG
  PHP
  mcrypt_create_iv, openssl_random_pseudo_bytes
  Java
  java.security.SecureRandom
  Dot NET (C#, VB)
  System.Security.Cryptography.RNGCryptoServiceProvider
  Ruby
  SecureRandom
  Python
  os.urandom
  Perl
  Math::Random::Secure
  C/C++ (Windows API)
  CryptGenRandom
  Any language on GNU/Linux or Unix
  Read from /dev/random or /dev/urandom



## Protect against off-line attack on single password.  
  Answer: 
  System like [Pythia](https://www.usenix.org/node/190917) 



