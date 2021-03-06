//
//  AppDelegate.h
//  time_out
//
//  Created by alex on 11/18/15.
//  Copyright © 2015 alex. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include "MenuBarController.h"

#define kATLoginItemHelperBundleID              @"com.alex.ATLoginItemHelper"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSUserNotificationCenterDelegate>

// The repeating timer is a weak property.
@property (weak) NSTimer *repeatingTimer;

@property (nonatomic, strong) MenuBarController *menuBarController;

- (IBAction)ok:(id)sender;

- (void)sendUserNotification:(NSTimer*)theTimer;

@end

