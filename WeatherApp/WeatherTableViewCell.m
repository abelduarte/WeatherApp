//
//  WeatherTableViewCell.m
//  WeatherApp
//
//  Created by Abel Duarte on 3/2/16.
//  Copyright © 2016 Abel Duarte. All rights reserved.
//

#import "WeatherTableViewCell.h"

@implementation WeatherTableViewCell

+ (WeatherTableViewCell *)loadCustomCellFromNibNamed:(NSString *)nibName owner:(id)owner
{
	WeatherTableViewCell *cell = nil;
	
	NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil];
	
	if([nibObjects count] > 0)
	{
		cell = [nibObjects objectAtIndex:0];
	}
	
	return cell;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
