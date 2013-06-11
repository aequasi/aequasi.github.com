---
layout: post
title: "Better Symfony Environments: Large Systems"
date: 2013-06-10 23:26
comments: true
categories: [ 'PHP', 'Symfony' ]
tags: [ 'PHP', 'Symfony2', 'Apache', 'Environment' ]
---

## The Background

At my work, we deal with a project where we have several development servers, a few staging servers, and hundreds of production servers. 

## The Issue
Having to deal with all four different environment types, without having environments hardcoded into the project is a little weird, and currently lacks much any real solutions, regarding symfony's documentation.

## The Solution - Short

In short, I implemented a class that we use in `app/console` and `web/app.php`, that reads an Apache environment variable.

## The Solution - Long

Like I said above, I made an `Environment` class to check what environment the server belongs in. I made it a gist for you guys: https://gist.github.com/5753723.git.

Basically, this environment class, can take an `ArgvInput` param as a constructor, and if it does, it assumes that it's CLI. If it's CLI, it will do the same CLI checks the symfony does by default for `$env`, and `$debug`. Cli and web both allow for specifying `symfony.environment` in php.ini as well, and the web piece allows you to specify an apache env variable (e.g. `SetEnv SYM_ENV stage`).

Once you've got that code, place it into `app/Environment.php` (you'll have to create it). From there, copy the logic I've got for `app/consle` and `web/app.php` below.

``` php console
<?php
set_time_limit(0);

require_once __DIR__.'/bootstrap.php.cache';
require_once __DIR__.'/AppKernel.php';
require_once __DIR__ .'/../app/Environment.php';

use Symfony\Bundle\FrameworkBundle\Console\Application;
use Symfony\Component\Console\Input\ArgvInput;

$input = new ArgvInput( );
$env = new \Environment( $input );


$kernel = new AppKernel( $env->getEnvironment(), $env->getDebug() );
$application = new Application($kernel);
$application->run( $input );
```

``` php app.php
<?php

use Symfony\Component\HttpFoundation\Request;

$loader = require_once __DIR__.'/../app/bootstrap.php.cache';
require_once __DIR__.'/../app/AppKernel.php';
require_once __DIR__ .'/../app/Environment.php';

$env = new \Environment();

$kernel = new AppKernel( $env->getEnvironment(), $env->getDebug() );
$kernel->loadClassCache();
Request::enableHttpMethodParameterOverride();
$request = Request::createFromGlobals();
$response = $kernel->handle($request);
$response->send();
$kernel->terminate($request, $response);
```
