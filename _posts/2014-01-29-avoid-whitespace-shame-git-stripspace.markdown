---
layout: post
title: "Never Experience Whitespace Shame Again"
date: 2014-01-29 10:10:33
---

We've all been there before. You finish up the latest and greatest feature, or better yet, refactoring, and open up the pull request for everyone to marvel at your latest work of art. Unsurprisingly to you, you receive a bunch of notifications five minutes later. Being the amazing developer that you are you expect these to be high fives and thumbs ups about how great you are. Unfortunately for you these notifications are about *whitespace*.

In the cardinal sins of programming, whitespace is up there along with unintentional new lines and tabs instead of spaces. Thankfully, there are tons of tools to remove whitespace from files. Your text editor can probably do this for you or maybe a shell script. But my personal favorite is good ol' **git**.

### Introducing git-stripspace
To most people, git is just an amazing version control system. Along with that, git also comes with some other pretty handy tools. ``git-stripspace`` is one of these such tools.