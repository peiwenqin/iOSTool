//
//  PPKeyChainDataManager.m
//  essa
//
//  Created by 裴文芹 on 2018/1/11.
//  Copyright © 2018年 cnwanweb. All rights reserved.
//

#import "PPKeyChainDataManager.h"
#import "PPKeyChain.h"

@implementation PPKeyChainDataManager

static NSString * const KEY_IN_KEYCHAIN_UUID = @"KEY_UUID";
static NSString * const KEY_UUID = @"key_uuid";


//存储UUID
+ (void)saveUUID
{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    NSString *deviceUUID = [[UIDevice currentDevice].identifierForVendor UUIDString];
    [usernamepasswordKVPairs setObject:deviceUUID forKey:KEY_UUID];
    
    [PPKeyChain save:KEY_IN_KEYCHAIN_UUID data:usernamepasswordKVPairs];
}

//读取UUID
+ (NSString *)readUUID
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[PPKeyChain load:KEY_IN_KEYCHAIN_UUID];
    
    return [usernamepasswordKVPair objectForKey:KEY_UUID];
}

//删除UUID
+ (void)deleteUUID
{
    [PPKeyChain delete:KEY_IN_KEYCHAIN_UUID];
}


@end
