//
//  WeatherTableViewCell.h
//  WeatherApp
//
//  Created by Abel Duarte on 3/2/16.
//  Copyright © 2016 Abel Duarte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherTableViewCell : UITableViewCell
{
}

@property (nonatomic, weak) IBOutlet UILabel *dayLabel;
@property (nonatomic, weak) IBOutlet UILabel *dayLowLabel;
@property (nonatomic, weak) IBOutlet UILabel *dayHighLabel;

+ (WeatherTableViewCell *)loadCustomCellFromNibNamed:(NSString *)nibName owner:(id)owner;

@end
