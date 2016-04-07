//
//  WUWebService.h
//  WeatherApp
//
//  Created by Abel Duarte on 3/2/16.
//  Copyright © 2016 Abel Duarte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WUWebService : NSObject
{
}

+ (WUWebService *)sharedWebService;

- (void)requestForecastWithZipcode:(NSString *)zipcode
				 completionHandler:(void (^)(NSArray *forecastedDays, NSError *error))handler;

@end
