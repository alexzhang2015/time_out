//
//  AppDelegate.m
//  time_out
//
//  Created by alex on 11/18/15.
//  Copyright © 2015 alex. All rights reserved.
//

#import "AppDelegate.h"

#import <objc/runtime.h>

#define TIME_INTERVAL_SINCE_NOW 3600
#define TIME_INTERVAL           3600

@interface AppDelegate ()


@end

@implementation AppDelegate

@synthesize menuBarController;


- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
    if (![NSVisualEffectView class]) {
        Class NSVisualEffectViewClass = objc_allocateClassPair([NSView class], "NSVisualEffectView", 0);
        objc_registerClassPair(NSVisualEffectViewClass);
    }
    
    self.menuBarController = [[MenuBarController alloc] init];
    
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:TIME_INTERVAL_SINCE_NOW];
    
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:fireDate
                                              interval:TIME_INTERVAL
                                                target:self
                                              selector:@selector(sendUserNotification:)
                                              userInfo:[self userInfo]
                                               repeats:YES];
    
    self.repeatingTimer = timer;
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)presentNotification
{
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"Easy Eyes!";
    notification.informativeText = @"have a break for 5 minutes ^-^";
    notification.soundName = NSUserNotificationDefaultSoundName;
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification{
    return YES;
}

// send notification
- (void)sendUserNotification:(NSTimer*)theTimer
{
    NSDate *startDate = [[theTimer userInfo] objectForKey:@"StartDate"];
    NSLog(@"Timer started on %@", startDate);
    [self presentNotification];
}

- (NSDictionary *)userInfo
{
    return @{ @"StartDate" : [NSDate date] };
}


- (IBAction)ok:(id)sender
{
    NSLog(@"ok");
    [self presentNotification];
    
}


@end
