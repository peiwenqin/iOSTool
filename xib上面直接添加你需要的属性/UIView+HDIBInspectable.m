//
//  UIView+HDIBInspectable.m
//  RenFangClient
//
//  Created by 裴文芹 on 16/11/1.
//  Copyright © 2016年 peiwq. All rights reserved.
//

#import "UIView+HDIBInspectable.h"

@implementation UIView (HDIBInspectable)

#pragma mark - setCornerRadius/borderWidth/borderColor
- (void)setCornerRadius:(NSInteger)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (NSInteger)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setBorderWidth:(NSInteger)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (NSInteger)borderWidth
{
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}


@end
