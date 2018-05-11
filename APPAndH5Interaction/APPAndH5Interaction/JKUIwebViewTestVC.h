//
//  JKUIwebViewTestVC.h
//  APPAndH5Interaction
//
//  Created by admin on 2018/5/10.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjcDelegate <JSExport>

- (void)call;

- (void)getCall:(NSString *)callString;

@end

@interface JKUIwebViewTestVC : UIViewController <UIWebViewDelegate, JSObjcDelegate>

@property (nonatomic, strong) JSContext *jsContext;
@property (strong, nonatomic)  UIWebView *webView;

@end
