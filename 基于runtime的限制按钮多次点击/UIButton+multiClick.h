//
//  UIButton+multiClick.h
//  essa
//
//  Created by 裴文芹 on 2018/1/19.
//  Copyright © 2018年 cnwanweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (multiClick)

@property (assign, nonatomic) NSTimeInterval pp_acceptEventInterval;//重复点击的间隔
@property (assign, nonatomic) NSTimeInterval pp_acceptEventTime;

@end
