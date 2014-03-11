---
layout: post
title: "Eager Loading Nested Polymorphic Associations"
date: 2014-03-06 00:00:00
---

Eager loading is a great feature for getting the records you need in as few trips to the database as possible. The `includes` syntax is quite robust and a majority of the time you'll be able to use it to eager-load your associations. One case where I found I couldn't quite get the `includes` method to work were with nested polymorphic associations.

### An Example
A common feature in applications are activities. These activities usually carry all sorts of context with them such as the user, the action and the resource that the notification is for. A typical `Activity` model [in a fan-in architecture](http://highscalability.com/blog/2013/10/28/design-decisions-for-scaling-your-high-traffic-feeds.html) might look something like this:

```ruby
class Activity < ActiveRecord::Base
  belongs_to :actor
  belongs_to :user
  belongs_to :actionable, polymorphic: true
end
```

So here we have three associations:

- `actor`: the person who did the action that triggered the activity
- `user`: the person who is receiving the activity
- `actionable`: the resource that was affected

### ActiveRecord::Association::Preloader To The Rescue 


### A Note About Rails 4.1