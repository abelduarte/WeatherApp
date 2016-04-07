//
//  WUWebService.m
//  WeatherApp
//
//  Created by Abel Duarte on 3/2/16.
//  Copyright © 2016 Abel Duarte. All rights reserved.
//

#import "WUWebService.h"
#import "WUDayForecast.h"

NSString * const APIKey = @"5756f8f2747f4e08";
NSString * const APIURL = @"https://api.wunderground.com/api";

@implementation WUWebService

static id sharedInstance = nil;

+ (WUWebService *)sharedWebService
{
	if(!sharedInstance)
		sharedInstance = [[WUWebService alloc] init];
	
	return sharedInstance;
}

- (void)requestForecastWithZipcode:(NSString *)zipcode
				 completionHandler:(void (^)(NSArray *result, NSError *error))handler
{
	NSString *requestURLString = [NSString stringWithFormat:@"%@/%@/forecast/q/%@.json", APIURL, APIKey, zipcode];
	NSURL *requestURL = [NSURL URLWithString:requestURLString];
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL];
	[request setHTTPMethod:@"GET"];
	
	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
	NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
	
	[[session dataTaskWithRequest:request
				completionHandler:^(NSData * _Nullable data,
									NSURLResponse * _Nullable response,
									NSError * _Nullable connectionError)
	{
		NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
																		   options:NSJSONReadingAllowFragments
																			 error:NULL];
		
		NSError *error = connectionError;
		
		if([[responseDictionary objectForKey:@"response"] objectForKey:@"error"])
		{
			NSString *description = [[[responseDictionary objectForKey:@"response"] objectForKey:@"error"] objectForKey:@"description"];
			
			NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
			[errorDetail setValue:description forKey:NSLocalizedDescriptionKey];
			
			error = [NSError errorWithDomain:@"WUWebServiceError" code:404 userInfo:errorDetail];
		}
		
		NSDictionary *forecast = [responseDictionary objectForKey:@"forecast"];
		NSDictionary *simpleForecast = [forecast objectForKey:@"simpleforecast"];
		NSArray *forecastedDays = [simpleForecast objectForKey:@"forecastday"];
		
		NSArray *forecastedAscending = [forecastedDays sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2)
		{
			NSString *epoch1 = [[obj1 objectForKey:@"date"] objectForKey:@"epoch"];
			NSString *epoch2 = [[obj2 objectForKey:@"date"] objectForKey:@"epoch"];
			
			NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[epoch1 doubleValue]];
			NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:[epoch2 doubleValue]];
			
			return [date1 compare:date2];
		}];
		
		NSMutableArray *result = [NSMutableArray array];
		
		for(NSDictionary *forecastedDay in forecastedAscending)
		{
			WUDayForecast *forecast = [[WUDayForecast alloc] initWithForecastDictionary:forecastedDay];
			[result addObject:forecast];
		}
		
		if(handler)
		{
			/* 
			 use GCD to call out to the main thread. NSURLSession seems to call its completion handler on a
			 separate thread as opposed to NSURLConnection.
			*/
			dispatch_async(dispatch_get_main_queue(), ^
			{
				handler(result, error);
			});
		}
	}] resume];
}

#pragma mark - Helpers

- (NSString *)temperatureHighWithForecastDictionary:(NSDictionary *)dailyForecast
{
	NSString *highFahrenheit = [[dailyForecast objectForKey:@"high"] objectForKey:@"fahrenheit"];
	
	return highFahrenheit;
}

- (NSString *)temperatureLowWithForecastDictionary:(NSDictionary *)dailyForecast
{
	NSString *lowFahrenheit = [[dailyForecast objectForKey:@"low"] objectForKey:@"fahrenheit"];
	
	return lowFahrenheit;
}

- (NSString *)nameOfDayWithForecastDictionary:(NSDictionary *)dailyForecast
{
	return [[dailyForecast objectForKey:@"date"] objectForKey:@"weekday"];
}

@end
