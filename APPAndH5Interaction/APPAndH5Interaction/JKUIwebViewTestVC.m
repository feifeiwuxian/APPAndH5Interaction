//
//  JKUIwebViewTestVC.m
//  APPAndH5Interaction
//
//  Created by admin on 2018/5/10.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "JKUIwebViewTestVC.h"

@implementation JKUIwebViewTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    self.webView.delegate = self;
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
    
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 100)];
    [button setTitle:@"返回" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //添加图片可点击JS
//    [webView stringByEvaluatingJavaScriptFromString:@"function registerImageClickAction(){\
//     var imgs=document.getElementsByTagName('img');\
//     var length=imgs.length;\
//     for(var i=0;i<length;i++){\
//     img=imgs[i];\
//     img.onclick=function(){\
//     window.location.href='image-preview:'+this.src}\
//     }\
//     }"];
    self.jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"JKAPP"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    NSString * urlString = request.URL.absoluteString;
//    NSString * scheme =  request.URL.scheme;
    // 可以在此处根据url地址,或者 scheme判断是否需要拦截,返回NO,则不会跳转
    return YES;
}

#pragma mark JSObjectDelegate
- (void)call {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"\(^o^)/~h5调用原生成功" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:nil];
        [alert addAction:cancleAction];
        [self presentViewController:alert animated:YES completion:nil];
    });
}

- (void)getCall:(NSString *)callString {
    JSValue *Callback = self.jsContext[@"alerCallback"];
    [Callback callWithArguments:@[@"原生去掉用h5了"]];
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
