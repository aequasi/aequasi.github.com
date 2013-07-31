---
layout: post
title: "Jquery: Roll to Next Input"
date: "2013-07-31 05:41"
comments: "true"
categories: jQuery
published: 
  - true
  - "true"
author: Aaron Scherer
---

I was looking for a way to have an input, that when you change, would roll to the next input. The project I'm working on has a page based system, so each page has its own fieldset. When the last field is completed, I wanted it to automatically roll to the next page. I also wanted functionality for zip code, and phone number fields, that would roll to the next input after 5 digits on zip, or roll to the next piece of the phone number field.

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
	var fieldset = $( 'fieldset:visible' ),
		fields = fieldset.find( ':input:visible' ),
		empty = fields.filter(function() { return !$( this ).val().length } ).length;

		if( !empty && fieldset.find( ':input#form_validate' ).length == 0 ) {
			// Show the next page here (Our own custom function)
		}

		// Now for the logic that rolls to the next input on zipcode and phone
		if( $( this ).attr( 'maxlength' ) !== undefined ) {

			//Making sure it was actually a character that was typed
			var inp = String.fromCharCode( event.keyCode );
			if( !(/[a-zA-Z0-9-_ \.]/.test( inp )) ) return true;

			if( $( this ).val().length == $( this ).attr( 'maxlength' ) ) {
				$( this ).blur();

				for( var i in fields ) {
					var index = fields[ i ];
					if( typeof previous != 'undefined' ) return $( index ).focus();
					if( index == this ) var previous = index;
				}
			}
		}
}
```


## End

Voila, your `rollToNext` function is there. All you need to do, is pull a `rollToNext` class on your input. If you need any help implementing this, hit me up in the comments.