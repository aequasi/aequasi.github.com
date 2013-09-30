---
layout: post
title: "jQuery Event Priority - Fusion Framework"
date: "2013-09-24 15:36"
tags: 
  - jquery
  - javascript
  - events
  - "fusion-framework"
comments: true
categories: jQuery
published: true
author: Aaron Scherer
---

I've been working on a project at [Underground Elephant][1] that is a very very very heavy javascript project. Its heavily event driven, but I have an issue with the lack of event priorities in jquery. The [Symfony 2 Event Listener][2] is a great example of what an event listener should look like, for a couple reasons. First, and most importantly (to me at least), the events have a priority. Secondly, Events have specific classes that get passed with them, so you know exactly what to expect.

I wanted something like this for javascript, but there was really nothing out there for jQuery. In fact, Dave Methvin([@davemethvin][4]), a member of the jQuery core team, made this comment about a year ago:


> We've discussed this before and decided it's not productive to have handlers that try to out-prioritize each other.
> You're welcome to write something like that implementation as a plugin, as long as it's understood that it uses internals that may change and break the code.

This was a little disappointing to me, but I can understand a little why they made this decision.

So, with all this, I decided to make a small little addoon for jQuery that allows for creating custom events. The custom events can have priorties, and require a defined "class" (as javascript uses it).

Without further ado, i present to you: [Fusion Framework][5]

DISCLAIMER
==========

As of right now, this framework only supports custom events.
You cannot use this for events that are meant to be bound to elements.


Requirements
============

This framework requires jQuery 1.9 or higher.

To Use
======


#### Creating Events

Right now, there are only two built in events. `DOCUMENT_LOAD`, and `DOCUMENT_UNLOAD`.
To use your own custom events, you need to add them to the event list, which can be done as follows:

```js
( function( fusion ) {
    fusion.events.add( 'SOME_EVENT_NAME', fusion.event.extend( { somevar: null } ) );

    // You can store those in classes too. For example, the DOCUMENT_LOAD stuff
    var func = fusion.event.extend( {
		window: window,
		document: document
    } );

    fusion.events.add( 'DOCUMENT_LOAD', func );

} )( $.fn.fusion );
```


#### Binding Events (with priorities)

To bind to these events, we will be using the `fuse` method. Pretty simple, from the demo app:

You can get to the event's data with `event.getData( [key] )`.

```js
// Note, by default $f is an alias of $.fn.fusion

// Create your first event. This has a default priority of 50.
$f.fuse( 'DOCUMENT_LOAD', function( event ) {
    event.getData( 'window' ).location.href += "#test";
} );

// Later down the line in your app, you want something bound before the above.
// So we create another bind, but set the priority to something lower than 50 (5 here).
$f.fuse( 'DOCUMENT_LOAD', function( event ) {
    event.getData( 'window' ).location.href += "#highesttest";
}, 5 );

// Even later down, we want something bound after the other two events.
// So we create another bind, but set the priority to something higher than 50 (70 here).
$f.fuse( 'DOCUMENT_LOAD', function( event ) {
    event.getData( 'window' ).location.href += "#test";
}, 70 );
```

You now have three binds on the `DOCUMENT_LOAD` event.



#### Firing Events

To fire these events, just call the `ignite` method, and pass in the event class's variables. Super simple.

For example, the `DOCUMENT_LOAD` and `DOCUMENT_UNLOAD` events.

```js
$(function () {
    fusion.ignite( 'DOCUMENT_LOAD', { window: window, cheese: 'cheese' } );
    $( document ).unload( function( ) {
        fusion.ignite( 'DOCUMENT_UNLOAD', { window: window } );
    } )
});
```

If you noticed, as a test, I've added `cheese: 'cheese'` to the `DOCUMENT_LOAD` event, to see if you could access that on the page.
You can test this yourself, but in the binds, you wont be able to access the `cheese` data, because it was never in the class properties.


Contributions
=============

If you would like to help with contributing, please do! Just fork this code, make your changes and put in a pull request.
I would love for this framework to work with element bound events, but I don't have enough time to figure that out.


[1]: http://www.undergroundelephant.com/
[2]: http://symfony.com/doc/current/components/event_dispatcher/introduction.html
[4]: https://twitter.com/davemethvin
[5]: https://github.com/fusion-events/fusion-framework
