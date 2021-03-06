//
//  ProposeEvictMiningPlatformViewController.h
//  UniversalClient
//
//  Created by Kevin Runde on 4/13/11.
//  Copyright 2011 n/a. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LETableViewControllerGrouped.h"
#import "SelectStarInJurisdictionViewController.h"
#import "SelectBodyForStarInJurisdictionViewController.h"
#import "SelectMiningPlatformForBodyInJurisdictionViewController.h"


@class Parliament;


@interface ProposeEvictMiningPlatformViewController : LETableViewControllerGrouped <SelectStarInJurisdictionViewControllerDelegate, SelectBodyForStarInJurisdictionViewControllerDelegate, SelectMiningPlatformForBodyInJurisdictionViewControllerDelegate> {
}


@property (nonatomic, retain) Parliament *parliament;
@property (nonatomic, retain) NSDictionary *selectedStar;
@property (nonatomic, retain) NSDictionary *selectedAsteroid;
@property (nonatomic, retain) NSDictionary *selectedMiningPlatform;


- (IBAction)propose;


+ (ProposeEvictMiningPlatformViewController *)create;


@end
