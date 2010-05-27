//
//  NewBuildingController.m
//  UniversalClient
//
//  Created by Kevin Runde on 4/17/10.
//  Copyright 2010 n/a. All rights reserved.
//

#import "NewBuildingController.h"
#import "LEMacros.h"
#import "Util.h"
#import "LETableViewCellBuildingStats.h"
#import "LETableViewCellCost.h"
#import "LETableViewCellButton.h"
#import "LETableViewCellUnbuildable.h"
#import "LEGetBuildables.h"
#import "LEBuildBuilding.h"


typedef enum {
	ROW_BUILDING_STATS,
	ROW_COST,
	ROW_BUILD
} ROW;

@implementation NewBuildingController


@synthesize listChooser;
@synthesize buildingsByLoc;
@synthesize buttonsByLoc;
@synthesize bodyId;
@synthesize buildables;
@synthesize allBuildings;
@synthesize buildableBuildings;
@synthesize x;
@synthesize y;
@synthesize leGetBuildables;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

	self.listChooser = [[[UISegmentedControl alloc] initWithItems:array_(@"Buildable", @"All")] autorelease];
	[self.listChooser addTarget:self action:@selector(switchList) forControlEvents:UIControlEventValueChanged];
	self.listChooser.segmentedControlStyle = UISegmentedControlStyleBar;
	self.listChooser.selectedSegmentIndex = 0;
	self.navigationItem.titleView = self.listChooser;
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.leGetBuildables = [[[LEGetBuildables alloc] initWithCallback:@selector(buildableLoaded:) target:self bodyId:self.bodyId x:x y:y] autorelease];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.buildables count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	switch (indexPath.row) {
		case ROW_BUILDING_STATS:
			return [LETableViewCellBuildingStats getHeightForTableView:tableView];
			break;
		case ROW_COST:
			return [LETableViewCellCost getHeightForTableView:tableView];
			break;
		case ROW_BUILD:
			; //DO NOT REMOVE
			NSDictionary *building = [self.buildables objectAtIndex:indexPath.section];
			NSDictionary *build = [building objectForKey:@"build"];
			BOOL canBuild = [[build objectForKey:@"can"] boolValue];
			if (canBuild) {
				return [LETableViewCellButton getHeightForTableView:tableView];
			} else {
				return [LETableViewCellUnbuildable getHeightForTableView:tableView];
			}
			break;
		default:
			return 5;
			break;
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *building = [self.buildables objectAtIndex:indexPath.section];
	NSDictionary *build = [building objectForKey:@"build"];
    UITableViewCell *cell;

	switch (indexPath.row) {
		case ROW_BUILDING_STATS:
			; //DO NOT REMOVE
			NSDictionary *stats = [building objectForKey:@"production"];
			LETableViewCellBuildingStats *buildingStatsCell = [LETableViewCellBuildingStats getCellForTableView:tableView];
			[buildingStatsCell setBuildingImage:[UIImage imageNamed:[NSString stringWithFormat:@"/assets/planet_side/100/%@.png", [building objectForKey:@"image"]]]];
			[buildingStatsCell setBuildingName:[building objectForKey:@"name"] buildingLevel:[NSNumber numberWithInt:1]];
			[buildingStatsCell setEnergyPerHour:[stats objectForKey:@"energy_hour"]];
			[buildingStatsCell setFoodPerHour:[stats objectForKey:@"food_hour"]];
			[buildingStatsCell setHappinessPerHour: [stats objectForKey:@"happiness_hour"]];
			[buildingStatsCell setOrePerHour: [stats objectForKey:@"ore_hour"]];
			[buildingStatsCell setWastePerHour:[stats objectForKey:@"waste_hour"]];
			[buildingStatsCell setWaterPerHour:[stats objectForKey:@"water_hour"]];
			cell = buildingStatsCell;
			break;
		case ROW_COST:
			; //DO NOT REMOVE
			NSDictionary *cost = [build objectForKey:@"cost"];
			LETableViewCellCost *costCell = [LETableViewCellCost getCellForTableView:tableView];
			[costCell setEnergyCost:[cost objectForKey:@"energy"]];
			[costCell setFoodCost:[cost objectForKey:@"food"]];
			[costCell setOreCost:[cost objectForKey:@"ore"]];
			[costCell setTimeCost:[cost objectForKey:@"time"]];
			[costCell setWasteCost:[cost objectForKey:@"waste"]];
			[costCell setWaterCost:[cost objectForKey:@"water"]];
			cell = costCell;
			break;
		case ROW_BUILD:
			; //DO NOT REMOVE
			BOOL canBuild = [[build objectForKey:@"can"] boolValue];
			if (canBuild) {
				LETableViewCellButton *buildCell = [LETableViewCellButton getCellForTableView:tableView];
				buildCell.textLabel.text = @"Build";
				cell = buildCell;
			} else {
				LETableViewCellUnbuildable *unbuildableCell = [LETableViewCellUnbuildable getCellForTableView:tableView];
				NSArray *reason = [build objectForKey:@"reason"];
				if ([reason count] > 2) {
					id data = [reason objectAtIndex:2];
					if ([data isKindOfClass:[NSArray class]]) {
						[unbuildableCell setReason:[NSString stringWithFormat:@"%@ (%@:%@)", [reason objectAtIndex:1], [data objectAtIndex:0], [data objectAtIndex:1]]];
					} else {
						[unbuildableCell setReason:[NSString stringWithFormat:@"%@ (%@)", [reason objectAtIndex:1], data]];
					}

				} else {
					[unbuildableCell setReason:[NSString stringWithFormat:@"%@", [reason objectAtIndex:1]]];
				}
				cell = unbuildableCell;
			}
			break;
		default:
			cell = nil;
			break;
	}
    
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == ROW_BUILD) {
		selectedBuilding = indexPath.section;
		NSDictionary *building = [self.buildables objectAtIndex:selectedBuilding];
		NSString *url = [building objectForKey:@"url"];
		[[[LEBuildBuilding alloc] initWithCallback:@selector(buildingBuilt:) target:self bodyId:self.bodyId x:self.x y:self.y url:url] autorelease];
	}
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
	self.listChooser = nil;
	self.bodyId = nil;
	self.buildables = nil;
	self.allBuildings = nil;
	self.buildableBuildings = nil;
	self.x = nil;
	self.y = nil;
	self.buildingsByLoc = nil;
	self.buttonsByLoc = nil;
	[leGetBuildables cancel];
	self.leGetBuildables = nil;
	[super viewDidUnload];
}


