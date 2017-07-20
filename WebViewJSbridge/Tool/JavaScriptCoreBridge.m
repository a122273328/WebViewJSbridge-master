//
//  JavaScriptCoreBridge.m
//  WebViewJSbridge
//
//  Created by wzh on 2017/7/19.
//  Copyright © 2017年 wzh. All rights reserved.
//

#import "JavaScriptCoreBridge.h"

@interface JavaScriptCoreBridge()<UIWebViewDelegate,JSExportTest>

@property (nonatomic, weak) UIWebView                               *webView;

@property (nonatomic, weak) id<JavaSctiptCoreBridgeDelegate>              delegate;

@property (nonatomic, weak) JSContext                              *jsContext;

@end

@implementation JavaScriptCoreBridge

- (instancetype)initWebViewBrigeWithWebView:(UIWebView *)webView delegate:(id <JavaSctiptCoreBridgeDelegate>)delegate
{
    self = [super init];
    if(self){
        self.webView = webView;
        self.delegate = delegate;
        self.webView.delegate = self;
    }
    return self;
}



- (void)clearBrigeInterface{
    [self clearCusActions];
    self.delegate = nil;
    self.webView.delegate = nil;
    self.webView = nil;
}

/**
 添加自定义事件
 */
- (void)addCustomActions{
    
    self.jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    __weak JavaScriptCoreBridge *weakSelf = self;
    self.jsContext[@"NativeBrige"] = weakSelf;
    //监控异常信息
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
}


/**
 清除自定义事件
 */
- (void)clearCusActions{
    self.jsContext[@"NativeBrige"] = nil;
    self.jsContext = nil;
}



#pragma JSExportTest  与js交互的协议

- (void)open{
    
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"test('%@')",@"哈哈哈哈哈哈哈哈哈"]];

}


#pragma mark -- UIwebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if(self.delegate && [self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]){
        return [self.delegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }else{
        return YES;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [self clearCusActions];
    if (self.delegate && [self.delegate respondsToSelector:@selector(webViewDidStartLoad:)]){
        [self.delegate webViewDidStartLoad:webView];
    }
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self addCustomActions];
    if(self.delegate && [self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)]){
        [self.delegate webViewDidFinishLoad:webView];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if(self.delegate && [self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]){
        [self.delegate webView:webView didFailLoadWithError:error];
    }
}




@end
