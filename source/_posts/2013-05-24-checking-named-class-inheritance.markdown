---
layout: post
title: "Checking Named Class Inheritance"
description: "Build a function to check class inheritance for a named class, or a class instance"
date: 2013-05-24 15:26
comments: true
categories: [ 'PHP' ]
tags: [ 'PHP', 'Classes', 'OOP' ]
---

---

I have been working on a new cache implementation for the `Symfony2` framework, and I needed a way to check if a named class inherited a given interface , so i wrote the following:

``` php
<?php
function classInherits( $class, $inherit ) {
	if( is_object( $class ) ) {
		return ( $class instanceof $inherit );
	} elseif( is_string( $class ) ) {
		return (bool) in_array( $inherit, class_implements( $class ) );
	}

	throw new Exception( "First value must be the name of a valid class, or an instance of one." );
}
?>
```

Hope this helps!
