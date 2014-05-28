---
layout: post
title: "Put That Gem Down"
date: 2014-05-29 00:00:00
---

We're Ruby developers. Our beloved language uses a ton of RAM. We love to complain about it and PaaS founders are sleeping on beds made out of cash because of it.

We don't really make it any easier on ourselves either. We love process forking, hate threads and love including huge chunks of other people's code into our projects. Processes and threads are for writing about another day, but the last one I'm going to address now.

I've had the opportunity to work on quite a few Rails projects. Just about all of them have north of fifty gems and some of them close to one hundred gems. Gems are more than just a cute name for "library": **they are a dependency**. As with any other type of dependency, we should be limiting them.

### How I Start A New Rails App

```bash
$ rails new my_cool_app -d postgresql
```

That's it. After that I plop open the `test` directory (because despite what you've heard, TDD is alive and well) and get to work. I wait for something to cause me pain before I go out looking for an off-the-shelf solution. You'll be amazed at all the things you don't really need, but thought you couldn't live without. I don't even use Haml, RSpec or FactoryGirl anymore!

Contrast this with how you start a new Rails application:

```bash
$ rails new my_cool_app -d postgresql && cd my_cool_app
$ vim Gemfile # It's time to go shopping!
$ bundle install # It's time for a coffee break while all those gems download
```

### Object-orientation Is Your Gem

Ruby, by extension of object-orientation, comes with so many great tools for solving common problems. Need decorators? You don't need Draper. I guarantee you at least one of [SimpleDelegator](http://www.ruby-doc.org/stdlib-2.1.0/libdoc/delegate/rdoc/SimpleDelegator.html), [Delegator](http://www.ruby-doc.org/stdlib-2.1.0/libdoc/delegate/rdoc/Delegator.html) or [Forwardable](http://www.ruby-doc.org/stdlib-2.1.0/libdoc/forwardable/rdoc/Forwardable.html) has you covered.

Is authorization giving you the blues? You don't need CanCan(Can) or one of the other several authorization gems out there. Just compose your `User` objects with other models, define simple predicate methods and use duck typing to get the job done. Voila. If that's too much to ask, you can check out the wonderful [Pundit](https://github.com/elabs/pundit) library. It weighs in at a whopping 150 lines of code.

### Exemptions

Look, now I'm not saying go out and reinvent the wheel all over the place. Using existing gems makes perfect sense in some cases. Good reasons for using a gem would be database drivers, file parsers and API wrappers for popular services.

There's also a fine line between not pulling in unnecessary dependencies and suffering from [Not](https://github.com/visionmedia/mocha) [Invented](https://github.com/visionmedia/jade) [Here](https://github.com/visionmedia/axon) [Syndrome](https://github.com/visionmedia/styl). If you catch yourself writing another Twitter API wrapper, you're missing the message here.

### A Test

Next time you're going to add a gem to your project, ask yourself these three questions below. If you can say "no" to all three questions, feel free to add the gem to your Gemfile:

* Does the gem name end in `-rails`? If it does, it's very likely just some JavaScript or CSS that you should be versioning yourself, or using [Bower](http://bower.io/) for.
* Does the gem involve iterating through an array or hash? C'mon, you're better than that!
* Is the gem for sending HTTP requests or parsing JSON? I guarantee you have about five libaries that do either of these already.