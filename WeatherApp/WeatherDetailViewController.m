//
//  WeatherDetailViewController.m
//  WeatherApp
//
//  Created by Abel Duarte on 3/2/16.
//  Copyright © 2016 Abel Duarte. All rights reserved.
//

#import "WeatherDetailViewController.h"
#import "WUDayForecast.h"

@interface WeatherDetailViewController ()

@end

@implementation WeatherDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	/* configure the title with the current day's name */
	self.title = self.forecastedDayDetails.nameOfDay;
	
	/* configure long date header */
	self.longDateLabel.text = self.forecastedDayDetails.longDate;
	
	/* configure the conditions */
	self.conditionsLabel.text = self.forecastedDayDetails.conditions;
	
	/* configure wind speed */
	self.windSpeedLabel.text = self.forecastedDayDetails.windSpeed;
	
	/* configure wind direction */
	self.windDirectionLabel.text = self.forecastedDayDetails.windDirection;
	
	/* configure humidity */
	self.averageHumidityLabel.text = self.forecastedDayDetails.humidity;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
