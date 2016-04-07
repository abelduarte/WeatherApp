//
//  WeatherDetailViewController.h
//  WeatherApp
//
//  Created by Abel Duarte on 3/2/16.
//  Copyright © 2016 Abel Duarte. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WUDayForecast;

@interface WeatherDetailViewController : UIViewController
{
}

@property (nonatomic, strong) WUDayForecast *forecastedDayDetails;

@property (weak, nonatomic) IBOutlet UILabel *longDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageHumidityLabel;

@end
