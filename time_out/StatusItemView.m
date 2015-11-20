//
//  StatusItemView.m
//  time_out
//
//  Created by alex on 11/18/15.
//  Copyright © 2015 alex. All rights reserved.
//

#import "StatusItemView.h"
#import "ContentViewController.h"
#import "INPopoverController.h"

@implementation StatusItemView
@synthesize statusItem;
@synthesize imageDefault;
@synthesize action;
@synthesize popoverController;

- (id)initWithStatusItem:(NSStatusItem *)statusItemParam {
    CGFloat itemWidth = [statusItem length];
    CGFloat itemHeight = [[NSStatusBar systemStatusBar] thickness];
    NSRect itemRect = NSMakeRect(0.0, 0.0, itemWidth, itemHeight);
    self = [super initWithFrame:itemRect];
    
    // load the ContentViewController
    ContentViewController *viewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    self.popoverController = [[INPopoverController alloc] initWithContentViewController:viewController];
    
    if (self) {
        statusItem = statusItemParam;
        statusItem.view = self;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	[self.statusItem drawStatusBarBackgroundInRect:dirtyRect withHighlight:NO];
    
    NSSize iconSize = [imageDefault size];
    NSRect bounds = self.bounds;
    CGFloat iconX = roundf((NSWidth(bounds) - iconSize.width) / 2);
    CGFloat iconY = roundf((NSHeight(bounds) - iconSize.height) / 2);
    NSPoint iconPoint = NSMakePoint(iconX, iconY);
    
	[imageDefault drawAtPoint:iconPoint fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
}

- (void)mouseDown:(NSEvent *)theEvent {
    NSLog(@"mouseDown");
    
    if (self.popoverController.popoverIsVisible) {
        [self.popoverController closePopover:nil];
    } else {
        [self.popoverController presentPopoverFromRect:[self bounds]
                                                inView:self
                               preferredArrowDirection:INPopoverArrowDirectionDown
                                 anchorsToPositionView:YES];
    }
}

- (void)rightMouseDown:(NSEvent *)theEvent {
    NSLog(@"rightMouseDown");
}

@end
