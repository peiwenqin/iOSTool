//
//  UIView+Wiggle.h
//
//  Created by Raj Kadam (2015)
//  Copyright (c) 2015 Electic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FixOrientation)

- (UIImage *)fixOrientation;
+ (UIImage *)compressedImageFiles:(UIImage *)image
                       imageBytes:(CGFloat)fImageBytes;
- (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;
- (NSData *)toMaxFileSize:(NSInteger)maxFileSize;
- (UIImage *)imagescaleToSize:(CGSize)size;
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;//

// 根据图片url获取图片尺寸
+ (CGSize)getImageSizeWithURL:(id)imageURL;

//解决有时候拍照或者图片，图片是旋转了90度的，
+(UIImage *)rotateImage:(UIImage *)aImage;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

@end
