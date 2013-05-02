//
// Created by apple on 13-4-27.
// Copyright (c) 2013 apple. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DesignStyleModel.h"


@interface DesignStyleModel(private)

-(void) initWithSelfModel;

@end



@implementation DesignStyleModel



//-------------------------------------------------------------------------------
// 私有方法
//-------------------------------------------------------------------------------
-(void) initWithSelfModel {
    if (nil == _styleProperties) {
        _styleProperties = [[NSMutableDictionary alloc] init];
    }
}



//-------------------------------------------------------------------------------
// 初始化
//-------------------------------------------------------------------------------
- (id)initWithStyleId:(NSString *)styleId {
    self = [super init];
    if (self) {
        self.styleId = styleId;
        [self initWithSelfModel];
    }

    return self;
}

- (id)initWithStyleId:(NSString *)styleId styleProperties:(NSMutableDictionary *)styleProperties {
    self = [super init];
    if (self) {
        self.styleId = styleId;
        self.styleProperties = styleProperties;
        [self initWithSelfModel];
    }

    return self;
}

+ (id)modelWithStyleId:(NSString *)styleId styleProperties:(NSMutableDictionary *)styleProperties {
    return [[[self alloc] initWithStyleId:styleId styleProperties:styleProperties] autorelease];
}


+ (id)modelWithStyleId:(NSString *)styleId {
    return [[[self alloc] initWithStyleId:styleId] autorelease];
}



//-------------------------------------------------------------------------------
//  dealloc
//-------------------------------------------------------------------------------
- (void)dealloc {
    [_styleId release], _styleId = nil;
    [_styleProperties release], _styleProperties = nil;
    [super dealloc];
}
@end