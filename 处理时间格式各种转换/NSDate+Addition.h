//
//  NSDate+Addition.h
//  xunjia
//
//  Created by Euan Chan on 13-6-18.
//  Copyright (c) 2013 cncn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Addition)

+ (NSString *)timestamp:(NSTimeInterval)createAt;
+ (NSString *)timestampForConversation:(NSTimeInterval)createAt;
+ (NSString *)timestampForConversationList:(NSTimeInterval)timeInterval;
+ (NSString *)timestampDesc:(NSTimeInterval)timeInterval;
+ (NSString *)timestampDescMMddHHmm:(NSTimeInterval)timeInterval;
+ (NSString *)timestampDescMMddHHmmss:(NSTimeInterval)timeInterval;//yyyy-MM-dd HH:mm:ss
+ (NSString *)timestampDescHHmmss:(NSTimeInterval)timeInterval;

+ (NSDate *)timestampDescMMdd:(NSTimeInterval)timeInterval;

+ (NSString *)timestampDescYYYYMMdd:(NSTimeInterval)timeInterval;

+ (NSString *)timeYYMMDD:(NSDate *)date;
+ (NSString *)timeHHMMSS:(NSDate *)date;
+ (NSString *)timeMMddHHmmss:(NSDate *)date;//yyyy-MM-dd HH:mm:ss
+ (NSString *)timeMMddHHmm:(NSDate *)date;//yyyy-MM-dd HH:mm
+ (NSString *)timeYYMM:(NSDate *)date;//yyyy-MM
+ (NSString *)timeYYYY:(NSDate *)date;//yyyy
+ (NSString *)timeMM:(NSDate *)date;//mm
+ (NSString *)timeHHmm:(NSDate *)date;//HH:mm
+ (NSString *)timedd:(NSDate *)date;//dd天

+ (NSString *)timeStampCompareNowMMdd:(NSTimeInterval)timeInterval;

+ (NSString *)timestampWithDay:(NSTimeInterval)timeInterval;
+ (NSString *)timestampWithMonth:(NSTimeInterval)timeInterval;
+ (NSString *)timestampWithChineseMonth:(NSTimeInterval)timeInterval;

+ (NSString *)dateTimeDifferenceWithStartTime:(NSDate *)startTime endTime:(NSDate *)endTime;//计算两个时间差

+ (NSString *)dateTimeDifferenceWithStartTimeLate:(NSDate *)startTime endTime:(NSDate *)endTime;//计算两个时间差


//将string类型的事件转化为date类型的时间
+ (NSDate *)dateTimeStringHHmmss:(NSString *)string;
+ (NSDate *)dateTimeStringHHmm:(NSString *)string;//string为08:00
+ (NSDate *)dateTimeStringYYMMDD:(NSString *)string;
+ (NSDate *)dateTimeStringYYMM:(NSString *)string;

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;//获取日期是星期几

//比较两个日期---YYMMDD类型
+ (NSInteger)compareYYMMDDDateWithFirstDate:(id)firstDate SecondDate:(id)secondDate;
+ (NSInteger)compareYYMMDateWithFirstDate:(id)firstDate SecondDate:(id)secondDate;
+ (NSInteger)compareHHMMWithFirstDate:(id)firstDate secondDate:(id)secondDate;


@end
