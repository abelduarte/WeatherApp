//
//  WUDayForecast.m
//  WeatherApp
//
//  Created by Abel Duarte on 3/3/16.
//  Copyright © 2016 Abel Duarte. All rights reserved.
//

#import "WUDayForecast.h"

@implementation WUDayForecast

- (id)initWithForecastDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	
	if(self)
	{
		self.temperatureHigh = [self temperatureHighWithForecastDictionary:dictionary];
		self.temperatureLow = [self temperatureLowWithForecastDictionary:dictionary];
		self.nameOfDay = [self nameOfDayWithForecastDictionary:dictionary];
		self.longDate = [self longDateWithForecastDictionary:dictionary];
		self.windSpeed = [self windSpeedWithForecastDictionary:dictionary];
		self.windDirection = [self windDirectionWithForecastDictionary:dictionary];
		self.humidity = [self humidityWithForecastDictionary:dictionary];
		self.conditions = [self conditionsWithForecastDictionary:dictionary];
	}
	
	return self;
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

- (NSString *)longDateWithForecastDictionary:(NSDictionary *)dailyForecast
{
	return [[dailyForecast objectForKey:@"date"] objectForKey:@"pretty"];
}

- (NSString *)conditionsWithForecastDictionary:(NSDictionary *)dailyForecast
{
	return [dailyForecast objectForKey:@"conditions"];
}

- (NSString *)windSpeedWithForecastDictionary:(NSDictionary *)dailyForecast
{
	NSNumber *windSpeed = [[dailyForecast objectForKey:@"avewind"] objectForKey:@"mph"];
	return [NSString stringWithFormat:@"%0.02f mph", [windSpeed floatValue]];
}

- (NSString *)windDirectionWithForecastDictionary:(NSDictionary *)dailyForecast
{
	return [[dailyForecast objectForKey:@"avewind"] objectForKey:@"dir"];
}

- (NSString *)humidityWithForecastDictionary:(NSDictionary *)dailyForecast
{
	NSNumber *humidity = [dailyForecast objectForKey:@"avehumidity"];
	return [NSString stringWithFormat:@"%0.02f", [humidity floatValue]];
}

@end
