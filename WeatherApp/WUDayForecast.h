//
//  WUDayForecast.h
//  WeatherApp
//
//  Created by Abel Duarte on 3/3/16.
//  Copyright © 2016 Abel Duarte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WUDayForecast : NSObject
{
}

- (id)initWithForecastDictionary:(NSDictionary *)dictionary;

@property (nonatomic, retain) NSString *temperatureHigh;
@property (nonatomic, retain) NSString *temperatureLow;
@property (nonatomic, retain) NSString *nameOfDay;
@property (nonatomic, retain) NSString *longDate;
@property (nonatomic, retain) NSString *conditions;
@property (nonatomic, retain) NSString *windSpeed;
@property (nonatomic, retain) NSString *windDirection;
@property (nonatomic, retain) NSString *humidity;

@end
