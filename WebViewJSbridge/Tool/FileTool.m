//
//  FileTool.m
//  WebViewJSbridge
//
//  Created by wzh on 2017/7/19.
//  Copyright © 2017年 wzh. All rights reserved.
//

#import "FileTool.h"

@implementation FileTool

+(CGFloat)folderSizeAtPath:(NSString *)folderPath{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString *fileName = nil;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

+(long long)fileSizeAtPath:(NSString *)filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
    
}


+(void)removeFile:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:path error:nil];
}


+(BOOL)copyFile:(NSString *)srcPath dstPath:(NSString *)dstPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL res=[fileManager copyItemAtPath:srcPath toPath:dstPath error:&error];
    return  res;
}


+(NSString *)documentsFile:(NSString *)filename{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    return [NSString stringWithFormat:@"%@/%@",docDir,filename];
}


+(NSString *)resourceFile:(NSString *)filename{
    NSString * path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
    return path;
}


+ (NSString *)resourceFile:(NSString *)filename type:(NSString *)type{
    NSString * path = [[NSBundle mainBundle] pathForResource:filename ofType:type];
    return path;
}



+(NSString *)cacheFile:(NSString *)filepath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    NSArray *a=[filepath componentsSeparatedByString:@"/"];
    return [NSString stringWithFormat:@"%@/%@",cachesDir,[a objectAtIndex:a.count-1]];
}



+(BOOL)isExistFile:(NSString *)filePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath isDirectory:nil];
}



+(void)clearDocumentFilesWithHasPrefix:(NSString *)hasRrefix
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:docDir error:nil];
    
    for(NSString *file in files) {
        if([file hasPrefix:hasRrefix] && [file hasSuffix:@"db"]) {
            NSString *filePath = [self documentsFile:file];
            [self removeFile:filePath];
        }
    }
}


//创建文件夹
+(BOOL)createDir:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}

@end
