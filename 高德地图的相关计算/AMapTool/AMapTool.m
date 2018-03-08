//
//  AMapTool.m
//  areaside
//
//  Created by 裴文芹 on 2017/4/26.
//  Copyright © 2017年 cnwanweb. All rights reserved.
//

#import "AMapTool.h"
#import "MAGeometry.h"
#import "PPAuthorityTool.h"

@interface AMapTool()

@property (strong, nonatomic) AMapLocationManager *locationManager;

@end

@implementation AMapTool

+ (instancetype)sharedInstance
{
    static AMapTool *mapTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapTool = [[self alloc] init];
        [AMapServices sharedServices].apiKey = @"高德地图key";
    });
    return mapTool;
}

- (void)fetchUserPositionDataBlock:(fetchSelfPositionBlock)dataBlock
{
    if (![PPAuthorityTool locateAuthenority]) {
        return;
    }
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout = 10;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 10;
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            [MBProgressHUDHelper hideHUD];
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        NSLog(@"location:%@--reGeocode:%@", location,regeocode);
        
        if (dataBlock) {
            NSString *address = [NSString stringWithFormat:@"%@%@%@%@%@",regeocode.province,regeocode.city ? : @"",regeocode.district ? : @"",regeocode.street ? : @"",regeocode.number ? : @""];
           
            dataBlock(location.coordinate,address);
        }

    }];
}


+ (NSString *)caculaterTwoPointDistanceWithPoint1:(CLLocationCoordinate2D)coor1 point2:(CLLocationCoordinate2D)coor2
{
    //1.将两个经纬度点转成投影点
    MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(coor1.latitude,coor1.longitude));
    MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(coor2.latitude,coor2.longitude));
    //2.计算距离
    CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
    if (distance > 1000) {
        return [NSString stringWithFormat:@"%.2fkm",distance / 1000.0];
    } else {
        return [NSString stringWithFormat:@"%.2fm",distance];
    }
}


+ (BOOL)judgeIsInCircleWithPoint:(CLLocationCoordinate2D)coor circleCenter:(CLLocationCoordinate2D)coorCenter distance:(NSString *)distanceStr
{
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(coor.latitude,coor.longitude);
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(coorCenter.latitude,coorCenter.longitude);
    BOOL isContains = MACircleContainsCoordinate(location, center, [distanceStr integerValue]);
    return isContains;
}

#pragma mark setter && getter
- (AMapLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
    }
    return _locationManager;
}

@end
