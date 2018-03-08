//
//  UIView+HDIBInspectable.h
//  RenFangClient
//
//  Created by 裴文芹 on 16/11/1.
//  Copyright © 2016年 peiwq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HDIBInspectable)

@property (assign, nonatomic) IBInspectable NSInteger cornerRadius;
@property (assign, nonatomic) IBInspectable NSInteger borderWidth;
@property (strong, nonatomic) IBInspectable UIColor   *borderColor;

@end
