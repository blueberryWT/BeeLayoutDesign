//
// Created by apple on 13-4-27.
// Copyright (c) 2013 apple. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DesignParentContainerModel.h"
#import "DesignUIModel.h"


@interface DesignParentContainerModel(private)
-(void) initSelfModel;
@end

@implementation DesignParentContainerModel

- (void)initSelfModel {
    self.parentLayout = nil;
    if (nil == _child) {
        _child = [[NSMutableArray alloc] init];
    }
}

- (id)initWithParentLayout:(id)parentLayout {
    self = [super init];
    if (self) {
        self.parentLayout = parentLayout;
        [self initSelfModel];
        // 在这里限定,parentLayout的节点必须是DesignUIModel类型
        if ([parentLayout isKindOfClass:[DesignParentContainerModel class]]) {
            [((DesignParentContainerModel *) parentLayout).child addObject:self];
        }
    }
    return self;
}

+ (id)modelWithParentLayout:(id)parentLayout {
    return [[[self alloc] initWithParentLayout:parentLayout] autorelease];
}




- (void)dealloc {
    [_child release],_child = nil;
    [_parentLayout release], _parentLayout = nil;
    [super dealloc];
}
@end