//
//  LEBuildingDowngrade.m
//  UniversalClient
//
//  Created by Kevin Runde on 8/28/10.
//  Copyright 2010 n/a. All rights reserved.
//

#import "LEBuildingDowngrade.h"
#import "LEMacros.h"
#import "Session.h"




@implementation LEBuildingDowngrade


@synthesize buildingId;
@synthesize buildingUrl;
@synthesize result;


- (LERequest *)initWithCallback:(SEL)inCallback target:(NSObject *)inTarget buildingId:(NSString *)inBuildingId buildingUrl:(NSString *)inBuildingUrl {
	self.buildingId = inBuildingId;
	self.buildingUrl = inBuildingUrl;
	return [self initWithCallback:inCallback target:(NSObject *)inTarget];
}


- (id)params {
	return _array([Session sharedInstance].sessionId, self.buildingId);
}


- (void)processSuccess {
	self.result = [self.response objectForKey:@"result"];
}


- (NSString *)serviceUrl {
	return self.buildingUrl;
}


- (NSString *)methodName {
	return @"downgrade";
}


- (void)dealloc {
	self.buildingId = nil;
	self.buildingUrl = nil;
	self.result = nil;
	[super dealloc];
}


@end
