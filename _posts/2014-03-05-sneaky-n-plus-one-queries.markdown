---
layout: post
title: "A Sneaky N+1 Query"
date: 2014-03-05 00:00:00
---

* Refactor to collection partial
* Eager load the partial

Usually when a Rails application comes grinding to a halt the first things you're going to look for are those pesky N+1 queries. These happen when you iteratively access all of the records off of an association (the "N" in N+1) on a record (the "1" in N+1) that you loaded from the database. Most Rails developers are pretty aware of what causes N+1 queries and how to resolve them by using `include` to eager load the association. But in the day to day life of being a developer with constantly changing product needs, these bottlenecks still pop up in production code bases.

### A Common Example
Your ever-enthusiastic product manager approaches you to satisfy the latest and greatest customer request - a list of recent activities. We're going to skip the details of [fan out/fan in feed architectures](http://highscalability.com/blog/2013/10/28/design-decisions-for-scaling-your-high-traffic-feeds.html) and just get straight to the activity records. "Easy peasy, lemon squeezy" you say, followed by crafting up the following code:

```ruby
# HomeController#index
@activities = Activity.where(created_at: 7.days.ago..Time.now).limit(10)

# views/home/_activity_feed.html.haml
%ul.activities
  - @activities.each do |activity|
    %li
      %p= #{activity.actor} #{activity.verb} on a #{activity.resource}
```

Putting the heavy string concatenation aside, it's a pretty simple and straight forward way to show a list of activities. Great, your product manager will be pleased and you so you race off to their office to show them your work.

### Changing Requirements
Overall, the product manager is quite pleased with your results so far, but through the highly iterative process that agile is, while you were working away they found out that users actually want more metadata about the activity, such as if it is a trending post and a link to the resource. You come to the conclusion that this extra data shouldn't be stored on the activity and you change the `Activity` model as necessary:

```ruby
# models/activity.rb
class Activity < ActiveRecord::Base
  # ...
  belongs_to :actor
  belongs_to :resource
  # ...
end
```

Next, you update the `activity_feed` partial to display the new metadata:
```ruby
# views/home/_activity_feed.html.haml
%ul.activities
  - @activities.each do |activity|
    %li
      %p
```

### Conclusion
N+1 queries happen to the best of us and thankfully there are gems like [Bullet](https://github.com/flyerhzm/bullet) that can detect these and alert you of them before you set them wild in production. N+1 queries are low hanging fruit in the land of performance issues and should be handled immediately.