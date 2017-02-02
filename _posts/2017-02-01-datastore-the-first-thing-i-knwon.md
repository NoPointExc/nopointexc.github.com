---
layout: post
title: "datastore. The first thing I knwon."
description: ""
category: 
tags: []
---
{% include JB/setup %}

# Datastore. The first thing I known.

Datastore is a application based on BigTable. It's a No-Sql data base. Datastore runs on Google Cloud. It's based on key-value, column oriented.  Datastore is managed by google so you get the scability, stability... Also, you need to pay for these abilities.   


BigTable white paper: [http://research.google.com/archive/bigtable.html]   

### Kind  
Each Cloud Datastore entity is of a particular kind, **which categorizes the entity for the purpose of queries**: for instance, a human resources application might represent each employee at a company with an entity of kind Employee.  

### Entities  
Data objects in Cloud Datastore are known as **entities**. An entity has one or more named **properties**, each of which can have one or more **values**.  
Entities of the same kind do not need to have the same properties, and an entity's values for a given property do not all need to be of the same data type.


udacity show a way to create entity with annotation:

```
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

/* Recipe entities */
@Entity
public class Recipe {

    @Id Long recipeId;
    String name;
            Boolean vegetarian;
            Integer servings;

    String ingredients;
    String instructions;

    public Recipe() {
    };

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // rest of setters and getters

}
```
see also: [https://classroom.udacity.com/courses/ud859/lessons/1231898607/concepts/14568985500923]  

google doc give a another, which uses constructing methods of `Entity` class directly.  

```
DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

Entity employee = new Entity("Employee", "asalieri");
employee.setProperty("firstName", "Antonio");
employee.setProperty("lastName", "Salieri");
employee.setProperty("hireDate", new Date());
employee.setProperty("attendedHrTraining", true);

datastore.put(employee);
```


see also: [https://cloud.google.com/appengine/docs/java/datastore/entities]  
API: [https://cloud.google.com/appengine/docs/java/javadoc/com/google/appengine/api/datastore/Entity]  


### Properties

Each property has a name and one or more values. And property is asscociated with entity.  
Google give you a lot properties to use. Really A lot!  
check out here: [https://cloud.google.com/appengine/docs/java/datastore/entities#Java_Properties_and_value_types]

### save to..

It's depends on how to define your entity.  
**With `Entity()`**  
As far as your class object is a entity. You can do this simply following the Employee example.  


**With Annotation**  

In this case, you Class is not a `Entity`. So, you can use fellowing code to register your class and put to datastore.  
```
import com.google.devrel.training.conference.domain.Profile;
import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyFactory;
import com.googlecode.objectify.ObjectifyService;

/**
 * Custom Objectify Service that this application should use.
 */
public class OfyService {
    /**
     * This static block ensure the entity registration.
     */
    static {
        factory().register(Profile.class);
    }

    /**
     * Use this static method for getting the Objectify service object in order to make sure the
     * above static block is executed before using Objectify.
     * @return Objectify service object.
     */
    public static Objectify ofy() {
        return ObjectifyService.ofy();
    }

    /**
     * Use this static method for getting the Objectify service factory.
     * @return ObjectifyFactory.
     */
    public static ObjectifyFactory factory() {
        return ObjectifyService.factory();
    }
}
```

### query

to get back the profile.  

```
	@ApiMethod(name = "getProfile", path = "profile", httpMethod = HttpMethod.GET)
	public Profile getProfile(final User user) throws UnauthorizedException {
		if (user == null) {
			throw new UnauthorizedException("Authorization required");
		}

		// TODO
		// load the Profile Entity
		String userId = user.getUserId(); // TODO
		Key key = Key.create(Profile.class, userId); // TODO
		Profile profile = (Profile) ofy().load().key(key).now(); // TODO load the Profile entity
		return profile;
	}
```