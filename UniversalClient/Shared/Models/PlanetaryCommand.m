//
//  PlanetaryCommand.m
//  UniversalClient
//
//  Created by Kevin Runde on 7/14/10.
//  Copyright 2010 n/a. All rights reserved.
//

#import "PlanetaryCommand.h"
#import "LEMacros.h"
#import "Util.h"
#import "Session.h"
#import "BuildingUtil.h"
#import "Plan.h"
#import "LEBuildingViewPlans.h"
#import "LETableViewCellButton.h"
#import "LETableViewCellLabeledIconText.h"
#import "ViewPlansController.h"


@implementation PlanetaryCommand


@synthesize nextColonyCost;
@synthesize plans;
//RedOrion
@synthesize population;
//RedOrion
@synthesize buildingCount;


#pragma mark -
#pragma mark NSObject Methods

//RedOrion
- (NSString *)description {
	return [NSString stringWithFormat:@"population:%@, buildingCount:%@",
			self.population, self.buildingCount];
}


- (void)dealloc {
	self.nextColonyCost = nil;
	self.plans = nil;
    //RedOrion
    self.population = nil;
    //RedOrion
    self.buildingCount = nil;
	[super dealloc];
}



#pragma mark -
#pragma mark Overriden Building Methods

- (void)parseAdditionalData:(NSDictionary *)bodyData {
    [super parseData:bodyData];
	self.nextColonyCost = [Util asNumber:[bodyData objectForKey:@"next_colony_cost"]];
    self.buildingCount = [Util asNumber:[bodyData objectForKey:@"building_count"]];
    if (!self.population) {
        self.population = [[[NSDecimalNumber alloc] init] autorelease];
    }
    [self.population parseFromData:bodyData withPrefix:@"population"];
}
/*    NSDictionary *data = [bodyData objectForKey:@"empire"];
    self.population = [Util asNumber:[bodyData objectForKey:@"population"]];
    self.buildingCount = [Util asNumber:[bodyData objectForKey:@"building_count"]];
}
*/
/*self.buildingCount = [Util asNumber:[bodyData objectForKey:@"building_count"]];
if (!self.population) {
    self.population = [[[NoLimitResource alloc] init] autorelease];
}
[self.population parseFromData:bodyData withPrefix:@"population"];
}
*/
 
//RedOrion
//NSMutableDictionary
/*- (void)parseData:(NSDictionary *)planet {
    NSDictionary *planet = [planet objectForKey:@"planet"];
    //[super parseData:planet];
    self.population = [Util asNumber:[planet objectForKey:@"population"]];
    self.building_count = [Util asNumber:[planet objectForKey:@"building_count"]];
}
*/

- (void)generateSections {
	NSMutableDictionary *nextColonySection = _dict([NSDecimalNumber numberWithInt:BUILDING_SECTION_NEXT_COLONY], @"type",
												   @"Next Colony", @"name",
												   _array([NSDecimalNumber numberWithInt:BUILDING_ROW_NEXT_COLONY_COST], [NSDecimalNumber numberWithInt:BUILDING_ROW_CURRENT_HAPPINESS]), @"rows");
	
	NSMutableDictionary *actions = _dict([NSDecimalNumber numberWithInt:BUILDING_SECTION_ACTIONS], @"type",
												   @"Actions", @"name",
												   _array([NSDecimalNumber numberWithInt:BUILDING_ROW_VIEW_PLANS]), @"rows");
    NSMutableDictionary *planetInfo = _dict([NSDecimalNumber numberWithInt:BUILDING_SECTION_PLANET_INFO], @"type",
                                         @"Planet Info", @"name",
                                         _array([NSDecimalNumber numberWithInt:BUILDING_ROW_VIEW_POPULATION], [NSDecimalNumber numberWithInt:BUILDING_ROW_BUILDING_COUNT]), @"rows");
	
	self.sections = _array([self generateProductionSection], actions, nextColonySection, planetInfo, [self generateHealthSection], [self generateUpgradeSection], [self generateGeneralInfoSection]);
}


