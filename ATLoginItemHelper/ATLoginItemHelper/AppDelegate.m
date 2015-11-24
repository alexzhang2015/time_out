//
//  AppDelegate.m
//
//  Created by alex on 11/25/15.
//  Copyright © 2015 alex. All rights reserved.
//

#import "AppDelegate.h"
#include <pwd.h>
#include <assert.h>
#include "TMBundleID.h"


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self launchMainApp];
    [NSApp terminate:self];
}

- (void)launchMainApp
{
    if (![self isMainAppRunning] && ![self isInTrashDir]) {
        [[NSWorkspace sharedWorkspace] openURL:[[NSURL alloc] initWithScheme:kTimeOutBundleID
                                                                        host:@"launch"
                                                                        path:@"/helper"]];
    }
}

- (BOOL)isMainAppRunning
{
    NSLog(@"%@", kTimeOutBundleID);
    NSArray * runningApp = [NSRunningApplication runningApplicationsWithBundleIdentifier:kTimeOutBundleID];
    if (0 < [runningApp count]) {
        return YES;
    }
    return NO;
}

- (BOOL)isInTrashDir
{
    struct passwd *pw = getpwuid(getuid());
    assert(pw);

    NSString *userHome = [NSString stringWithUTF8String:pw->pw_dir];

    return [[[NSBundle mainBundle] bundlePath] hasPrefix:[userHome stringByAppendingPathComponent:@".Trash"]];
}

@end
