---
layout: post
title: "A Sneaky N+1 Query"
date: 2014-03-05 00:00:00
---

Usually when a Rails application comes grinding to a halt the first things you're going to look for are those pesky N+1 queries. These happen when you iteratively access all of the records off of an association (the "N" in N+1) on a record (the "1" in N+1) that you loaded from the database. Most Rails developers are pretty aware of what causes N+1 queries and how to resolve them by using `include` to eager load the association. But in the day to day life of being a developer with constantly changing product needs, these bottlenecks still pop up in production code bases.

### A Common Example
The place where N+1 queries happen a majority of the time is in the view layer. The view just happens to be where we display all that data we've retrieved from the database. Usually this means iterating over some records to do so. Any experienced Rails developer will have a trained eye for looking for calls to an iterator method such as `each` and making sure any associations used have been eagerly loaded.

```ruby
%ul.activities
  - @activities.each do |activity|
    %li
      %p= #{activity.actor.name} #{activity.verb} #{activity.resource.title}
```

Putting the heavy string concatenation aside, it's a pretty simple and straight forward way to show a list of activities. We dip into the `actor` and `resource` associations and without eager loading this causes an N+1 query. The fix is to just eager load the associations using `include`:

```ruby
@activities = Activity.include(:actor, :resource).
  where(created_at: 7.days.ago..TIme.now).limit(10)
```

### The Likely Example
Examples like the one above are what we all know about and rarely let slip by undetected.

### Conclusion
N+1 queries happen to the best of us and thankfully there are gems like [Bullet](https://github.com/flyerhzm/bullet) that can detect these and alert you of them before you set them wild in production. N+1 queries are low hanging fruit in the land of performance issues and should be handled immediately.