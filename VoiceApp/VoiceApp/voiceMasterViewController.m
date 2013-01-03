//
//  voiceMasterViewController.m
//  VoiceApp
//
//  Created by Flloyd Pauline Kennedy on 1/01/13.
//  Copyright (c) 2013 Flloyd Pauline Kennedy. All rights reserved.
//

#import "voiceMasterViewController.h"

#import "voiceDetailViewController.h"

@interface voiceMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation voiceMasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	// create the parent view that will hold header Label
	UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];
	
	// create the button object
	UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	headerLabel.backgroundColor = [UIColor clearColor];
	headerLabel.opaque = NO;
	headerLabel.textColor = [UIColor blackColor];
	headerLabel.highlightedTextColor = [UIColor whiteColor];
	headerLabel.font = [UIFont boldSystemFontOfSize:20];
	headerLabel.frame = CGRectMake(10.0, 0.0, 300.0, 44.0);
    
	// If you want to align the header text as centered
	// headerLabel.frame = CGRectMake(150.0, 0.0, 300.0, 44.0);
    
	headerLabel.text = @"ABC"; // i.e. array element
	[customView addSubview:headerLabel];
    
	return customView;
}*/

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.tableView.backgroundView = nil;
    //self.tableView.opaque = NO;
	self.tableView.backgroundColor = [UIColor colorWithRed:13.0/255.0 green:57.0/255.0 blue:78.0/255.0 alpha:1];
    //self.tableView.tableHeaderView.
	// Do any additional setup after loading the view, typically from a nib.
  /*  self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;*/
    self.detailViewController = (voiceDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *str           = [segue identifier];
    NSIndexPath *indexPath  = [self.tableView indexPathForSelectedRow];
    NSDate *object          = _objects[indexPath.row];
    [[segue destinationViewController] setDetailItem:str];
}

@end
