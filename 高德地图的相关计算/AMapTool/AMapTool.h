//
//  AMapTool.h
//  areaside
//
//  Created by 裴文芹 on 2017/4/26.
//  Copyright © 2017年 cnwanweb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "AMapInfo.h"

typedef void(^fetchSelfPositionBlock)(CLLocationCoordinate2D coor, NSString *address);
typedef void(^fetchUserSelfLocateBlock)(AMapInfo *mapInfo);

@interface AMapTool : NSObject

+ (instancetype)sharedInstance;

//获取自身位置
- (void)fetchUserPositionDataBlock:(fetchSelfPositionBlock)dataBlock;

//计算两点的距离
+ (NSString *)caculaterTwoPointDistanceWithPoint1:(CLLocationCoordinate2D)coor1 point2:(CLLocationCoordinate2D)coor2;


//判断某点是否在某圆形范围内
+ (BOOL)judgeIsInCircleWithPoint:(CLLocationCoordinate2D)coor circleCenter:(CLLocationCoordinate2D)coorCenter distance:(NSString *)distanceStr;

@end
