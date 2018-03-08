//
//  AMapInfo.m
//  essa
//
//  Created by 裴文芹 on 2017/9/13.
//  Copyright © 2017年 cnwanweb. All rights reserved.
//

#import "AMapInfo.h"

@implementation AMapInfo

-(NSString *)mapJsonStr
{
    if (!_mapJsonStr) {
        _mapJsonStr = [self changeMapInfoToJsonString];
    }
    return _mapJsonStr;
}

//将mapInfo对象转化为后台需要的json字符串
- (NSString *)changeMapInfoToJsonString
{
    return [NSString stringWithFormat:@"{'position':{'lng':%f,'lat':%f,'address':'%@'}}",self.longitude,self.latitude,self.address];
}

@end
