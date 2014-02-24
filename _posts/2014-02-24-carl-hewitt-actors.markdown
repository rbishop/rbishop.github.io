---
layout: post
title: "My Notes From Carl Hewitt on the Actor Model"
date: 2014-02-24 00:00:00
---

About a year ago I stumbled upon an excellent [ad-hoc explanation from Carl
Hewitt on the Actor
Model](http://channel9.msdn.com/Shows/Going+Deep/Hewitt-Meijer-and-Szyperski-The-Actor-Model-everything-you-wanted-to-know-but-were-afraid-to-ask).
Carl Hewitt is the creator of the Actor model. The Actor model has been famously
implemented by [Joe Armstrong](http://joearms.github.io/) in the Erlang
programming language. With the recent purchase of WhatsApp by Facebook for
billions of dollars, Erlang, and to a lesser extent the Actor model, have all
seen an uptick in interest because of WhatsApp's use of Erlang.

Personally, in the past year or so I've become fascinated with studying the many
concurrency models. Learning about event loops, process forking,
multi-threading and channels was rather straight forward as they were somewhat
easy to conceputalize technically. The Actor model was easy to conceptualize
visually, a bunch of entities communicating with each other by sharing
messages, but hard for me to understand technically.

I really wanted to understand the Actor model so I took some notes while I was
watching the video. I've put the [notes in a gist on
GitHub](https://gist.github.com/rbishop/9082539) for others to see, comment on
and hopefully make even better. I think understanding concurrency
implementations should be important to Rubyists. Language performance does
matter and if the right abstractions are what takes Ruby from a slow but
enjoyable language to a medium/fast and enjoyable language I think that is a
huge win. Ruby also happens to have an implementation of Actors named
[Celluloid](https://github.com/celluloid/celluloid) that is gaining
considerable traction. It's exciting times to say the least.

The video is from some sort of Microsoft event where Carl Hewitt gets pulled
into a room and is asked questions about the Actor model from a few other
seemingly really smart guys. The result is a great video really breaking down
the Actor model. Below are links to the video as well as my gist of notes:

[Hewitt, Meyer, and Szyperski: The Actor Model \(everything you wanted to know,
but were afraid to
ask\)](http://channel9.msdn.com/Shows/Going+Deep/Hewitt-Meijer-and-Szyperski-The-Actor-Model-everything-you-wanted-to-know-but-were-afraid-to-ask)

[My notes from the above video](https://gist.github.com/rbishop/9082539)
