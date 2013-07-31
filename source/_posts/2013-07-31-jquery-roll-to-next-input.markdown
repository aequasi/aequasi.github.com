---
layout: post
title: "Jquery: Roll to Next Input"
date: 2013-07-31 05:41
comments: true
categories: 
draft: true
---



I was looking for a way to be able to have an input, that when you change, would roll to the next input. The project I'm working on has a page based system, so each page has its own fieldset. When the last field is completed, I wanted it to automatically roll to the next page. I also wanted functionality for zip code, and phone number fields, that would roll to the next input after 5 digits on zip, or roll to the next piece of the phone number field.

### The Solution

Starting off with the binds

```js
$( document ).on( 'keyup click', ':input.rollToNext', rollToNext );
```

Then, the actual function

```js
function rollToNext( event ) {
	switch( event.type ) {
		case 'click':
			if( !$( this ).is( 'select' ) ) return false;
			break;
		case 'keyup':
			var code = event.keyCode ? event.keyCode : event.which;
			if( $( this ).is( 'select' ) && code != 13 && code != 9 ) return false;
			break;
	}

	// If the function has made it here, we should run the roll to next logic
	// Don't have the code in here yet, give me some time to find it again.
}
```


## End

Voila, your rollToNext function is there. All you need to do, is pull a `rollToNext` class on your input
