//
//  ViewController.m
//  WebViewJSbridge
//
//  Created by wzh on 2017/7/19.
//  Copyright © 2017年 wzh. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "WKWebViewController.h"
#import "WebBridgeViewController.h"
#import "WKBridgeViewController.h"
@interface ViewController ()

@property (nonatomic, strong)UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

//进入webView
- (IBAction)jumpWebView:(id)sender {
    
    WebViewController *webVC = [[WebViewController alloc] init];
    
    [self.navigationController pushViewController:webVC animated:YES];
    
    webVC = nil;
    
}
- (IBAction)bridgeWeb:(id)sender {
    
    
    WebBridgeViewController *webVC = [[WebBridgeViewController alloc] init];
    
    [self.navigationController pushViewController:webVC animated:YES];
    
    webVC = nil;
}
//进入wkWebView
- (IBAction)jumpWKweb:(id)sender {
    
    WKWebViewController *webVC = [[WKWebViewController alloc] init];
    [self.navigationController pushViewController:webVC animated:YES];
    webVC = nil;
}
- (IBAction)wkWebBridge:(id)sender {
    
    WKBridgeViewController *webVC = [[WKBridgeViewController alloc] init];
    [self.navigationController pushViewController:webVC animated:YES];
    webVC = nil;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
