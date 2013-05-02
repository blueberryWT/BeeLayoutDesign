//
// Created by apple on 13-4-27.
// Copyright (c) 2013 apple. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DesignParentContainerModel.h"


@interface DesignContainerModel : DesignParentContainerModel



//-------------------------------------------------------------------------------
//  作为一个容器布局,在frame方面,只需要指定宽度或者高度即可 x,y没有意义
//-------------------------------------------------------------------------------
@property(nonatomic) CGFloat layoutWidth;
@property(nonatomic) CGFloat layoutHeight;

//-------------------------------------------------------------------------------
// 布局的方向布局相关属性
//-------------------------------------------------------------------------------
@property(nonatomic, copy) NSString *orientation;


//-------------------------------------------------------------------------------
// 自动布局属性
//-------------------------------------------------------------------------------
@property(nonatomic) BOOL autoResizeHeight;
@property(nonatomic) BOOL autoResizeWidth;

@end