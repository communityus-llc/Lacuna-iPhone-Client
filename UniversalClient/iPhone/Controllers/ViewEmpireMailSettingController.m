//
//  ViewEmpireMailSettingController.m
//  UniversalClient
//
//  Created by Kevin Runde on 9/23/10.
//  Copyright 2010 n/a. All rights reserved.
//
//	Updated by Bernard Kluskens on 6/12/13


#import "ViewEmpireMailSettingController.h"
#import "LEMacros.h"
#import "Util.h"
#import "LEViewSectionTab.h"
#import "EmpireProfile.h"
#import "LEEmpireEditProfile.h"

typedef enum {
	SECTION_MAIL_FILTERS,
	SECTION_SERVER_SETTINGS,
	SECTION_COUNT,
} SECTION;

typedef enum {
	MAIL_FILTERS_ROW_HAPPINESS,
	MAIL_FILTERS_ROW_RESOURCE,
	MAIL_FILTERS_ROW_POLLUTION,
	MAIL_FILTERS_ROW_MEDAL,
	MAIL_FILTERS_ROW_FACEBOOK_WALL_POSTS,
	MAIL_FILTERS_ROW_FOUND_NOTHING,
	MAIL_FILTERS_ROW_EXCAVATOR_RESOURCES,
	MAIL_FILTERS_ROW_EXCAVATOR_GLYPH,
	MAIL_FILTERS_ROW_EXCAVATOR_PLAN,
	MAIL_FILTERS_ROW_SPY_RECOVERY,
	MAIL_FILTERS_ROW_PROBE_DETECTED,
	MAIL_FILTERS_ROW_ATTACK_MESSAGES,
	MAIL_FILTERS_ROW_SKIP_EXCAVATOR_REPLACE_MSG,
	MAIL_FILTERS_ROW_COUNT,
} MAIL_FILTERS_ROW;

typedef enum {
	SERVER_SETTINGS_ROW_DO_NOT_REPLACE_EXCAVATOR_AUTOMATICALLY,
	SERVER_SETTINGS_ROW_COUNT,
} SERVER_SETTINGS_ROW;

@implementation ViewEmpireMailSettingController


