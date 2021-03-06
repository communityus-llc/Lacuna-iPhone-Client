//
//  LEUpgradeBuilding.m
//  DKTest
//
//  Created by Kevin Runde on 3/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LEBuildingUpgrade.h"
#import "Session.h"
#import "LEMacros.h"


@implementation LEBuildingUpgrade


@synthesize buildingId;
@synthesize buildingUrl;
@synthesize buildingData;


- (LERequest *)initWithCallback:(SEL)inCallback target:(NSObject *)inTarget buildingId:(NSString *)inBuildingId buildingUrl:(NSString *)inBuildingUrl {
	self.buildingId = inBuildingId;
	self.buildingUrl = inBuildingUrl;
	return [self initWithCallback:inCallback target:(NSObject *)inTarget];
}


- (id)params {
	return _array([Session sharedInstance].sessionId, self.buildingId);
}


- (void)processSuccess {
	self.buildingData = [[self.response objectForKey:@"result"] objectForKey:@"building"];
}


- (NSString *)serviceUrl {
	return self.buildingUrl;
}


- (NSString *)methodName {
	return @"upgrade";
}


- (void)dealloc {
	self.buildingId = nil;
	self.buildingUrl = nil;
	self.buildingData = nil;
	[super dealloc];
}


@end
