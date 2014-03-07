---
layout: post
title: "Eager Loading Nested Polymorphic Associations"
date: 2014-03-06 00:00:00
---

Eager loading is a great feature for getting the records you need in as few trips to the database as possible. The `includes` syntax is quite robust and a majority of the time you'll be able to use it to eager-load your associations. One case where I found I couldn't quite get the `includes` method to work were with nested polymorphic associations.

### An Example
A common feature in applications are activities. These activities usually carry all sorts of context with them such as the user, the action and the resource that the notification is for. A typical `Activity` model (in a fan-in architecture) might look something like this:

```ruby
class Activity < ActiveRecord::Base

end
```

### ActiveRecord::Association::Preloader To The Rescue 


### A Note about Rails 4.1