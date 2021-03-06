//
//  LECheckEmpireName.h
//  DKTest
//
//  Created by Kevin Runde on 2/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LERequest.h"


@interface LECheckEmpireName : LERequest {
	NSString *name;
}


@property(nonatomic, retain) NSString *name;


- (LERequest *)initWithCallback:(SEL)callback target:(NSObject *)target name:(NSString *)name;
- (BOOL)nameIsAvailable;


@end
