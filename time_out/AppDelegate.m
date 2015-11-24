//
//  AppDelegate.m
//  time_out
//
//  Created by alex on 11/18/15.
//  Copyright © 2015 alex. All rights reserved.
//

#import "AppDelegate.h"

#import <objc/runtime.h>
#import <ServiceManagement/ServiceManagement.h>

#define TIME_INTERVAL_SINCE_NOW 3600
#define TIME_INTERVAL           3600

@interface AppDelegate ()

@property (atomic) BOOL launchedByHelper;

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
    
    
    // http://stackoverflow.com/questions/620841/how-to-hide-the-dock-icon
    [NSApp setActivationPolicy: NSApplicationActivationPolicyAccessory];
    
    
    // register url listener
    [[NSAppleEventManager sharedAppleEventManager] setEventHandler:self
                                                       andSelector:@selector(getUrl:withReplyEvent:)
                                                     forEventClass:kInternetEventClass
                                                        andEventID:kAEGetURL];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSLog(@"applicationDidFinishLaunching");
    
    if (![self isLoginItemAlreadyEnabled:kATLoginItemHelperBundleID]) {
        [self retryEnableLoginItem:1];
    }
    
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
    
    
    if (self.launchedByHelper) {
        self.launchedByHelper = NO;
    }
    else{
        
    }
    

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


- (void)retryEnableLoginItem:(unsigned int)sleepSeconds
{
    static int times = 3;
    while (0 < times--) {
        
        sleep(sleepSeconds);
        
        if (!SMLoginItemSetEnabled((CFStringRef)kATLoginItemHelperBundleID, YES)) {
            NSLog(@"Fail to enable memory clean auto login: %d times", 3-times);
            [self retryEnableLoginItem:sleepSeconds*2];
        }
        break;
    }
    
}


- (BOOL)isLoginItemAlreadyEnabled:(NSString *)loginItemBundleID
{
    BOOL launch = NO;
    CFArrayRef cfJobs = SMCopyAllJobDictionaries(kSMDomainUserLaunchd);
    NSArray *jobs = [NSArray arrayWithArray:(__bridge NSArray *)cfJobs];
    
    CFRelease(cfJobs);
    if([jobs count]){
        for(NSDictionary *job in jobs){
            if([job[@"Label"] isEqualToString:loginItemBundleID]){
                launch = [job[@"OnDemand"] boolValue];
                break;
            }
        }
    }
    return launch;
}

- (void)getUrl:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent
{
    NSLog(@"==> %s", __FUNCTION__);
    
    NSURL *url = [NSURL URLWithString:[[event paramDescriptorForKeyword:keyDirectObject] stringValue]];
    NSLog(@"Got URL: %@", url);
    
    NSString *host = [url host];
    NSString *path = [url path];
    if ([host isEqualToString:@"launch"] && [path isEqualToString:@"/helper"]) {
        self.launchedByHelper = YES;
    }
}

@end
