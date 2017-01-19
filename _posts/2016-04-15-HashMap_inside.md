---
layout: post
title: HashMap inside
category: Categories
---

HashMap maintains an array of buckets. Each bucket is a linkedlist of key value pairs encapsulated as Entry objects.This array of buckets is called table. Each node of the linked list is an instance of a private class called Entry.An entry is a private static class inside HashMap which implements Map.Entry  

    private static class Entry<K,V> implements Map.Entry<K,V> {
     final K key;
     final int hash;
     V value;
     Entry<K,V> next;
    }
    
code: [openjdk/8u40-b25/java.util.HashMap line 282](http://grepcode.com/file/repository.grepcode.com/java/root/jdk/openjdk/8u40-b25/java/util/HashMap.java#HashMap.0DEFAULT_LOAD_FACTOR) class name is Node<K,V> in open JDK  

Each Entry object has a field called next which points to the next Entry thus behaving like a singly linked list. The hash field stores the hashed value of the key. 
![hashsturct](http://i.imgur.com/dSBvhjV.png) 

### capacity ###
HashMap provides overloaded constructors with parameters for initial capacity and load factor but typically no args constructor is the one most frequently used. Default values of these fields are : 
   
*initial capacity : 1 << 4 (ie 16)*  
*load factor : 0.75*   

Whenever the element count of the hashmap **reaches the load** factor fraction of capacity, the map is resized and **capacity is doubled**. If capacity provided by client is a power of 2, then real capacity will be same as capacity else real capacity = nearest power of 2 > provided capacity. Maximum capacity is 1<<30 (ie 2 ^30) if capacity provided is greater than that, then real capacity = 2^30.  
**Note that capacity indicates the size of the table array (the array of buckets) and not the number of key-value pairs the HashMap can support**


[from: Kaustubh Saha's answer@Quora](https://www.quora.com/How-is-Hashmap-in-Java-implemented-internally-What-are-the-pros-and-cons-to-use-it-What-are-the-complexities-it-provides-for-insert-delete-and-lookup)