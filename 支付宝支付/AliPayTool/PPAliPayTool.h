//
//  PPAliPayTool.h
//  essa
//
//  Created by 裴文芹 on 2017/8/29.
//  Copyright © 2017年 cnwanweb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DefineSDKKey.h"
#import "RSADataSigner.h"

typedef void(^alipaySuccess)();

@interface PPAliPayTool : NSObject

+ (instancetype)sharedInstance;

- (void)payOrderSetingWithSignStr:(NSString *)signStr alipaySuccessCallBack:(alipaySuccess)successBlock;

@end
