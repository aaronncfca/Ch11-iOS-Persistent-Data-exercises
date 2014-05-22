//
//  LMASettingsController.m
//  MyContactList CoreData
//
//  Created by Jakob Iversen on 9/9/13.
//  Copyright (c) 2013 Learning Mobile Apps. All rights reserved.
//

#import "LMASettingsController.h"
#import "Constants.h"

@interface LMASettingsController ()

@end

@implementation LMASettingsController

NSArray *sortOrderItems;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //set the UI based on values in NSUserDefaults
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    
    BOOL sortAscending =[settings boolForKey:kSortDirectionAscending];
    if(!sortAscending) { //Check for null
        sortAscending = false;
    }
    _sgmtAscending.selectedSegmentIndex = (sortAscending ? 0 : 1); //Index 0 if ascending, otherwise index 1.
    NSInteger sortField = [settings integerForKey:kSortField];
    if(!sortField) { //Check for null
        sortField = 0;
    }
    _sgmtSortField.selectedSegmentIndex = sortField;
}


- (void)viewVillAppear
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sortDirectionChanged:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //Index 0 = yes, do ascending = !0. Index 1 = no, not ascending = !1
    BOOL doAscending = !_sgmtAscending.selectedSegmentIndex;
    [defaults setBool:doAscending forKey:kSortDirectionAscending];
}

#pragma mark - UIPickerView DataSource
// Returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// Returns the # of rows in the picker
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [sortOrderItems count];
}

//Sets the value that is shown for each row in the picker
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [sortOrderItems objectAtIndex:row];
}

//If the user chooses from the pickerview, it calls this function;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *sortField = [sortOrderItems objectAtIndex:row];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:sortField forKey:kSortField];
    [defaults synchronize];
}

//Handle sort field changed
- (IBAction)sortFieldChanged:(id)sender {
    int sortField = _sgmtSortField.selectedSegmentIndex;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:sortField forKey:kSortField];
}

@end
