//
//  MissionCommand.h
//  UniversalClient
//
//  Created by Kevin Runde on 10/18/10.
//  Copyright 2010 n/a. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Building.h"


@interface MissionCommand : Building {
}


@property (nonatomic, retain) NSMutableArray *missions;


- (void)loadMissions;


@end