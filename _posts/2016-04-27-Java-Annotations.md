---
layout: post
title: Java Annotations
category: Categories
---

### Usage  
- info for compiler: suppress warnings & detect errors.
- compile-time and deployment-time processing: tools (like Junit/JavaDoc) use annotation to generate code/xml/files and etc.
- Runtime processing: available to be examined at runtime.

### Format 
    
to include elements  
    
    @Author(
       name = "Benjamin Franklin",
       date = "3/27/2003"
    )
    class MyClass() { ... }

or one named value  
    
    @SuppressWarnings("unchecked")
    void myMethod() { ... }  

if no element, 

    @Override  
    void hello(){...}

You can have two aannotations with same name. (Java 8 or latter versions)

    @Author(name = "Jane Doe")
    @Author(name = "John Smith")
    class MyClass { ... }

### Where can be used

lass instance creation expression:

    new @Interned MyObject();
Type cast:

    myString = (@NonNull String) str;
implements clause:

    class UnmodifiableList<T> implements
        @Readonly List<@Readonly T> { ... }
Thrown exception declaration:

    void monitorTemperature() throws
        @Critical TemperatureException { ... }

### Declaring an Annotation Type  
Annotation types are a form of interface. 

    @interface ClassPreamble {
       String author();
       String date();
       int currentRevision() default 1;
       String lastModified() default "N/A";
       String lastModifiedBy() default "N/A";
       // Note use of array
       String[] reviewers();
    }

The body of the previous annotation definition contains annotation type element declarations, which look a lot like methods. Note that they can define optional default values.  
This ```@ClassPreamble`` is used as: 

After the annotation type is defined, you can use annotations of that type, with the values filled in, like this:

    @ClassPreamble (
       author = "John Doe",
       date = "3/17/2002",
       currentRevision = 6,
       lastModified = "4/12/2004",
       lastModifiedBy = "Jane Doe",
       // Note array notation
       reviewers = {"Alice", "Bob", "Cindy"}
    )
    public class Generation3List extends Generation2List {
    
    // class code goes here
    
    }  

**To Include your annotion in Javadoc-generated documentation** :  

    // import this to use @Documented
    import java.lang.annotation.*;
    
    @Documented
    @interface ClassPreamble {
    
       // Annotation element definitions
       
    }

### Retrieving Annotations  
There are several methods available in the Reflection API that can be used to retrieve annotations. The behavior of the methods that return a single annotation, such as AnnotatedElement.getAnnotationByType(Class<T>), are unchanged in that they only return a single annotation if one annotation of the requested type is present. If more than one annotation of the requested type is present, you can obtain them by first getting their container annotation. In this way, legacy code continues to work. Other methods were introduced in Java SE 8 that scan through the container annotation to return multiple annotations at once, such as AnnotatedElement.getAnnotations(Class<T>). See the Annotated Element class specification for information on all of the available methods.  

Ref: [Orcale](https://docs.oracle.com/javase/tutorial/java/annotations/index.html "Orcale")