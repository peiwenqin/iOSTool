//
//  PPAuthorityTool.m
//  Alarm
//
//  Created by 裴文芹 on 17/3/29.
//  Copyright © 2017年 peiwq. All rights reserved.
//

#import "PPAuthorityTool.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MAMapKit/MAMapKit.h"

@implementation PPAuthorityTool

+ (BOOL)locateAuthenority
{
    
    if (![CLLocationManager locationServicesEnabled] ||
        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        //定位功能不可用，开始定位 kAppName
        [PCAlertView showAlertWithTitle:[NSString stringWithFormat:@"请到手机系统的[设置]->[隐私]->[定位服务]中打开定位服务，并允许\"%@\"使用定位服务，否则无法使用故障上报功能。",kAppName]];
        return NO;
    } else {
        return YES;
    }

}

+ (BOOL)cameraAuthenority
{
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == kCLAuthorizationStatusDenied)
    {
        //无权限
        [PCAlertView showAlertWithTitle:nil message:[NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相机\"选项中，允许\"%@\"访问你的相机功能",kAppName] cancelTitle:@"知道了" completion:nil];
        return NO;
    } else {
        return YES;
    }
}

+ (BOOL)photoLibraryAuthenority
{
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == kCLAuthorizationStatusDenied)
    {
        //无权限
        [PCAlertView showAlertWithTitle:nil message:[NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相册\"选项中，允许%@访问你的相册功能",kAppName] cancelTitle:@"知道了" completion:nil];
        return NO;
    } else {
        return YES;
    }

}

@end
