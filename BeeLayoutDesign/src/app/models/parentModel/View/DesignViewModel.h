//
// Created by apple on 13-4-27.
// Copyright (c) 2013 apple. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DesignParentViewModel.h"

@class DesignStyleModel;


@interface DesignViewModel : DesignParentViewModel

//-------------------------------------------------------------------------------
// properties
//-------------------------------------------------------------------------------
@property(nonatomic, copy) NSString *style;
@property(nonatomic, copy) NSString *modelId;
@property(nonatomic, copy) NSString *clazz;

//-------------------------------------------------------------------------------
// init function
//-------------------------------------------------------------------------------
@end