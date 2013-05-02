//
// Created by apple on 13-4-27.
// Copyright (c) 2013 apple. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DesignParseXMLManager.h"
#import "DesignNodeConstants.h"
#import "DesignLayoutModel.h"
#import "DesignUIModel.h"
#import "DesignContainerModel.h"
#import "DesignViewModel.h"
#import "DesignSpaceModel.h"
#import "DesignStyleModel.h"


static DesignParseXMLManager *_designParseXMLManagerInstance;

@interface DesignParseXMLManager(private)

@end


@implementation DesignParseXMLManager



//-------------------------------------------------------------------------------
// init
//-------------------------------------------------------------------------------

-(id) init {
    self = [super init];
    if (self) {
        if (nil == _tempContainerLayoutList) {
            _tempContainerLayoutList = [[NSMutableArray alloc] init];
        }
    }
    return self;
}


//-------------------------------------------------------------------------------
// 调用这个方法,将需要解析的文件路径传递进来,因为目前都是本地目录,暂时不考虑其他情况
//-------------------------------------------------------------------------------
- (void)parseXMLFileAtURL:(NSString *)URL parseError:(NSError **)error {
    // 对参数进行校验
    if (nil == URL) {
        NSLog(@"parse xml url is null");
        return;
    }
    NSData *data = [NSData dataWithContentsOfFile:URL];
    if (nil == data) {
        NSLog(@"xml data is null");
        return;
    }

    // 创建解析器,并对xml文件进行解析
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    NSError *parseError = [parser parserError];
    if (parseError && error) {
        *error = parseError;
    }
    [parser release];
}



//-------------------------------------------------------------------------------
//  解析到节点开始时调用这个方法
//  ex:<node "id" = "test"/>
//-------------------------------------------------------------------------------
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    // 元素开始句柄
    if (qName) {
        elementName = qName;
    }

    // 根据不同的开始节点,对节点进行不同的解析处理
    if ([elementName isEqualToString:[DesignNodeConstants NODE_STYLE]]) {// node style

        [self parseStartElement_StyleWithAtt:attributeDict];

    }else if ([elementName isEqualToString:[DesignNodeConstants NODE_LAYOUT]]) { // node layout

        [self parseStartElement_LayoutWithAtt:attributeDict];

    }else if ([elementName isEqualToString:[DesignNodeConstants NODE_CONTAINER]]) {// node container

        [self parseStartElement_ContainerWithAtt:attributeDict];

    }else if ([elementName isEqualToString:[DesignNodeConstants NODE_VIEW]]) { // node view

        [self parseStartElement_ViewWithAtt:attributeDict];

    }else if ([elementName isEqualToString:[DesignNodeConstants NODE_SPACE]]) { // node space

        [self parseStartElement_SpaceWithAtt:attributeDict];

    }else if ([elementName isEqualToString:[DesignNodeConstants NODE_UI]]) {// node ui-root

        [self parseStartElement_UIWithElementName:elementName WithAtt:attributeDict];

    }
}

//-------------------------------------------------------------------------------
//  解析到了一个节点的结束句柄标识,在这里如果是遇到一个容器类型的节点,需要将这个容器从临时的容器
//  队列中将容器删除
//-------------------------------------------------------------------------------
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    // 元素终了句柄
    if (qName) {
        elementName = qName;
    }
    if ([elementName isEqualToString:[DesignNodeConstants NODE_CONTAINER]] || [elementName isEqualToString:[DesignNodeConstants NODE_LAYOUT]]) {
        if (self.tempContainerLayoutList.count > 0) {
            [self.tempContainerLayoutList removeLastObject];
        }
    }
    self.currentParseElement = nil;
}


//-------------------------------------------------------------------------------
//  获取元素的text元素
//-------------------------------------------------------------------------------
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (self.currentParseElement && [self.currentParseElement isKindOfClass:[DesignStyleModel class]]) {
        NSLog(@"string = %@", string);
        if (string && string.length > 0) {
            NSArray *array = [self transTextToPropertyKeyValue:string];
            if (array && array.count > 0) {
                NSMutableDictionary *dict = [self transPropertiesArrayToDict:array];
                [((DesignStyleModel *) self.currentParseElement) setStyleProperties:dict];
            }
        }
    }
}


//-------------------------------------------------------------------------------
//  解析完成,在这里可以发送一个通知,解析完成,并把解析后的uiModel元素发送出去
//-------------------------------------------------------------------------------
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"解析结束");
}




//-------------------------------------------------------------------------------
//  dealloc
//-------------------------------------------------------------------------------
- (void)dealloc {
    [_tempContainerLayoutList release]; _tempContainerLayoutList = nil;
    [_uiModel release]; _uiModel = nil;
    [_currentParseElement release]; _currentParseElement = nil;
    [super dealloc];
}




#pragma mark private function
//-------------------------------------------------------------------------------
//  将style 的text内容解析成数组的格式
//-------------------------------------------------------------------------------
-(NSArray *) transTextToPropertyKeyValue:(NSString *) text {
    NSArray *array = [text componentsSeparatedByString:@"\n"];
    NSMutableArray *result = [[[NSMutableArray alloc] init] autorelease];
    for (id value in array) {
        if (value && YES == [(NSString *)value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0) {
            [result addObject:[(NSString *)value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        }
    }
    return result;
}


//-------------------------------------------------------------------------------
//  将style内容解析后的数组格式映射成properties格式
//-------------------------------------------------------------------------------
-(NSMutableDictionary *) transPropertiesArrayToDict:(NSArray *) array {
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] init] autorelease];
    for (NSString *text in array) {
        if (text && text.length > 0) {
            NSArray *properties = [text componentsSeparatedByString:@":"];
            if (properties.count >= 2) {
                [dict setObject:properties[1] forKey:properties[0]];
            }
        }
    }
    return dict;
}



