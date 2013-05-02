//
//  BeeAppDelegate.m
//  BeeLayoutDesign
//
//  Created by apple on 13-5-2.
//  Copyright (c) 2013年 Bee. All rights reserved.
//

#import "BeeAppDelegate.h"
#import "DMTabBar.h"

#define kTabBarElements     [NSArray arrayWithObjects: \
[NSDictionary dictionaryWithObjectsAndKeys: [NSImage imageNamed:@"tabBarItem1"],@"image",@"Tab #1",@"title",nil], \
[NSDictionary dictionaryWithObjectsAndKeys: [NSImage imageNamed:@"tabBarItem2"],@"image",@"Tab #2",@"title",nil], \
[NSDictionary dictionaryWithObjectsAndKeys: [NSImage imageNamed:@"tabBarItem3"],@"image",@"Tab #3",@"title",nil],  [NSDictionary dictionaryWithObjectsAndKeys: [NSImage imageNamed:@"tabBarItem3"],@"image",@"Tab #3",@"title",nil],      nil]


@implementation BeeAppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    DMTabBar* dmt = self.firstTabBar;
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:2];
    
    // Create an array of DMTabBarItem objects
    [kTabBarElements enumerateObjectsUsingBlock:^(NSDictionary* objDict, NSUInteger idx, BOOL *stop) {
        NSImage *iconImage = [objDict objectForKey:@"image"];
        [iconImage setTemplate:YES];
        
        DMTabBarItem *item1 = [DMTabBarItem tabBarItemWithIcon:iconImage tag:idx];
        item1.toolTip = [objDict objectForKey:@"title"];
        item1.keyEquivalent = [NSString stringWithFormat:@"%ld",(unsigned long)idx];
        item1.keyEquivalentModifierMask = NSCommandKeyMask;
        [items addObject:item1];
    }];
    dmt.tabBarItems = items;
    
    
    [dmt handleTabBarItemSelection:^(DMTabBarItemSelectionType selectionType, DMTabBarItem *targetTabBarItem, NSUInteger targetTabBarItemIndex) {
        if (selectionType == DMTabBarItemSelectionType_WillSelect) {
            //NSLog(@"Will select %lu/%@",targetTabBarItemIndex,targetTabBarItem);
//            [dmt selectTabViewItem:[tabView.tabViewItems objectAtIndex:targetTabBarItemIndex]];
        } else if (selectionType == DMTabBarItemSelectionType_DidSelect) {
            //NSLog(@"Did select %lu/%@",targetTabBarItemIndex,targetTabBarItem);
        }
    }];
    
    [self.firstSplitView setDelegate:self];
    
    [self.firstSplitView setPosition:150 ofDividerAtIndex:0];
}



@end
