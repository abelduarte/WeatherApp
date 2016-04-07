//
//  WeatherViewController.m
//  WeatherApp
//
//  Created by Abel Duarte on 3/2/16.
//  Copyright © 2016 Abel Duarte. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherTableViewCell.h"
#import "WUWebService.h"
#import "WeatherDetailViewController.h"
#import "WUDayForecast.h"

@interface WeatherViewController ()
{
}

@property (nonatomic, retain) NSArray *dayForecasts;

@end

@implementation WeatherViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	/* hide table view while there are no records to show */
	self.tableView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - User Actions

- (IBAction)go:(id)sender
{
	[self.zipcodeField resignFirstResponder];
	
	NSString *zipcode = [self.zipcodeField text];
	
	if(zipcode.length != 5)
	{
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Zipcode"
																	   message:@"Please enter a valid 5 digit zipcode"
																preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Okay"
																style:UIAlertActionStyleDefault
															  handler:NULL];
		
		[alert addAction:defaultAction];
		[self presentViewController:alert animated:YES completion:nil];
		
		return;
	}
	
	/*
	NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"mock" ofType:@"json"];
	NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
	
	NSDictionary *forecastResult = [NSJSONSerialization JSONObjectWithData:jsonData
														   options:NSJSONReadingAllowFragments
															 error:NULL];
	 
	 NSDictionary *forecast = [forecastResult objectForKey:@"forecast"];
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
	 
	 self.dayForecasts = [NSArray arrayWithArray:forecastedAscending];
	 
	 [self.tableView reloadData];
	 */
	
	[[WUWebService sharedWebService] requestForecastWithZipcode:zipcode
											  completionHandler:^(NSArray *forecastResults, NSError *error)
	{
		if(error)
		{
			UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
																		   message:error.localizedDescription
																	preferredStyle:UIAlertControllerStyleAlert];
			
			UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Okay"
																	style:UIAlertActionStyleDefault
																  handler:NULL];
			
			[alert addAction:defaultAction];
			[self presentViewController:alert animated:YES completion:nil];
		}
		else
		{
			self.dayForecasts = forecastResults;
			
			/* unhide the table view if we retrieved any weather forecast records */
			if(self.dayForecasts.count)
			{
				self.tableView.hidden = NO;
				[self.tableView reloadData];
			}

		}
	}];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if([[segue identifier] isEqualToString:@"WeatherDetailsSegue"])
	{
		/* get the forecasted day's details */
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		WUDayForecast *forecastedDayDetails = [self.dayForecasts objectAtIndex:indexPath.row];
		
		/* pass the forecasted day's details to the detail view controller */
		WeatherDetailViewController *detailViewController = [segue destinationViewController];
		detailViewController.forecastedDayDetails = forecastedDayDetails;
		
		/* deselected the selected row */
		[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 94.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.dayForecasts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	WeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherCell"];
	
	if(!cell)
	{
		cell = [WeatherTableViewCell loadCustomCellFromNibNamed:@"WeatherTableViewCell"
														  owner:self];
	}
	
	WUDayForecast *forecastDay = [self.dayForecasts objectAtIndex:indexPath.row];
	
	cell.dayLabel.text = forecastDay.nameOfDay;
	cell.dayLowLabel.text = forecastDay.temperatureLow;
	cell.dayHighLabel.text = forecastDay.temperatureHigh;
	
	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self performSegueWithIdentifier:@"WeatherDetailsSegue" sender:self];
}


@end
