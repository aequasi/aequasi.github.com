---
layout: post
title: "Symfony Reverse Proxy: Memcached"
date: 2013-07-29 14:45
comments: true
categories: [ 'PHP', 'Symfony2', 'Cache' ]
tags: [ 'PHP', 'Symfony2', 'Cache', 'Memcached' ]
---

## The Background

Basically, we wanted to be able to use a simple Reverse Proxy (not Varnish, not Squid), that used a Memcache installation, instead of the file system.

## The Solution - Short

I wrote a new `MemcachedStore` class that `AppCache` now uses instead. The biggest downside is, the configs for the servers isnt used by the AppCache piece.

## The Solution - Long

Heres the [MemcachedStore class](https://gist.github.com/aequasi/6108241). Right now, its set up to use my [`AequasiMemcachedBundle`](https://packagist.org/packages/aequasi/memcached-bundle) symfony bundle at the moment, but it wouldnt be that hard to change to just using `Memcached` or `Memcache`.

Place this file in your `app` directory.

Then, in `app/AppCache.php`, do the following:

1. Require the `MemcachedStore` class at the top

```php
<?php 

require_once __DIR__ . '/AppKernel.php';
require_once __DIR__ . '/MemcachedStore.php';

class AppCache
{
// ...

````

2. Overwrite the `createStore()` function

```php
<?php
//...
class AppCache
{
    // ...
    public function createStore()
    {
        $servers = [
            [ 'localhost', 11211 ]
        ];
    
        return new MemcachedStore( [
            'enabled'      => true,
            'debug'        => true,
            'persistentId' => serialize( $servers )
        ], $servers );
    }
    // ...
}
```

3. ?!?$?

4. Profit.


If you want to create a service to get to this particular store, you would have to create a `$cache` variable in your `app/AppKernel`, and overwrite your `app/AppCache`'s `handle()` method to set the kernel's `$cache` variable before calling `parent::handle`.
