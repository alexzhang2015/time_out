//
//  MenuBarController.m
//  time_out
//
//  Created by alex on 11/18/15.
//  Copyright © 2015 alex. All rights reserved.
//

#import "MenuBarController.h"

#define STATUS_ITEM_VIEW_WIDTH 24.0

@implementation MenuBarController
@synthesize statusItemView;
//@synthesize todoListWindowController;
@synthesize managedObjectContext;
@synthesize isOpen;

- (id)init
{
    self = [super init];
    if (self) {
        
        NSStatusItem *statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:STATUS_ITEM_VIEW_WIDTH];
        statusItemView = [[StatusItemView alloc] initWithStatusItem:statusItem];
        [statusItemView setImageDefault:[NSImage imageNamed:@"Icon"]];
        
        statusItemView.action = @selector(openTodoListPanel:);
        statusItemView.target = self;
        
        isOpen = NO;
    }
    return self;
}

- (void) openTodoListPanel:(id) sender {
    //if the panel is already open, we should close it
    if(isOpen) {
//        todoListWindowController = nil;
        isOpen = NO;
        return;
    }
    
    isOpen = YES;
    
    [NSApp activateIgnoringOtherApps:YES];
}

@end
