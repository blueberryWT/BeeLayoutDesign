//
// Created by apple on 13-4-27.
// Copyright (c) 2013 apple. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DesignBeeModeMoveProtocol.h"


@interface DesignParentViewModel : NSView<DesignBeeModeMoveProtocol>


//-------------------------------------------------------------------------------
//  Frame
//-------------------------------------------------------------------------------
@property(nonatomic) CGFloat frame_x;
@property(nonatomic) CGFloat frame_y;
@property(nonatomic) CGFloat frame_width;
@property(nonatomic) CGFloat frame_height;

//-------------------------------------------------------------------------------
// Other property
//-------------------------------------------------------------------------------
@property(nonatomic) BOOL isLock;
@property(nonatomic) BOOL isMove;
@property(nonatomic) BOOL isVisible;

//-------------------------------------------------------------------------------
// Structural relationship
//-------------------------------------------------------------------------------
@property(nonatomic, retain) id parentModel;
@property(nonatomic, retain) NSMutableArray *child; // 这个参数暂时用不到,因为当前还不支持多级的view


//-------------------------------------------------------------------------------
// Public function
//-------------------------------------------------------------------------------
- (id)initWithParentModel:(id)parentModel;

+ (id)modelWithParentModel:(id)parentModel;


@end