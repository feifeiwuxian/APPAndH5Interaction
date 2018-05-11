//
//  ViewController.m
//  APPAndH5Interaction
//
//  Created by admin on 2018/5/10.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "JKUIwebViewTestVC.h"
#import "JKWKWebViewTestVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    [button setTitle:@"UIWebView" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(UIWebViewEvent) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 100)];
    [button1 setTitle:@"WKWebView" forState:(UIControlStateNormal)];
    [button1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button1 addTarget:self action:@selector(WKWebViewEvent) forControlEvents:(UIControlEventTouchUpInside)];

    [self.view addSubview:button1];

}

- (void)UIWebViewEvent {
    JKUIwebViewTestVC * vc = [[JKUIwebViewTestVC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)WKWebViewEvent {
    JKWKWebViewTestVC * vc = [[JKWKWebViewTestVC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
