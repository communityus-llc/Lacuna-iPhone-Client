//
//  RejectAllianceInviteController.h
//  UniversalClient
//
//  Created by Kevin Runde on 8/27/10.
//  Copyright 2010 n/a. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LETableViewControllerGrouped.h"

@class Embassy;
@class LETableViewCellTextView;
@class MyAllianceInvite;


@interface RejectAllianceInviteController : LETableViewControllerGrouped <UIActionSheetDelegate> {
	Embassy *embassy;
	LETableViewCellTextView *messageCell;
	MyAllianceInvite *invite;
}


@property (nonatomic, retain) Embassy *embassy;
@property (nonatomic, retain) LETableViewCellTextView *messageCell;
@property (nonatomic, retain) MyAllianceInvite *invite;


- (IBAction)rejectInvite;


+ (RejectAllianceInviteController *)create;


@end
