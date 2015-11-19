//
//  StatusItemView.h
//  time_out
//
//  Created by alex on 11/18/15.
//  Copyright © 2015 alex. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StatusItemView : NSView

@property (nonatomic, retain) NSStatusItem *statusItem;
@property (nonatomic, retain) NSImage *imageDefault;

@property (nonatomic, unsafe_unretained) id target;
@property (nonatomic) SEL action;

- (id)initWithStatusItem:(NSStatusItem *)statusItemParam;

@end
