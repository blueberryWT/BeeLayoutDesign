//
// Created by apple on 13-4-27.
// Copyright (c) 2013 apple. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#undef	AS_STATIC_PROPERTY_STRING
#define AS_STATIC_PROPERTY_STRING( __name ) \
		@property (nonatomic, readonly) NSString * __name; \
		+ (NSString *)__name;

#undef	DEF_STATIC_PROPERTY_STRING
#define DEF_STATIC_PROPERTY_STRING( __name, __value ) \
		@dynamic __name; \
		- (NSString *)__name \
		{ \
			return [[self class] __name]; \
		} \
		+ (NSString *)__name \
		{ \
			return __value; \
		}

#undef	AS_STRING
#define AS_STRING	AS_STATIC_PROPERTY_STRING

#undef	DEF_STRING
#define DEF_STRING	DEF_STATIC_PROPERTY_STRING

@interface DesignNodeConstants : NSObject

AS_STRING(NODE_CLASS)

AS_STRING(NODE_ID)

AS_STRING(NODE_LAYOUT)

AS_STRING(NODE_CONTAINER)

AS_STRING(NODE_ORIENTATION)

AS_STRING(NODE_AUTORESIZE_HEIGHT)

AS_STRING(NODE_X)

AS_STRING(NODE_Y)

AS_STRING(NODE_H)

AS_STRING(NODE_W)

AS_STRING(NODE_STYLE)

AS_STRING(NODE_VIEW)

AS_STRING(NODE_SPACE)

AS_STRING(NODE_UI)

@end