//-------------------------------------------------------------------------------
// 解析元素开始标识-UI节点,也就是根节点
//-------------------------------------------------------------------------------
- (void)parseStartElement_UIWithElementName:(NSString *)elementName WithAtt:(NSDictionary *)att {
    if (elementName && att) {
        if (nil == _uiModel) {
            _uiModel = [[DesignUIModel alloc] initWithParentLayout:nil];
        }
        _uiModel.uiId = elementName;
    }
}



//-------------------------------------------------------------------------------
// 解析元素开始标识-容器节点
//-------------------------------------------------------------------------------
- (void)parseStartElement_ContainerWithAtt:(NSDictionary *)att {
    if (att) {
        id parentModel = self.tempContainerLayoutList.count <= 0 ? self.uiModel :self.tempContainerLayoutList.lastObject;
        DesignContainerModel *designContainerModel = [[[DesignContainerModel alloc] initWithParentLayout:parentModel] autorelease];
        [self.tempContainerLayoutList addObject:designContainerModel];
    }
}

//-------------------------------------------------------------------------------
// 解析元素开始标识-view节点
//-------------------------------------------------------------------------------
- (void)parseStartElement_ViewWithAtt:(NSDictionary *)att {
    if (nil == att) {
        return;
    }
    id parentModel = self.tempContainerLayoutList.lastObject;
    if (nil == parentModel) {
        return;
    }
    DesignViewModel *designViewModel = [[DesignViewModel alloc] initWithParentModel:parentModel];
    for (NSString *key in att) {
        NSString *value = att[key];
        if (nil == value) {
            continue;
        }

        if ([key isEqualToString:[DesignNodeConstants NODE_CLASS]]) {
            designViewModel.clazz = value;
        } else if ([key isEqualToString:[DesignNodeConstants NODE_ID]]) {
            designViewModel.modelId = value;
        } else if ([key isEqualToString:[DesignNodeConstants NODE_W]]) {
            designViewModel.frame_width = value.floatValue;
        } else if ([key isEqualToString:[DesignNodeConstants NODE_H]]) {
            designViewModel.frame_height = value.floatValue;
        } else if ([key isEqualToString:[DesignNodeConstants NODE_X]]) {
            designViewModel.frame_x = value.floatValue;
        } else if ([key isEqualToString:[DesignNodeConstants NODE_Y]]) {
            designViewModel.frame_y = value.floatValue;
        } else if ([key isEqualToString:[DesignNodeConstants NODE_STYLE]]) {
            designViewModel.style = value;
        }
    }
    [designViewModel release];
}

//-------------------------------------------------------------------------------
// 解析元素开始标识-space节点
//-------------------------------------------------------------------------------
- (void)parseStartElement_SpaceWithAtt:(NSDictionary *)att {
    id parentModel = self.tempContainerLayoutList.lastObject;
    if (nil == parentModel) {
        return;
    }
    DesignSpaceModel *designSpaceModel = [[DesignSpaceModel alloc] initWithParentModel:parentModel];
    for (NSString *key in att) {
        NSString *value = att[key];
        if (nil == value) {
            return;
        }

        if ([key isEqualToString:[DesignNodeConstants NODE_W]]) {
            designSpaceModel.frame_width = value.floatValue;
        }else if ([key isEqualToString:[DesignNodeConstants NODE_H]]) {
            designSpaceModel.frame_height = value.floatValue;
        }
    }

    [designSpaceModel release];
}

//-------------------------------------------------------------------------------
// 解析元素开始标识-Layout节点
//-------------------------------------------------------------------------------
- (void)parseStartElement_LayoutWithAtt:(NSDictionary *)att {
    if (att) {
        id parentModel = self.uiModel;
        if (nil == parentModel) {
            NSLog(@"无法解析到ui节点");
            return;
        }
        DesignLayoutModel *designLayoutModel = [[[DesignLayoutModel alloc] initWithParentLayout:parentModel] autorelease];
        [self.tempContainerLayoutList addObject:designLayoutModel];
    }
}

//-------------------------------------------------------------------------------
// 解析元素开始标识-style节点
//-------------------------------------------------------------------------------
-(void) parseStartElement_StyleWithAtt:(NSDictionary *) att {
    if (nil == att) {
        return;
    }
    NSString *id = [att objectForKey:[DesignNodeConstants NODE_ID]];
    if (id) {
        DesignStyleModel *designStyleModel = [[[DesignStyleModel alloc] initWithStyleId:id] autorelease];
        self.currentParseElement = designStyleModel;
    }
}



//-------------------------------------------------------------------------------
// Get instance
//-------------------------------------------------------------------------------
+ (DesignParseXMLManager *)instance {
    if (nil == _designParseXMLManagerInstance) {
        _designParseXMLManagerInstance = [[DesignParseXMLManager alloc] init];
    }
    return _designParseXMLManagerInstance;
}


@end