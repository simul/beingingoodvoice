//
//  voiceMasterViewController.m
//  VoiceApp
//
//  Created by Flloyd Pauline Kennedy on 1/01/13.
//  Copyright (c) 2013 Flloyd Pauline Kennedy. All rights reserved.
//

#import "voiceMasterViewController.h"

#import "voiceDetailViewController.h"


UIColor* convertWebColour(uint i)
{
	uint R=(i&0xFF0000)>>16;
	uint G=(i&0x00FF00)>>8;
	uint B=i&0x0000FF;
	UIColor *c = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
	return c;
}

@implementation UINavigationBar (BackgroundImage)
//This overridden implementation will patch up the NavBar with a custom Image instead of the title
- (void)drawRect:(CGRect)rect {
	//UIImage *image = [UIImage imageNamed: @"NavigationBar.png"];
	//[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end

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


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	// create the parent view that will hold header Label
	UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];
	
    NSString *title = [self tableView:tableView titleForHeaderInSection:section];
	// create the button object
	UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	headerLabel.backgroundColor = [UIColor clearColor];
	headerLabel.opaque = NO;
	headerLabel.textColor = convertWebColour(0xc6f500);
	headerLabel.highlightedTextColor = [UIColor whiteColor];
	headerLabel.font = [UIFont boldSystemFontOfSize:20];
	headerLabel.frame = CGRectMake(10.0, 0.0, 300.0, 44.0);
    
	// If you want to align the header text as centered
	// headerLabel.frame = CGRectMake(150.0, 0.0, 300.0, 44.0);
    
	headerLabel.text = title; // i.e. array element
	[customView addSubview:headerLabel];
    
	return customView;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.tableView.backgroundView = nil;
    //self.tableView.opaque = NO;
	self.tableView.backgroundColor = convertWebColour(0x560ead);
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


- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
    }
	
}

#pragma mark - Table View

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *str           = [segue identifier];
    //NSIndexPath *indexPath  = [self.tableView indexPathForSelectedRow];
    //NSDate *object          = _objects[indexPath.row];
    [[segue destinationViewController] setDetailItem:str];
}

@end
