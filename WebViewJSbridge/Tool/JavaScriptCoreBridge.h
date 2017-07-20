//
//  JavaScriptCoreBridge.h
//  WebViewJSbridge
//
//  Created by wzh on 2017/7/19.
//  Copyright © 2017年 wzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JavaSctiptCoreBridgeDelegate <UIWebViewDelegate>


/**
 测试JS调OC
 */
- (void)open;

@end

@interface JavaScriptCoreBridge : NSObject

/**
 初始化web桥接接口
 
 @param webView webView
 @param delegate delegate
 @return instancetype
 */
- (instancetype)initWebViewBrigeWithWebView:(UIWebView *)webView delegate:(id <JavaSctiptCoreBridgeDelegate>)delegate;

/**
 清除桥接
 */
- (void)clearBrigeInterface;

@end

#pragma mark ---- 与JS交互协议

typedef void (^callback)(NSString *string);

@protocol JSExportTest <JSExport>

- (void)open;

@end
