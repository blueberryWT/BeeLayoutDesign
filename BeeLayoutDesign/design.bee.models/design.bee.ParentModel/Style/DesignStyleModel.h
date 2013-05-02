//
// Created by apple on 13-4-27.
// Copyright (c) 2013 apple. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface DesignStyleModel : NSObject

//-------------------------------------------------------------------------------
//  styleId 作为style的唯一标识
//-------------------------------------------------------------------------------
@property(nonatomic, copy) NSString *styleId;

//-------------------------------------------------------------------------------
//  style的属性列表,在xml中,属性是作为一个字段存储的,解析的时候要映射到这个属性列表中
//-------------------------------------------------------------------------------
@property(nonatomic, retain) NSMutableDictionary *styleProperties;



//-------------------------------------------------------------------------------
//  对外公开的初始化方法
//-------------------------------------------------------------------------------
- (id)initWithStyleId:(NSString *)styleId;

+ (id)modelWithStyleId:(NSString *)styleId;


- (id)initWithStyleId:(NSString *)styleId styleProperties:(NSMutableDictionary *)styleProperties;

+ (id)modelWithStyleId:(NSString *)styleId styleProperties:(NSMutableDictionary *)styleProperties;


@end