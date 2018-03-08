//
//  AMapInfo.h
//  essa
//
//  Created by 裴文芹 on 2017/9/13.
//  Copyright © 2017年 cnwanweb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface AMapInfo : NSObject

@property (assign, nonatomic) CGFloat latitude;
@property (assign, nonatomic) CGFloat longitude;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *mapJsonStr;

//将mapInfo对象转化为后台需要的json字符串
- (NSString *)changeMapInfoToJsonString;

@end
