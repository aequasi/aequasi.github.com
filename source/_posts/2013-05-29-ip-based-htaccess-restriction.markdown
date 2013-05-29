---
layout: post
title: "IP Based Htaccess Restriction"
date: 2013-05-29 07:01
description: "Use .htaccess to restrict people outside of a given IP to an .htpasswd file"
comments: true
categories: [ 'apache', 'htaccess' ]
tags: [ 'apache', 'apache2', 'htaccess', 'htpasswd' ]
---

A couple months ago, I was looking for a way to restrict a development site in such a way, that while people were at work (where we have a static IP), and then require an `.htpasswd` file for everyone outside.

Well, it was actually kind of simple. After youve got your `.htpasswd` file set up, just throw this inside your vhost

``` apache
AuthName "Change This"
AuthUserFile /path/to/.htpasswd
AuthType Basic
Satisy Any
<Limit GET POST>
	Order Deny,Allow
	Deny from all
	Allow from 12.34.56.789
	Require valid-user
</Limit>
```
For your environment, you should change the `AuthName`, the `AuthUserFile`, the `Limit` (maybe, `GET` and `POST` might be enough), and the `IP` (`12.34.56.789`).

Change out the variables for what your environment requires, and you should be all set.
