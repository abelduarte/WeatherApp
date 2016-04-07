//
//  WeatherAppTests.m
//  WeatherAppTests
//
//  Created by Abel Duarte on 3/2/16.
//  Copyright © 2016 Abel Duarte. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "WUWebService.h"

@interface WeatherAppTests : XCTestCase

@end

@implementation WeatherAppTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testWebServiceWithRealZipcode
{
	__block BOOL finished = NO;
	
    [[WUWebService sharedWebService] requestForecastWithZipcode:@"33178"
											  completionHandler:^(NSDictionary *result, NSError *error)
	{
		finished = YES;
		XCTAssert(result);
	}];
	
	while(!finished)
	{
		/* poll until we get a response from the web server */
		[[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
	}
}

- (void)testWebServiceWithLettersZipcode
{
	__block BOOL finished = NO;
	
	[[WUWebService sharedWebService] requestForecastWithZipcode:@"ABCDEFG"
											  completionHandler:^(NSDictionary *result, NSError *error)
	 {
		 finished = YES;
		 XCTAssert(result);
	 }];
	
	while(!finished)
	{
		/* poll until we get a response from the web server */
		[[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
	}
}

- (void)testWebServiceWithNoZipcode
{
	__block BOOL finished = NO;
	
	[[WUWebService sharedWebService] requestForecastWithZipcode:@""
											  completionHandler:^(NSDictionary *result, NSError *error)
	 {
		 finished = YES;
		 XCTAssert(result);
	 }];
	
	while(!finished)
	{
		/* poll until we get a response from the web server */
		[[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2.0]];
	}
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
