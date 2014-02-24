---
layout: post
title: "Never Experience Whitespace Shame Again"
date: 2014-02-12 00:00:00
---

We've all been there before. You finish up the latest and greatest feature, or
better yet, refactoring, and open up the pull request for everyone to marvel at
your latest work of art. Unsurprisingly to you, a bunch of notifications 
roll in five minutes later. Being the amazing developer that you are, you
expect these to be high fives and thumbs ups about how great you are.
Unfortunately for you, these notifications are about *whitespace*.

In the cardinal sins of programming, whitespace is up there along with
unintentional new lines and tabs instead of spaces. Using syntax highlighters,
whitespace can even be highlighted to look like the color of blood. You may as
well have murdered your source code! Thankfully, there are tons of tools to
remove whitespace from files. Your text editor can probably do this for you, or
maybe a shell script. But my personal favorite is good ol' **git**.

### Meet git-stripspace
To most people, git is just an amazing revision control system. Along with
that, git also ships with some other pretty handy tools. ``git-stripspace`` is
one of these such tools. `git-stripspace` does exactly what its name says, it
strips trailing whitespace from the end of lines!

Let's fire up our command line and get acquainted.

### Sample Input
For the rest of this post we will assume you have a file named `whitespace.txt`
with the following contents. I'll use dollar signs ($) to denote where the
whitespace ends, but don't actually put the dollar signs in the file because
then `git-stripspace` won't be able to work its magic.

```
this is a   $
file with a bunch     $


of whitespace!    $
```

### Strip It Real Good
`git-stripspace` is a a subcommand to the main git command. You can run it by
typing the following into your shell:

```
git stripspace < whitespace.txt
```

Let's run that command and take a look at the output. Again, the dollar signs
are only there to denote the real end of the lines. 

```
this is a$
file with a bunch$

of whitespace!$
```

Hotdog! As promised, the whitespace is gone. But you'll also notice, we had two
new lines in between lines 3 and 5 and now we have only one new line. That's
because `git-stripspace` is actually an overachiever. On top of stripping
whitespace it also:

* collapses multiple newlines into a single new line
* removes blank new lines from the beginning of files
* adds a proper line ending to the end of the file

### Taking It Further
Using `git-stripspace` like this is fine and dandy and all but we could just as
easily forget to run this over our files. Also, we're programmers and being
lazy (in a good way!) is an important part of our culture. Let's automate this.

`git` allows you to add filters that then get run at a certain event. One of
these events is `clean` which gets run just before you commit changes. We can
use this `clean` event to run `git-stripspace` every time we commit changes to
files. We'll never commit whitespace crime again!

```
git config --global filter.trimWhitespace.clean git-stripspace
```

The command above creates a filter named "trimWhitespace" that will run all of
our staged files through the `git-stripspace` program every time we commit.
The `--global` flag applies this globally so all of our git repos on our local
machine can benefit from this. After you run this command you should have an
entry that looks like this in your `.gitconfig`:

```
[filter "trimWhitespace"]
	clean = git-stripspace
```

### The End Of The Line
Besides saving you from future whitespace shaming, I hope this was also a
useful look into a great tool that git provides. For more great git reading I
recommend the excellent [git-scm book](http://git-scm.com/book).
