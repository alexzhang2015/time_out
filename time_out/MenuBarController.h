//
//  MenuBarController.h
//  time_out
//
//  Created by alex on 11/18/15.
//  Copyright © 2015 alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusItemView.h"
//#import "TodoListWindowController.h"

@interface MenuBarController : NSObject

@property (nonatomic, retain) StatusItemView* statusItemView;
//@property (nonatomic, retain) TodoListWindowController* todoListWindowController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readwrite) BOOL isOpen;

@end
