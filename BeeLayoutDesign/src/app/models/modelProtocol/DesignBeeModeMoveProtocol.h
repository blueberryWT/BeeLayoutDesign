//
// Created by apple on 13-4-27.
// Copyright (c) 2013 apple. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol DesignBeeModeMoveProtocol <NSObject>

//-------------------------------------------------------------------------------
//  在x方向移动位置,stepValue是移动的步长,如果是负数,则向反方向移动
//-------------------------------------------------------------------------------
-(void) moveToLeft:(CGFloat) stepValue;

//-------------------------------------------------------------------------------
//  在y轴方向移动位置,stepValue同理
//-------------------------------------------------------------------------------
-(void) moveToTop:(CGFloat) stepValue;

@end