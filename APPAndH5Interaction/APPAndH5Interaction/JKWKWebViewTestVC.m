//
//  JKWKWebViewTestVC.m
//  APPAndH5Interaction
//
//  Created by admin on 2018/5/10.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "JKWKWebViewTestVC.h"
#import <WebKit/WebKit.h>

@interface JKWKWebViewTestVC () <WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView * webView;

@end

@implementation JKWKWebViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    
    [configuration.userContentController addScriptMessageHandler:self name:@"call"];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 30.0;
    configuration.preferences = preferences;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"index1.html" ofType:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:urlStr];
    [self.webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
    
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 100)];
    [button setTitle:@"调用h5中的js" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(getAlertCall) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake(300, 200, 200, 100)];
    [button1 setTitle:@"返回" forState:(UIControlStateNormal)];
    [button1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button1 addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:button1];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL * url = navigationAction.request.URL;
    NSString * scheme = [url scheme];
    
    decisionHandler(WKNavigationActionPolicyAllow);
//    decisionHandler(WKNavigationActionPolicyCancel);
}

- (void)getAlertCall {
    NSString *jsStr = [NSString stringWithFormat:@"alerCallback('%@')",@"原生调用h5中的js成功"];
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@----%@",result, error);
    }];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%@", message);
    
    completionHandler();
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"+++++%@++++%@", message.body, message.name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
