//
//  PPKeyChain.h
//  essa
//
//  Created by 裴文芹 on 2018/1/11.
//  Copyright © 2018年 cnwanweb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPKeyChain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)delete:(NSString *)service;

@end
