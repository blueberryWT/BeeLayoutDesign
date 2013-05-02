//
// Created by apple on 13-4-27.
// Copyright (c) 2013 apple. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DesignParentViewModel.h"
#import "DesignParentContainerModel.h"


@interface DesignParentViewModel(private)
-(void) initParentViewModelData;
@end

@implementation DesignParentViewModel


- (void)initParentViewModelData {
    self.frame_x = self.frame_y = self.frame_width = self.frame_height = 0;
    self.isLock = NO;
    self.isMove = NO;
    self.isVisible = YES;
    self.parentModel = nil;
    if (nil == _child) {
        _child = [[NSMutableArray alloc] init];
    }
}

//-------------------------------------------------------------------------------
// init
//-------------------------------------------------------------------------------
- (id)initWithParentModel:(id)parentModel {
    self = [super init];
    if (self) {
        [self initParentViewModelData];
        self.parentModel = parentModel;
        if (self.parentModel && [self.parentModel isKindOfClass:[DesignParentContainerModel class]]) {
            [((DesignParentContainerModel *) parentModel).child addObject:self];
        }
    }

    return self;
}

+ (id)modelWithParentModel:(id)parentModel {
    return [[[self alloc] initWithParentModel:parentModel] autorelease];
}




//-------------------------------------------------------------------------------
//  move protocol
//-------------------------------------------------------------------------------
- (void)moveToLeft:(CGFloat)stepValue {
    self.frame_x += stepValue;
}

- (void)moveToTop:(CGFloat)stepValue {
    self.frame_y += stepValue;
}



//-------------------------------------------------------------------------------
//  dealloc
//-------------------------------------------------------------------------------
- (void)dealloc {
    [_parentModel release], _parentModel = nil;
    [_child release] , _child = nil;
    [super dealloc];
}
@end