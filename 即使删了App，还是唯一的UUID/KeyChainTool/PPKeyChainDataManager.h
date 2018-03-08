//
//  PPKeyChainDataManager.h
//  essa
//
//  Created by 裴文芹 on 2018/1/11.
//  Copyright © 2018年 cnwanweb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPKeyChainDataManager : NSObject

//存储UUID
+ (void)saveUUID;

//读取UUID
+ (NSString *)readUUID;

//删除UUID
+ (void)deleteUUID;

@end
