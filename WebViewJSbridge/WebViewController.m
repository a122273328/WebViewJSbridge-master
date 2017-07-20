//
//  WebViewController.m
//  WebViewJSbridge
//
//  Created by wzh on 2017/7/19.
//  Copyright © 2017年 wzh. All rights reserved.
//

#import "WebViewController.h"
#import "JavaScriptCoreBridge.h"
#import "FileTool.h"
@interface WebViewController ()<UIWebViewDelegate,JavaSctiptCoreBridgeDelegate>

@property (nonatomic, strong) UIWebView *web;

@property (strong, nonatomic)  UIActivityIndicatorView       *activity;

@property (strong, nonatomic) JavaScriptCoreBridge *webBrige;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createdWeb];
    
    [self loadHtml];
}

- (void)createdWeb{
    
    self.web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.web];
    self.web.delegate = self;
    self.webBrige = [[JavaScriptCoreBridge alloc] initWebViewBrigeWithWebView:self.web delegate:self];
    

}

- (void)loadHtml{
    
    NSString *url = @"test.html";
    
    NSString *webPath = [FileTool resourceFile:@"Web"];
    
    NSString *webModule = [[webPath stringByAppendingPathComponent:@"module"] stringByAppendingPathComponent:url];
    NSURL *webModuleURL = [NSURL URLWithString:[webModule stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *webModuleURLString = webModuleURL.query?[webModule stringByAppendingString:@"&is_app=1"]:[webModule stringByAppendingString:@"?is_app=1"];
    NSString *htmlString = [NSString stringWithContentsOfFile:webModuleURL.relativePath encoding:NSUTF8StringEncoding error:nil];
    
    [self.web loadHTMLString:htmlString baseURL:[NSURL URLWithString:webModuleURLString]];

    

}

- (void)initActivityView{
    
    self.activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];//指定进度轮的大小
    [self.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.activity hidesWhenStopped];
    [self.activity setCenter:self.view.center];//指定进度轮中心点
    
    [self.activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];//设置进度轮显示类型
    self.activity.color=[UIColor blackColor];
    
    [self.view addSubview:self.activity];
    
}

#pragma mark --- JavaSctiptCoreBridgeDelegate
- (void)open{

    NSLog(@"-------------");
}


-(void)dealloc{

    self.activity = nil;
    self.web = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
