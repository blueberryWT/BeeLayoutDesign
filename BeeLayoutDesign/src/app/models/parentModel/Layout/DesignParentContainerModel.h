//
// Created by apple on 13-4-27.
// Copyright (c) 2013 apple. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface DesignParentContainerModel : NSObject

//-------------------------------------------------------------------------------
// parent and child
//-------------------------------------------------------------------------------
@property(nonatomic, retain) NSMutableArray *child;
@property(nonatomic, retain) id parentLayout;


//-------------------------------------------------------------------------------
// public function with init
//-------------------------------------------------------------------------------
- (id)initWithParentLayout:(id)parentLayout;

+ (id)modelWithParentLayout:(id)parentLayout;

@end