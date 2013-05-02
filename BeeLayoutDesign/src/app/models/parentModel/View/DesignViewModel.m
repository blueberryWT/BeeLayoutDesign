//
// Created by apple on 13-4-27.
// Copyright (c) 2013 apple. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DesignViewModel.h"


@interface DesignViewModel(private)
-(void) initViewModelData;
@end

@implementation DesignViewModel


- (void)initViewModelData {
    self.clazz = @"";
    self.modelId = @"";
    self.style = nil;
}

-(id)initWithParentModel:(id)parentModel {
    self = [super initWithParentModel:parentModel];
    if (self) {
        [self initViewModelData];
    }
    return self;
}

- (void)dealloc {
    [_style release], _style = nil;
    [_modelId release], _modelId = nil;
    [_clazz release], _clazz = nil;
    [super dealloc];
}

@end