//
//  NewSpeciesController.h
//  UniversalClient
//
//  Created by Kevin Runde on 4/11/10.
//  Copyright 2010 n/a. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LETableViewControllerGrouped.h"
#import "LETableViewCellTextEntry.h"
#import "LETableViewCellAffinitySelectorV2.h"
#import "LETableViewCellOrbitSelectorV2.h"
#import "LESpeciesPointsUpdateDelegate.h"
#import "LETableViewCellLabeledTextView.h"


@interface NewSpeciesController : LETableViewControllerGrouped <UITextFieldDelegate, LESpeciesPointsUpdateDelegate> {
	NSInteger points;
}


@property(nonatomic, retain) NSString *empireId;
@property(nonatomic, retain) NSString *username;
@property(nonatomic, retain) NSString *password;
@property(nonatomic, retain) LETableViewCellTextEntry *speciesNameCell;
@property(nonatomic, retain) LETableViewCellLabeledTextView *speciesDescriptionCell;
@property(nonatomic, retain) LETableViewCellOrbitSelectorV2 *minOrbitCell;
@property(nonatomic, retain) LETableViewCellOrbitSelectorV2 *maxOrbitCell;
@property(nonatomic, retain) LETableViewCellAffinitySelectorV2 *manufacturingCell;
@property(nonatomic, retain) LETableViewCellAffinitySelectorV2 *deceptionCell;
@property(nonatomic, retain) LETableViewCellAffinitySelectorV2 *researchCell;
@property(nonatomic, retain) LETableViewCellAffinitySelectorV2 *managementCell;
@property(nonatomic, retain) LETableViewCellAffinitySelectorV2 *farmingCell;
@property(nonatomic, retain) LETableViewCellAffinitySelectorV2 *miningCell;
@property(nonatomic, retain) LETableViewCellAffinitySelectorV2 *scienceCell;
@property(nonatomic, retain) LETableViewCellAffinitySelectorV2 *environmentalCell;
@property(nonatomic, retain) LETableViewCellAffinitySelectorV2 *politicalCell;
@property(nonatomic, retain) LETableViewCellAffinitySelectorV2 *tradeCell;
@property(nonatomic, retain) LETableViewCellAffinitySelectorV2 *growthCell;
@property(nonatomic, retain) NSMutableDictionary *speciesTemplate;


- (IBAction)cancel;
- (IBAction)createSpecies;


+ (NewSpeciesController *) create;


@end