@synthesize skipHappinessWarningsCell;
@synthesize skipResourceWarningsCell;
@synthesize skipPollutionWarningsCell;
@synthesize skipMedalMessagesCell;
@synthesize skipFacebookWallPostsCell;
@synthesize skipFoundNothingCell;
@synthesize skipExcavatorResourcesCell;
@synthesize skipExcavatorGlyphCell;
@synthesize skipExcavatorPlanCell;
@synthesize skipSpyRecoveryCell;
@synthesize skipProbeDetectedCell;
@synthesize skipAttackMessagesCell;
@synthesize skipExcavatorReplaceMsg;
@synthesize dontReplaceExcavator;
@synthesize empireProfile;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	self.navigationItem.title = @"Settings";
	self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil] autorelease];
	
	self.sectionHeaders = _array([LEViewSectionTab tableView:self.tableView withText:@"Mail Filters"],
								 [LEViewSectionTab tableView:self.tableView withText:@"Server Settings"]);
	
	self.skipHappinessWarningsCell = [LETableViewCellLabeledSwitch getCellForTableView:self.tableView];
	self.skipHappinessWarningsCell.label.text = @"Happiness Warnings";
	self.skipHappinessWarningsCell.label.font = LABEL_FONT;
	self.skipHappinessWarningsCell.isSelected = !self.empireProfile.skipHappinessWarnings;
	self.skipHappinessWarningsCell.delegate = self;
	
	self.skipResourceWarningsCell = [LETableViewCellLabeledSwitch getCellForTableView:self.tableView];
	self.skipResourceWarningsCell.label.text = @"Resource Warnings";
	self.skipResourceWarningsCell.label.font = LABEL_FONT;
	self.skipResourceWarningsCell.isSelected = !self.empireProfile.skipResourceWarnings;
	self.skipResourceWarningsCell.delegate = self;
	
	self.skipPollutionWarningsCell = [LETableViewCellLabeledSwitch getCellForTableView:self.tableView];
	self.skipPollutionWarningsCell.label.text = @"Pollution Warnings";
	self.skipPollutionWarningsCell.label.font = LABEL_FONT;
	self.skipPollutionWarningsCell.isSelected = !self.empireProfile.skipPollutionWarnings;
	self.skipPollutionWarningsCell.delegate = self;
	
	self.skipMedalMessagesCell = [LETableViewCellLabeledSwitch getCellForTableView:self.tableView];
	self.skipMedalMessagesCell.label.text = @"Medal Messages";
	self.skipMedalMessagesCell.label.font = LABEL_FONT;
	self.skipMedalMessagesCell.isSelected = !self.empireProfile.skipMedalMessages;
	self.skipMedalMessagesCell.delegate = self;
	
	self.skipFacebookWallPostsCell = [LETableViewCellLabeledSwitch getCellForTableView:self.tableView];
	self.skipFacebookWallPostsCell.label.text = @"Facebook Wall Posts";
	self.skipFacebookWallPostsCell.label.font = LABEL_FONT;
	self.skipFacebookWallPostsCell.isSelected = !self.empireProfile.skipFacebookWallPosts;
	self.skipFacebookWallPostsCell.delegate = self;
	
	self.skipFoundNothingCell = [LETableViewCellLabeledSwitch getCellForTableView:self.tableView];
	self.skipFoundNothingCell.label.text = @"Found Nothing";
	self.skipFoundNothingCell.label.font = LABEL_FONT;
	self.skipFoundNothingCell.isSelected = !self.empireProfile.skipFoundNothing;
	self.skipFoundNothingCell.delegate = self;
	
	self.skipExcavatorResourcesCell = [LETableViewCellLabeledSwitch getCellForTableView:self.tableView];
	self.skipExcavatorResourcesCell.label.text = @"Excavator Resources";
	self.skipExcavatorResourcesCell.label.font = LABEL_FONT;
	self.skipExcavatorResourcesCell.isSelected = !self.empireProfile.skipExcavatorResources;
	self.skipExcavatorResourcesCell.delegate = self;
	
	self.skipExcavatorGlyphCell = [LETableViewCellLabeledSwitch getCellForTableView:self.tableView];
	self.skipExcavatorGlyphCell.label.text = @"Excavator Glyphs";
	self.skipExcavatorGlyphCell.label.font = LABEL_FONT;
	self.skipExcavatorGlyphCell.isSelected = !self.empireProfile.skipExcavatorGlyph;
	self.skipExcavatorGlyphCell.delegate = self;
	
	self.skipExcavatorPlanCell = [LETableViewCellLabeledSwitch getCellForTableView:self.tableView];
	self.skipExcavatorPlanCell.label.text = @"Excavator Plan";
	self.skipExcavatorPlanCell.label.font = LABEL_FONT;
	self.skipExcavatorPlanCell.isSelected = !self.empireProfile.skipExcavatorPlan;
	self.skipExcavatorPlanCell.delegate = self;
	
	self.skipSpyRecoveryCell = [LETableViewCellLabeledSwitch getCellForTableView:self.tableView];
	self.skipSpyRecoveryCell.label.text = @"Spy Recovery";
	self.skipSpyRecoveryCell.label.font = LABEL_FONT;
	self.skipSpyRecoveryCell.isSelected = !self.empireProfile.skipSpyRecovery;
	self.skipSpyRecoveryCell.delegate = self;
	
	self.skipProbeDetectedCell = [LETableViewCellLabeledSwitch getCellForTableView:self.tableView];
	self.skipProbeDetectedCell.label.text = @"Probe Detected";
	self.skipProbeDetectedCell.label.font = LABEL_FONT;
	self.skipProbeDetectedCell.isSelected = !self.empireProfile.skipProbeDetected;
	self.skipProbeDetectedCell.delegate = self;
	
	self.skipAttackMessagesCell = [LETableViewCellLabeledSwitch getCellForTableView:self.tableView];
	self.skipAttackMessagesCell.label.text = @"Attack Messages";
	self.skipAttackMessagesCell.label.font = LABEL_FONT;
	self.skipAttackMessagesCell.isSelected = !self.empireProfile.skipAttackMessages;
	self.skipAttackMessagesCell.delegate = self;
    
	self.skipExcavatorReplaceMsg = [LETableViewCellLabeledSwitch getCellForTableView:self.tableView];
	self.skipExcavatorReplaceMsg.label.text = @"Excavator Replace Alert";
	self.skipExcavatorReplaceMsg.label.font = LABEL_FONT;
	self.skipExcavatorReplaceMsg.isSelected = !self.empireProfile.skipExcavatorReplaceMsg;
	self.skipExcavatorReplaceMsg.delegate = self;
    
	self.dontReplaceExcavator = [LETableViewCellLabeledSwitch getCellForTableView:self.tableView];
	self.dontReplaceExcavator.label.text = @"Auto Replace Excavators";
	self.dontReplaceExcavator.label.font = LABEL_FONT;
	self.dontReplaceExcavator.isSelected = !self.empireProfile.dontReplaceExcavator;
	self.dontReplaceExcavator.delegate = self;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	//return 1;
	return SECTION_COUNT;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//return ROW_COUNT;
	switch (section) {
		case SECTION_MAIL_FILTERS:
			//return 13
			return MAIL_FILTERS_ROW_COUNT;
			break;
		case SECTION_SERVER_SETTINGS:
			//return 1;
			return SERVER_SETTINGS_ROW_COUNT;
			break;
		default:
			return 0;
			break;
	}
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	//return [LETableViewCellLabeledSwitch getHeightForTableView:tableView];
	switch (indexPath.section) {
		case SECTION_MAIL_FILTERS:
			switch (indexPath.row) {
				case MAIL_FILTERS_ROW_HAPPINESS:
					return [LETableViewCellLabeledSwitch getHeightForTableView:tableView];
					break;
				case MAIL_FILTERS_ROW_RESOURCE:
					return [LETableViewCellLabeledSwitch getHeightForTableView:tableView];
					break;
				case MAIL_FILTERS_ROW_POLLUTION:
					return [LETableViewCellLabeledSwitch getHeightForTableView:tableView];
					break;
				case MAIL_FILTERS_ROW_MEDAL:
					return [LETableViewCellLabeledSwitch getHeightForTableView:tableView];
					break;
				case MAIL_FILTERS_ROW_FACEBOOK_WALL_POSTS:
					return [LETableViewCellLabeledSwitch getHeightForTableView:tableView];
					break;
				case MAIL_FILTERS_ROW_FOUND_NOTHING:
					return [LETableViewCellLabeledSwitch getHeightForTableView:tableView];
					break;
				case MAIL_FILTERS_ROW_EXCAVATOR_RESOURCES:
					return [LETableViewCellLabeledSwitch getHeightForTableView:tableView];
					break;
				case MAIL_FILTERS_ROW_EXCAVATOR_GLYPH:
					return [LETableViewCellLabeledSwitch getHeightForTableView:tableView];
					break;
				case MAIL_FILTERS_ROW_EXCAVATOR_PLAN:
					return [LETableViewCellLabeledSwitch getHeightForTableView:tableView];
					break;
				case MAIL_FILTERS_ROW_SPY_RECOVERY:
					return [LETableViewCellLabeledSwitch getHeightForTableView:tableView];
					break;
				case MAIL_FILTERS_ROW_PROBE_DETECTED:
					return [LETableViewCellLabeledSwitch getHeightForTableView:tableView];
					break;
				case MAIL_FILTERS_ROW_ATTACK_MESSAGES:
					return [LETableViewCellLabeledSwitch getHeightForTableView:tableView];
					break;
				case MAIL_FILTERS_ROW_SKIP_EXCAVATOR_REPLACE_MSG:
					return [LETableViewCellLabeledSwitch getHeightForTableView:tableView];
					break;
				default:
					return 0.0;
					break;
			}
			break;
		case SECTION_SERVER_SETTINGS:
			switch (indexPath.row) {
				case SERVER_SETTINGS_ROW_DO_NOT_REPLACE_EXCAVATOR_AUTOMATICALLY:
					return [LETableViewCellLabeledSwitch getHeightForTableView:tableView];
					break;
				default:
					return 0.0;
					break;
			}
        default:
            return 0.0;
            break;
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = nil;
	
	switch (indexPath.section) {
		case SECTION_MAIL_FILTERS:
			switch (indexPath.row) {
				case MAIL_FILTERS_ROW_HAPPINESS:
					cell = self.skipHappinessWarningsCell;
					break;
				case MAIL_FILTERS_ROW_RESOURCE:
					cell = self.skipResourceWarningsCell;
					break;
				case MAIL_FILTERS_ROW_POLLUTION:
					cell = self.skipPollutionWarningsCell;
					break;
				case MAIL_FILTERS_ROW_MEDAL:
					cell = self.skipMedalMessagesCell;
					break;
				case MAIL_FILTERS_ROW_FACEBOOK_WALL_POSTS:
					cell = self.skipFacebookWallPostsCell;
					break;
				case MAIL_FILTERS_ROW_FOUND_NOTHING:
					cell = self.skipFoundNothingCell;
					break;
				case MAIL_FILTERS_ROW_EXCAVATOR_RESOURCES:
					cell = self.skipExcavatorResourcesCell;
					break;
				case MAIL_FILTERS_ROW_EXCAVATOR_GLYPH:
					cell = self.skipExcavatorGlyphCell;
					break;
				case MAIL_FILTERS_ROW_EXCAVATOR_PLAN:
					cell = self.skipExcavatorPlanCell;
					break;
				case MAIL_FILTERS_ROW_SPY_RECOVERY:
					cell = self.skipSpyRecoveryCell;
					break;
				case MAIL_FILTERS_ROW_PROBE_DETECTED:
					cell = self.skipProbeDetectedCell;
					break;
				case MAIL_FILTERS_ROW_ATTACK_MESSAGES:
					cell = skipAttackMessagesCell;
					break;
				case MAIL_FILTERS_ROW_SKIP_EXCAVATOR_REPLACE_MSG:
					cell = skipExcavatorReplaceMsg;
					break;
			}
		case SECTION_SERVER_SETTINGS:
			switch (indexPath.row) {
				case SERVER_SETTINGS_ROW_DO_NOT_REPLACE_EXCAVATOR_AUTOMATICALLY:
					cell = self.dontReplaceExcavator;
					break;
			}
		default:
			break;
	}
    
    return cell;
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
	self.skipHappinessWarningsCell = nil;
	self.skipResourceWarningsCell = nil;
	self.skipPollutionWarningsCell = nil;
	self.skipMedalMessagesCell = nil;
	self.skipFacebookWallPostsCell = nil;
	self.skipFoundNothingCell = nil;
	self.skipExcavatorResourcesCell = nil;
	self.skipExcavatorGlyphCell = nil;
	self.skipExcavatorPlanCell = nil;
	self.skipSpyRecoveryCell = nil;
	self.skipProbeDetectedCell = nil;
    self.skipAttackMessagesCell = nil;
    self.skipExcavatorReplaceMsg = nil;
    self.dontReplaceExcavator = nil;
	self.empireProfile = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark LETableViewCellLabeledSwitchDelegate Methods

- (void)cell:(LETableViewCellLabeledSwitch *)cell switchedTo:(BOOL)isOn {
	NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
	NSString *filterName = nil;

	switch (indexPath.section) {
		case SECTION_MAIL_FILTERS:
			switch (indexPath.row) {
				case MAIL_FILTERS_ROW_HAPPINESS:
					filterName = @"skip_happiness_warnings";
					break;
				case MAIL_FILTERS_ROW_RESOURCE:
					filterName = @"skip_resource_warnings";
					break;
				case MAIL_FILTERS_ROW_POLLUTION:
					filterName = @"skip_pollution_warnings";
					break;
				case MAIL_FILTERS_ROW_MEDAL:
					filterName = @"skip_medal_messages";
					break;
				case MAIL_FILTERS_ROW_FACEBOOK_WALL_POSTS:
					filterName = @"skip_facebook_wall_posts";
					break;
				case MAIL_FILTERS_ROW_FOUND_NOTHING:
					filterName = @"skip_found_nothing";
					break;
				case MAIL_FILTERS_ROW_EXCAVATOR_RESOURCES:
					filterName = @"skip_excavator_resources";
					break;
				case MAIL_FILTERS_ROW_EXCAVATOR_GLYPH:
					filterName = @"skip_excavator_glyph";
					break;
				case MAIL_FILTERS_ROW_EXCAVATOR_PLAN:
					filterName = @"skip_excavator_plan";
					break;
				case MAIL_FILTERS_ROW_SPY_RECOVERY:
					filterName = @"skip_spy_recovery";
					break;
				case MAIL_FILTERS_ROW_PROBE_DETECTED:
					filterName = @"skip_probe_detected";
					break;
				case MAIL_FILTERS_ROW_ATTACK_MESSAGES:
					filterName = @"skip_attack_messages";
					break;
				case MAIL_FILTERS_ROW_SKIP_EXCAVATOR_REPLACE_MSG:
					filterName = @"skip_excavator_replace_msg";
					break;
			}
		case SECTION_SERVER_SETTINGS:
			switch (indexPath.row) {
				case SERVER_SETTINGS_ROW_DO_NOT_REPLACE_EXCAVATOR_AUTOMATICALLY:
					filterName = @"dont_replace_excavator";
			}
		default:
			break;
	}

	NSString *text = nil;
	if (isOn) {
		text = @"0";
	} else {
		text = @"1";
	}

	[[[LEEmpireEditProfile alloc] initWithCallback:@selector(filtersUpdated:) target:self textKey:filterName text:text] autorelease];
}


#pragma mark -
#pragma mark Callback Methods

- (id)filtersUpdated:(LEEmpireEditProfile *)request {
	return nil;
}

#pragma mark -
#pragma mark Class Methods

+ (ViewEmpireMailSettingController *)create {
	return [[[ViewEmpireMailSettingController alloc] init] autorelease];
}


@end

