//
//  UIButton+multiClick.m
//  essa
//
//  Created by 裴文芹 on 2018/1/19.
//  Copyright © 2018年 cnwanweb. All rights reserved.
//

#import "UIButton+multiClick.h"
#import <objc/runtime.h>

@implementation UIButton (multiClick)

// 因category不能添加属性，只能通过关联对象的方式。
static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";

- (NSTimeInterval)pp_acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setPp_acceptEventInterval:(NSTimeInterval)pp_acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(pp_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";
- (NSTimeInterval)pp_acceptEventTime
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setPp_acceptEventTime:(NSTimeInterval)pp_acceptEventTime
{
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(pp_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 在load时执行hook
+ (void)load
{
//    if ([self isKindOfClass:[UIButton class]]) {
//        Method before = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
//        Method after = class_getInstanceMethod(self, @selector(pp_sendAction:to:forEvent:));
//        method_exchangeImplementations(before, after);
//    }
//        else {
//        [super load];
//    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzledSelector = @selector(pp_sendAction:to:forEvent:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)pp_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    NSString *str = NSStringFromClass([self class]);
    if ([str isEqualToString:@"UIButton"]) {
        self.pp_acceptEventInterval = 1.0f;
    } else {
        self.pp_acceptEventInterval = 0.0f;
    }
    if ([NSDate date].timeIntervalSince1970 - self.pp_acceptEventTime < self.pp_acceptEventInterval) {
        return;
    }
    
    if (self.pp_acceptEventInterval > 0) {
        self.pp_acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
        
    [self pp_sendAction:action to:target forEvent:event];
}

@end
