#######
Filters
#######

Filters allow you to perform logic with the incoming ``TPRouteRequest`` before the route's mapped callback is invoked. Filters can be used for authentication, redirecting, analytics, and more.

Filters are used in a filter chain, and are executed sequentially. The sequence is defined by the order in which filters are added to the router (the first filter added is the first execute, the last is the last executed).

Filters themselves are objects that respond to ``TPFilterProtocol``, and as such implement ``- (void) doFilterWithRequest:(TPRouteRequest *)request AndFilterChain:(TPFilterChain *)filterChain``. This is the method that is used to process a ``TPRouteRequest``. In this method, the Filter should call either ``[filterChain.doFilterWithRequest:request]`` to continue the route, or invoke another route from the router to "redirect". If the filter chain is not continued, it is forgotten and is ended.

Filters can either be added to a ``TPRouter`` with the method ``- (void)addFilter:(id <TPFilterProtocol>)filter``, or they can be defined with a block and added with the method ``- (void)addAnonymousFilter:(TPFilterBlock)filterBlock``.

Filter Implementation
=====================

To implement a filter, create a new object that responds to ``TPFilterProtocol``. You must implement the method ``- (void) doFilterWithRequest:(TPRouteRequest *)request AndFilterChain:(TPFilterChain *)filterChain``, and if you want to continue the filter chain, at the end of your implementation you should call ``[filterChain.doFilterWithRequest:request]``. You can also perform a "redirect" by invoking a new route and not calling ``[filterChain.doFilterWithRequest:request]``.

Filters Example
===============

.. codeblock: objc

	@implementation MyCouponFilter
	- (void) doFilterWithRequest:(TPRouteRequest *)request AndFilterChain:(TPFilterChain *)filterChain {
	    if(request.queryParameters && [request.queryParameters valueForKey:@"coupon_id"]) {
	        [CouponProcessor validateAndProcessCoupon:[request.queryParameters valueForKey:@"coupon_id"]];
	    }
	    [filterChain.doFilterWithRequest:request];
	}
	@end

