//
//  PPAuthorityTool.h
//  Alarm
//  用于各类授权的判断
//  Created by 裴文芹 on 17/3/29.
//  Copyright © 2017年 peiwq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPAuthorityTool : NSObject

+ (BOOL)locateAuthenority;
+ (BOOL)cameraAuthenority;
+ (BOOL)photoLibraryAuthenority;

@end
