//
// Created by apple on 13-4-27.
// Copyright (c) 2013 apple. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
@class DesignUIModel;


@interface DesignParseXMLManager : NSObject <NSXMLParserDelegate>
{
}

//-------------------------------------------------------------------------------
//  properties
//-------------------------------------------------------------------------------
@property(nonatomic, copy) NSString *xmlPath;
@property (nonatomic, retain) DesignUIModel* uiModel;
// 下面这个变量是用来解析的时候存储临时容器对象的,解析完成后,此变量中的count为0就对了
@property(nonatomic, retain) NSMutableArray *tempContainerLayoutList;
// 临时变量,也是用来辅助解析使用
@property (nonatomic, retain) id currentParseElement;
//-------------------------------------------------------------------------------
//  get instance
//-------------------------------------------------------------------------------
+(DesignParseXMLManager *) instance;


//-------------------------------------------------------------------------------
// 解析XML文件
// URL 文件路径
// error 解析错误
//-------------------------------------------------------------------------------
- (void)parseXMLFileAtURL:(NSString *)URL parseError:(NSError **)error;

@end