//
//  StatusItemView.m
//  time_out
//
//  Created by alex on 11/18/15.
//  Copyright © 2015 alex. All rights reserved.
//

#import "StatusItemView.h"

@implementation StatusItemView
@synthesize statusItem;
@synthesize imageDefault;
@synthesize action;

- (id)initWithStatusItem:(NSStatusItem *)statusItemParam {
    CGFloat itemWidth = [statusItem length];
    CGFloat itemHeight = [[NSStatusBar systemStatusBar] thickness];
    NSRect itemRect = NSMakeRect(0.0, 0.0, itemWidth, itemHeight);
    self = [super initWithFrame:itemRect];
    
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
//    [NSApp sendAction:self.action to:self.target from:self];
    NSLog(@"mouseDown");
}


@end
