//
//  WKWebViewController.m
//  WebViewJSbridge
//
//  Created by wzh on 2017/7/19.
//  Copyright © 2017年 wzh. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "FileTool.h"
@interface WKWebViewController ()<WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic, strong)WKWebView *web;

@property (strong, nonatomic)  UIActivityIndicatorView       *activity;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createdWKWeb];
    [self initActivityView];
    [self loadHtml];
}

- (void)createdWKWeb{
    
    //注册handler
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    configuration.allowsInlineMediaPlayback = YES;
    //初始化
    self.web=[[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    self.web.backgroundColor = [UIColor lightTextColor];
    self.web.navigationDelegate=self;
    [self.view addSubview:self.web];
    //注册JS方法
    [configuration.userContentController addScriptMessageHandler:self name:@"open"];
    
//    [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];

}

- (void)loadHtml{
    
    NSString *url = @"test.html";
    
    NSString *webPath = [FileTool resourceFile:@"Web"];
    
    NSString *webModule = [[webPath stringByAppendingPathComponent:@"module"] stringByAppendingPathComponent:url];
    NSURL *webModuleURL = [NSURL URLWithString:[webModule stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *webModuleURLString = webModuleURL.query?[webModule stringByAppendingString:@"&is_app=1"]:[webModule stringByAppendingString:@"?is_app=1"];
    NSString *htmlString = [NSString stringWithContentsOfFile:webModuleURL.relativePath encoding:NSUTF8StringEncoding error:nil];
    
    [self.web loadHTMLString:htmlString baseURL:[NSURL URLWithString:webModuleURL.query]];
    
    
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

#pragma mark -- WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"requestURL: %@ \n %@", navigationAction.request,navigationAction.request.allHTTPHeaderFields);

}

#pragma mark --- WKScriptMessageHandler
//从一个网页调用一个脚本接收到消息
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"接收到消息");
    NSLog(@"--messageName:%@",message.name);
    NSLog(@"--messageBody:%@",message.body);
}

#pragma mark --- WKNavigationDelegate

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self.activity startAnimating];
    
}
//结束加载
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [self.activity stopAnimating];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
