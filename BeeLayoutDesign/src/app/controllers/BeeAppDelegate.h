//
//  BeeAppDelegate.h
//  BeeLayoutDesign
//
//  Created by apple on 13-5-2.
//  Copyright (c) 2013年 Bee. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "DMTabBar.h"
@interface BeeAppDelegate : NSObject <NSApplicationDelegate,NSSplitViewDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet DMTabBar *firstTabBar;
@property (assign) IBOutlet NSSplitView *firstSplitView;


@end
