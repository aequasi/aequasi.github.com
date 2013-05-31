---
layout: post
title: "Symfony2 Testing: Testing Services in Request Scope"
description: "Testing Services in Symfony2 can be difficult, especially when you are using a different scope. Heres how!"
tags: [ 'PHP', 'Symfony2', 'Testing' ]
date: 2013-05-30 18:19
comments: true
categories: [ 'PHP', 'Symfony2' ]
---

Getting into testing at work with one of our new projects, and we need to be able to test our services. The biggest problem I had here, is that we have several services not in the default scope. After a little bit of digging and testing, I came up with this:

``` php RequestServiceTest.php
<?php
/**
 * @author    Aaron Scherer <aaron@undergroundelephant.com>
 * @date      2013
 * @copyright Underground Elephant
 */
namespace Ue\Bundle\RenderBundle\Tests\Service;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;
use Symfony\Component\HttpKernel\HttpKernelInterface;
use Symfony\Component\HttpFoundation\Request;

use Ue\Bundle\RenderBundle\Service\RequestService;

/**
 * RequestServiceTest Class
 */
class RequestServiceTest extends WebTestCase
{

	/**
	 * @var RequestService
	 */
	private $requestService;

	/**
	 * @var
	 */
	private $container;

	/**
	 * {@inheritDoc}
	 */
	public function setUp()
	{
		$container = $this->getContainer();
		$container->enterScope( 'request' );
		$request = Request::create( '/t/1/' );
		$session = $this->getMock( 'Symfony\Component\HttpFoundation\Session\SessionInterface' );
		$request->setSession( $session );
		$this->getContainer()->set( 'request', $request );

		$this->requestService = $this->container->get( 'ue.render.request' );
	}

	/**
	 * {@inheritDoc}
	 */
	public function tearDown()
	{
		$this->getContainer()->leaveScope('request');
	}

	/**
	 * @return mixed
	 */
	public function getContainer()
	{
		if ( $this->container ) {
			return $this->container;
		}

		static::$kernel = static::createKernel( );
		static::$kernel->boot();

		$this->container = static::$kernel->getContainer();

		return $this->container;
	}

	/**
	 * Testing the constructor, and service call
	 */
	public function testRequestService()
	{

		$expected = 'Ue\Bundle\RenderBundle\Service\RequestService';
		$this->assertInstanceOf(
			$expected,
			$this->requestService,
			sprintf( "Expected %s for requestService. Got %s.", $expected, get_class( $this->requestService ) )
		);
	}

	/**
	 * @depends testRequestService
	 */
	public function testBuildRequest()
	{
		$this->requestService->setTestId( 1 );

		$expected = 'Ue\Bundle\RenderBundle\Model\Request';
		$request  = $this->requestService->buildRequest();
		$this->assertInstanceOf(
			$expected,
			$request,
			sprintf( "Expected %s for response from buildRequest(). Got %s instead.", $expected, get_class( $request ) )
		);
	}
}
?>
```

This creates the request (which you need to get the service), sets up the kernel, and because our `RequestService` is in the `request` scope, enters the `request` scope with `$container->enterScope( 'request' );`.