- (CGFloat)tableView:(UITableView *)tableView heightForBuildingRow:(BUILDING_ROW)buildingRow {
	switch (buildingRow) {
		case BUILDING_ROW_NEXT_COLONY_COST:
		case BUILDING_ROW_CURRENT_HAPPINESS:
			return [LETableViewCellLabeledIconText getHeightForTableView:tableView];
			break;
        //RedOrion
        case BUILDING_ROW_VIEW_POPULATION:
            return [LETableViewCellLabeledIconText getHeightForTableView:tableView];
            break;
		case BUILDING_ROW_VIEW_PLANS:
			return [LETableViewCellButton getHeightForTableView:tableView];
			break;
		default:
			return [super tableView:tableView heightForBuildingRow:buildingRow];
			break;
	}
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForBuildingRow:(BUILDING_ROW)buildingRow rowIndex:(NSInteger)rowIndex {
	UITableViewCell *cell = nil;
	switch (buildingRow) {
		case BUILDING_ROW_NEXT_COLONY_COST:
			; //DON'T REMOVE THIS!! IF YOU DO THIS WON'T COMPILE
			LETableViewCellLabeledIconText *nextColonyCostCell = [LETableViewCellLabeledIconText getCellForTableView:tableView isSelectable:NO];
			nextColonyCostCell.label.text = @"Cost";
			nextColonyCostCell.icon.image = HAPPINESS_ICON;
			nextColonyCostCell.content.text = [Util prettyNSDecimalNumber:self.nextColonyCost];
			cell = nextColonyCostCell;
			break;
		case BUILDING_ROW_CURRENT_HAPPINESS:
			; //DON'T REMOVE THIS!! IF YOU DO THIS WON'T COMPILE
			LETableViewCellLabeledIconText *currentHappinessCell = [LETableViewCellLabeledIconText getCellForTableView:tableView isSelectable:NO];
			currentHappinessCell.label.text = @"Current";
			currentHappinessCell.icon.image = HAPPINESS_ICON;
			Session *session = [Session sharedInstance];
			currentHappinessCell.content.text = [Util prettyNSDecimalNumber:session.body.happiness.current];
			cell = currentHappinessCell;
			break;
        //RedOrion
        case BUILDING_ROW_VIEW_POPULATION:
			; //DON'T REMOVE THIS!! IF YOU DO THIS WON'T COMPILE
			LETableViewCellLabeledIconText *currentPopulationCell = [LETableViewCellLabeledIconText getCellForTableView:tableView isSelectable:NO];
			currentPopulationCell.label.text = @"Population";
// No population Icon that I know of
//			currentPopulationCell.icon.image = HAPPINESS_ICON;
			currentPopulationCell.content.text = [Util prettyNSDecimalNumber:self.population];
			cell = currentPopulationCell;
			break;
            //RedOrion
        case BUILDING_ROW_BUILDING_COUNT:
			; //DON'T REMOVE THIS!! IF YOU DO THIS WON'T COMPILE
			LETableViewCellLabeledIconText *planetBuildingCount = [LETableViewCellLabeledIconText getCellForTableView:tableView isSelectable:NO];
			planetBuildingCount.label.text = @"Building Count";
			planetBuildingCount.icon.image = BUILD_ICON;
			planetBuildingCount.content.text = [Util prettyNSDecimalNumber:self.buildingCount];
			cell = planetBuildingCount;
			break;
		case BUILDING_ROW_VIEW_PLANS:
			; //DO NOT REMOVE
			LETableViewCellButton *viewPlansCell = [LETableViewCellButton getCellForTableView:tableView];
			viewPlansCell.textLabel.text = @"View Plans";
			cell = viewPlansCell;
			break;
		default:
			cell = [super tableView:tableView cellForBuildingRow:buildingRow rowIndex:rowIndex];
			break;
	}
	
	return cell;
}


- (UIViewController *)tableView:(UITableView *)tableView didSelectBuildingRow:(BUILDING_ROW)buildingRow rowIndex:(NSInteger)rowIndex {
	switch (buildingRow) {
		case BUILDING_ROW_VIEW_PLANS:
			; //DO NOT REMOVE
			ViewPlansController *viewPlansController = [ViewPlansController create];
			viewPlansController.buildingWithPlans = self;
			return viewPlansController;
			break;
		default:
			return [super tableView:tableView didSelectBuildingRow:buildingRow rowIndex:rowIndex];
			break;
	}
}


#pragma mark -
#pragma mark Instance Methods

- (void)loadPlans {
	[[[LEBuildingViewPlans alloc] initWithCallback:@selector(plansLoaded:) target:self buildingId:self.id buildingUrl:self.buildingUrl] autorelease];
}

#pragma mark -
#pragma mark Callback Methods

- (id)plansLoaded:(LEBuildingViewPlans *)request {
	NSMutableArray *tmpPlans = [NSMutableArray arrayWithCapacity:[request.plans count]];
	for (NSDictionary *planData in request.plans) {
		Plan *plan = [[[Plan alloc] init] autorelease];
		[plan parseData:planData];
		[tmpPlans addObject:plan];
	}
	
	self.plans = tmpPlans;
	return nil;
}


@end
