//
//  WeatherViewController.h
//  WeatherApp
//
//  Created by Abel Duarte on 3/2/16.
//  Copyright © 2016 Abel Duarte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
}

@property (nonatomic, weak) IBOutlet UITextField *zipcodeField;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

- (IBAction)go:(id)sender;

@end

