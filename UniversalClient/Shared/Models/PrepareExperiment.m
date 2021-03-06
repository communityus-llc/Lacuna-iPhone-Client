//
//  PrepareExeriment.m
//  UniversalClient
//
//  Created by Kevin Runde on 12/30/10.
//  Copyright 2010 n/a. All rights reserved.
//

#import "PrepareExperiment.h"
#import "LEMacros.h"
#import "Util.h"


@implementation PrepareExperiment


@synthesize grafts;
@synthesize survivalOdds;
@synthesize graftOdds;
@synthesize essentiaCost;
@synthesize canExperiment;


#pragma mark -
#pragma mark Object Methods

- (void)dealloc {
	self.grafts = nil;
	self.survivalOdds = nil;
	self.graftOdds = nil;
	self.essentiaCost = nil;
	[super dealloc];
}


- (NSString *)description {
	return [NSString stringWithFormat:@"survivalOdds:%@, graftOdds:%@, essentiaCost:%@, grafts:%@",
			self.survivalOdds, self.graftOdds, self.essentiaCost, self.grafts];
}


#pragma mark -
#pragma mark Instance Methods

- (void)parseData:(NSMutableDictionary *)data {
	self.grafts = [data objectForKey:@"grafts"];
	self.survivalOdds = [Util asNumber:[data objectForKey:@"survival_odds"]];
	self.graftOdds = [Util asNumber:[data objectForKey:@"graft_odds"]];
	self.essentiaCost = [Util asNumber:[data objectForKey:@"essentia_cost"]];
	NSObject *tmp = [data objectForKey:@"can_experiment"];
	if (isNotNull(tmp)) {
		self.canExperiment = [[data objectForKey:@"can_experiment"] boolValue];
		if (!self.canExperiment) {
			NSLog(@"NO LONGER NEED MANUAL FOX FOR SERVER can_experiment BUG");
		}
	} else {
		NSLog(@"HAD TO DO MANUAL FIX FOR SERVER can_experiment BUG");
		self.canExperiment = NO;
	}

}
	

@end
