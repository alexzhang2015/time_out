//
//  StatusItemView.h
//  time_out
//
//  Created by alex on 11/18/15.
//  Copyright © 2015 alex. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class INPopoverController;
@interface StatusItemView : NSView{
@private
    NSWindow *__weak window;
    INPopoverController *popoverController;
}

@property (nonatomic, retain) NSStatusItem *statusItem;
@property (nonatomic, retain) NSImage *imageDefault;

@property (nonatomic, unsafe_unretained) id target;
@property (nonatomic) SEL action;

@property (nonatomic, strong) INPopoverController *popoverController;

- (id)initWithStatusItem:(NSStatusItem *)statusItemParam;

@end
