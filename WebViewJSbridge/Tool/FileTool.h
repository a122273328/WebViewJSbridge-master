//
//  FileTool.h
//  WebViewJSbridge
//
//  Created by wzh on 2017/7/19.
//  Copyright © 2017年 wzh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FileTool : NSObject

/**
 *  copy文件
 */
+(BOOL)copyFile:(NSString *)srcPath dstPath:(NSString *)dstPath;

/**
 *  删除文件
 */
+(void)removeFile:(NSString *)path;

/**
 *  返回在documents路径里面的的文件
 *
 *
 *  @return 返回在documents路径里面的的文件
 */
+(NSString *)documentsFile:(NSString *)filename;

/**
 *  返回在resource路径里面的的文件
 *
 *  @return 返回在resource路径里面的的文件
 */
+(NSString *)resourceFile:(NSString *)filename;



/**
 获取bundle目录中文件路径
 
 @param filename 文件名
 @param type 类型
 @return 返回路径
 */
+ (NSString *)resourceFile:(NSString *)filename type:(NSString *)type;

/**
 *  返回在cache路径里面的的文件
 *
 *  @param filepath 文件
 
 */
+(NSString *)cacheFile:(NSString *)filepath;

/**
 *  检测文件是否存在
 *
 *  @param filePath 文件地址
 
 */
+(BOOL)isExistFile:(NSString *)filePath;


/**
 清除document文件下的匹配正则的文件
 
 */
+(void)clearDocumentFilesWithHasPrefix:(NSString *)hasRrefix;

//创建文件夹
+(BOOL)createDir:(NSString *)path;

@end
