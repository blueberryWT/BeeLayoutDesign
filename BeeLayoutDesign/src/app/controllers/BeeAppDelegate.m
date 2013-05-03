//
//  BeeAppDelegate.m
//  BeeLayoutDesign
//
//  Created by apple on 13-5-2.
//  Copyright (c) 2013年 Bee. All rights reserved.
//

#import "BeeAppDelegate.h"
#import "DMTabBar.h"
#import "SourceListItem.h"


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
    
    
    ///
    sourceListItems = [[NSMutableArray alloc] init];
    SourceListItem *libraryItem = [SourceListItem itemWithTitle:@"LIBRARY" identifier:@"library"];
	SourceListItem *musicItem = [SourceListItem itemWithTitle:@"Music" identifier:@"music"];
	[musicItem setIcon:[NSImage imageNamed:@"music.png"]];
	SourceListItem *moviesItem = [SourceListItem itemWithTitle:@"Movies" identifier:@"movies"];
	[moviesItem setIcon:[NSImage imageNamed:@"movies.png"]];
	SourceListItem *podcastsItem = [SourceListItem itemWithTitle:@"Podcasts" identifier:@"podcasts"];
	[podcastsItem setIcon:[NSImage imageNamed:@"podcasts.png"]];
	[podcastsItem setBadgeValue:10];
	SourceListItem *audiobooksItem = [SourceListItem itemWithTitle:@"Audiobooks" identifier:@"audiobooks"];
	[audiobooksItem setIcon:[NSImage imageNamed:@"audiobooks.png"]];
	[libraryItem setChildren:[NSArray arrayWithObjects:musicItem, moviesItem, podcastsItem,
							  audiobooksItem, nil]];
    
    [sourceListItems addObject:libraryItem];
    [self.pxoutLineSource setDelegate:self];
    [self.pxoutLineSource setDataSource:self];
    
}

#pragma mark -
#pragma mark Source List Data Source Methods

- (NSUInteger)sourceList:(PXSourceList*)sourceList numberOfChildrenOfItem:(id)item
{
	//Works the same way as the NSOutlineView data source: `nil` means a parent item
	if(item==nil) {
		return [sourceListItems count];
	}
	else {
		return [[item children] count];
	}
}


- (id)sourceList:(PXSourceList*)aSourceList child:(NSUInteger)index ofItem:(id)item
{
	//Works the same way as the NSOutlineView data source: `nil` means a parent item
	if(item==nil) {
		return [sourceListItems objectAtIndex:index];
	}
	else {
		return [[item children] objectAtIndex:index];
	}
}


- (id)sourceList:(PXSourceList*)aSourceList objectValueForItem:(id)item
{
	return [item title];
}


- (void)sourceList:(PXSourceList*)aSourceList setObjectValue:(id)object forItem:(id)item
{
	[item setTitle:object];
}


- (BOOL)sourceList:(PXSourceList*)aSourceList isItemExpandable:(id)item
{
	return [item hasChildren];
}


- (BOOL)sourceList:(PXSourceList*)aSourceList itemHasBadge:(id)item
{
	return [item hasBadge];
}


- (NSInteger)sourceList:(PXSourceList*)aSourceList badgeValueForItem:(id)item
{
	return [item badgeValue];
}


- (BOOL)sourceList:(PXSourceList*)aSourceList itemHasIcon:(id)item
{
	return [item hasIcon];
}


- (NSImage*)sourceList:(PXSourceList*)aSourceList iconForItem:(id)item
{
	return [item icon];
}

- (NSMenu*)sourceList:(PXSourceList*)aSourceList menuForEvent:(NSEvent*)theEvent item:(id)item
{
	if ([theEvent type] == NSRightMouseDown || ([theEvent type] == NSLeftMouseDown && ([theEvent modifierFlags] & NSControlKeyMask) == NSControlKeyMask)) {
		NSMenu * m = [[NSMenu alloc] init];
		if (item != nil) {
			[m addItemWithTitle:[item title] action:nil keyEquivalent:@""];
		} else {
			[m addItemWithTitle:@"clicked outside" action:nil keyEquivalent:@""];
		}
		return [m autorelease];
	}
	return nil;
}

#pragma mark -
#pragma mark Source List Delegate Methods

- (BOOL)sourceList:(PXSourceList*)aSourceList isGroupAlwaysExpanded:(id)group
{
	if([[group identifier] isEqualToString:@"library"])
		return YES;
	
	return NO;
}


- (void)sourceListSelectionDidChange:(NSNotification *)notification
{
//	NSIndexSet *selectedIndexes = [self.pxoutLineSource selectedRowIndexes];
	
	//Set the label text to represent the new selection
//	if([selectedIndexes count]>1)
//		[selectedItemLabel setStringValue:@"(multiple)"];
//	else if([selectedIndexes count]==1) {
//		NSString *identifier = [[self.pxoutLineSource itemAtRow:[selectedIndexes firstIndex]] identifier];
//		
//		[selectedItemLabel setStringValue:identifier];
//	}
//	else {
//		[selectedItemLabel setStringValue:@"(none)"];
//	}
}


- (void)sourceListDeleteKeyPressedOnRows:(NSNotification *)notification
{
	NSIndexSet *rows = [[notification userInfo] objectForKey:@"rows"];
	
	NSLog(@"Delete key pressed on rows %@", rows);
	
	//Do something here
}









@end
