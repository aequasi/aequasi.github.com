---
layout: post
title: "Symfony 2 and Memcached: A new Bundle"
description: "Symfony2 and Memcached caching in PHP. Integrating Doctrine, Session, and User caching with a single bundle."
category: Symfony2
tags: [ symfony2, cache, memcached, php ]
date: 2013-05-23 16:57
comments: true
---

---

### Introduction

So, I started work on a personal project of mine that I wanted to be able to use [`Memcached`][memcached-link]. The project is using the [`Symfony2 PHP framework`][symfony2-link], so I decided to look around a little bit to see if I could find a bundle that does what I needed.

I stumbled upon the [`LswMemcacheBundle`][lsw-memcached-link] at first, and it looked quite nice, having features like `Anti Dog Pile`, and `Profiling` attached to the `Web Profiler Toolbar`. I started looking at the code however, and it had a lot of bloat that I didnt want, some of the terminologies werent right, and it was missing a feature that I wanted. So I took it and decided to write my own.

### The Result

So now, I give you the [`AequasiMemcachedBundle`][aequasi-memcached-link]! This takes a lot of the core logic, and features of the [`LswMemcacheBundle`][lsw-memcached-link], but removes the ability to use the [`Memcache`][memcache-link] extension, and the compatibility with [`Memcached`][memcached-link] versions below `2.0`.

### Features

* Cluster Support
    * Can have mutlple clusters 
* [`Doctrine`][doctrine-link] Support
	* Supports all doctrine cache types (`metadata`, `query`, and `result`)
* Session Support
    * Storing sessions in [`Memcached`][memcached-link] instead of [`PDO`][pdo-link] or `File` 
* Injectable Service
    * Can be used (as a service) wherever the `container` is.
* `Mysql` Key-Map support
    * When storing values in [`Memcached`][memcached-link], a row is added to a mysql table, showing the key, the size of the value, how long the ttl is, and when it should expire. 

### Installing

To install this bundle, check out the source [here][aequasi-memcached-link], and follow the instructions in the readme.

[memcached-link]: http://www.php.net/manual/en/class.memcached.php
[memcache-link]: http://www.php.net/manual/en/class.memcache.php
[pdo-link]: http://www.php.net/manual/en/class.pdo.php

[symfony2-link]: http://www.symfony.com
[doctrine-link]: http://www.doctrine-project.org/

[lsw-memcached-link]: https://github.com/LeaseWeb/LswMemcacheBundle
[aequasi-memcached-link]: https://github.com/aequasi/memcached-bundle
