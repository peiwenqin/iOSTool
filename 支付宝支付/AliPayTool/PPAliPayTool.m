//
//  PPAliPayTool.m
//  essa
//
//  Created by 裴文芹 on 2017/8/29.
//  Copyright © 2017年 cnwanweb. All rights reserved.
//

#import "PPAliPayTool.h"


@implementation PPAliPayTool

+ (instancetype)sharedInstance
{
    static PPAliPayTool *payTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        payTool = [[self alloc] init];
//                [AliPayTool sharedServices].apiKey = AliPayAppId;
    });
    return payTool;
}

- (void)payOrderSetingWithSignStr:(NSString *)signStr alipaySuccessCallBack:(alipaySuccess)successBlock
{
    // NOTE: 如果加签成功，则继续执行支付
    if (signStr) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkessa";
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:signStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            if (successBlock) {
                successBlock();
            }
        }];
    }
}


@end