- (void)dealloc {
    [super dealloc];
}


#pragma mark -
#pragma mark Instance Methods


- (IBAction)switchList {
	if (self.listChooser.selectedSegmentIndex == 0) {
		self.buildables = self.buildableBuildings;
	} else if (self.listChooser.selectedSegmentIndex == 1) {
		self.buildables = self.allBuildings;
	} else if (self.listChooser.selectedSegmentIndex == 2) {
		self.buildables = [NSArray array];
	}
	
	[self.tableView reloadData];
}


#pragma mark -
#pragma mark Callbacks


- (id)buildableLoaded:(LEGetBuildables *)request {
	self.allBuildings = request.buildables;
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"build.can = 1"];
	self.buildableBuildings = [request.buildables filteredArrayUsingPredicate:predicate];
	
	if (self.listChooser.selectedSegmentIndex == 0) {
		self.buildables = self.buildableBuildings;
	} else if (self.listChooser.selectedSegmentIndex == 1) {
		self.buildables = self.allBuildings;
	} else if (self.listChooser.selectedSegmentIndex == 2) {
		self.buildables = [NSArray array];
	}
	
	[self.tableView reloadData];
	
	return nil;
}


- (id)buildingBuilt:(LEBuildBuilding *)request {
	NSLog(@"Building Built: %@", request);
	
	if (![request wasError]) {
		NSDictionary *buildingBuilding = [self.buildables objectAtIndex:selectedBuilding];
		NSString *image = [buildingBuilding objectForKey:@"image"];
		NSString *name = [buildingBuilding objectForKey:@"name"];
		NSString *url = [buildingBuilding objectForKey:@"url"];
		NSMutableDictionary *building = [NSMutableDictionary dictionaryWithCapacity:7];
		[building setObject:request.buildingId forKey:@"id"];
		[building setObject:name forKey:@"name"];
		[building setObject:self.x forKey: @"x"];
		[building setObject:self.y forKey:@"y"];
		[building setObject:url forKey:@"url"];
		[building setObject:[NSNumber numberWithInt:0] forKey:@"level"];
		[building setObject:image forKey:@"image"];
		NSString *loc = [NSString stringWithFormat:@"%@x%@", self.x, self.y];
		[self.buildingsByLoc setObject:building forKey:loc];
		UIButton *button = [self.buttonsByLoc objectForKey:loc];
		UIImage *tmp = [UIImage imageNamed:[NSString stringWithFormat:@"/assets/planet_side/100/%@.png", [building objectForKey:@"image"]]];
		tmp = [Util imageWithImage:tmp scaledToSize:CGSizeMake(BODY_BUILDINGS_CELL_WIDTH, BODY_BUILDINGS_CELL_HEIGHT)];
		[button setBackgroundImage:tmp forState:UIControlStateNormal];
		[self.navigationController popViewControllerAnimated:TRUE];
	}
	
	return nil;
}


#pragma mark -
#pragma mark Class Methods

+ (NewBuildingController *)create {
	return [[[NewBuildingController alloc] init] autorelease];
}


@end

