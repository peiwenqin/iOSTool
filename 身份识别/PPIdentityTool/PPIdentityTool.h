//
//  PPIdentityTool.h
//  essa
//
//  Created by 裴文芹 on 2018/1/26.
//  Copyright © 2018年 cnwanweb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    IdentifierTypeKnown = 0,
    IdentifierTypeZipCode,      // 邮编
    IdentifierTypeEmail,        //2
    IdentifierTypePhone,        //3
    IdentifierTypeUnicomPhone,  //4
    IdentifierTypeQQ,           //5
    IdentifierTypeNumber,       //6
    IdentifierTypeString,       //7
    IdentifierTypeIdentifier,   //8
    IdentifierTypePassort,      //9
    IdentifierTypeCreditNumber, //10
    IdentifierTypeBirthday,     //11
} IdentifierType;


@interface PPIdentityTool : NSObject

+ (BOOL)isValid:(IdentifierType)type value:(NSString *)value;

@end
