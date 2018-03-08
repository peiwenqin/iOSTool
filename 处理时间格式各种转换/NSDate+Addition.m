//
//  NSDate+Addition.m
//  xunjia
//
//  Created by Euan Chan on 13-6-18.
//  Copyright (c) 2013 cncn. All rights reserved.
//

#import "NSDate+Addition.h"

@implementation NSDate (Addition)

+ (NSString*)timestamp:(NSTimeInterval)createdAt
{
    NSString *timestapL = nil;

    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }

    time_t now;
    time(&now);
    int distance = (int)difftime(now, (time_t)createdAt);
    
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:createdAt];
    NSDate *start;
    NSTimeInterval extends;
    NSCalendar *cal = [NSCalendar autoupdatingCurrentCalendar];
    NSDate *nowDate = [NSDate date];
    BOOL success = [cal rangeOfUnit:NSCalendarUnitDay startDate:&start interval:&extends forDate:nowDate];
    if (!success) {
        [dateFormatter setDateFormat:@"yy-MM-dd HH:mm"];
        timestapL = [dateFormatter stringFromDate:createDate];
    } else {
        NSTimeInterval dateInSecs = [createDate timeIntervalSinceReferenceDate];
        NSTimeInterval dayStartInSecs = [start timeIntervalSinceReferenceDate];
        if (dateInSecs > dayStartInSecs && dateInSecs < (dayStartInSecs + extends)) {
            // 今天
            if (distance < 60) {
                timestapL = [NSString stringWithFormat:@"刚刚"];
            }
            else if (distance < 60 * 60) {
                distance = distance / 60;
                timestapL = [NSString stringWithFormat:@"%d%@", distance, @"分钟前"];
            } else if (distance < 60 * 60 * 2) {
                distance = distance / 60 / 60;
                timestapL = [NSString stringWithFormat:@"%d%@", distance, @"小时前"];
            } else {
                [dateFormatter setDateFormat:@"HH:mm"];
                timestapL = [NSString stringWithFormat:@"今天 %@", [dateFormatter stringFromDate:createDate]];
            }            
        } else {
            NSTimeInterval yestodayStartInSecs = dayStartInSecs - 24 * 60 * 60;
            if (dateInSecs > yestodayStartInSecs && dateInSecs < dayStartInSecs) {
                // 昨天
                [dateFormatter setDateFormat:@"HH:mm"];
                timestapL = [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:createDate]];
            } else {
                [dateFormatter setDateFormat:@"yy-MM-dd HH:mm"];
                timestapL = [dateFormatter stringFromDate:createDate];
            }
        }
    }
    return timestapL;
}

+ (NSString *)timestampForConversation:(NSTimeInterval)createdAt
{
    NSString *timestapL = nil;
    
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
    NSDate *start;
    NSTimeInterval extends;
    NSCalendar *cal = [NSCalendar autoupdatingCurrentCalendar];
    NSDate *today = [NSDate date];
    BOOL success = [cal rangeOfUnit:NSCalendarUnitDay startDate:&start interval:&extends forDate:today];
    if (!success) {
        [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        timestapL = [dateFormatter stringFromDate:date];
    } else {
        NSTimeInterval dateInSecs = [date timeIntervalSinceReferenceDate];
        NSTimeInterval dayStartInSecs = [start timeIntervalSinceReferenceDate];
        if (dateInSecs > dayStartInSecs && dateInSecs < (dayStartInSecs + extends)) {
            // 今天
            [dateFormatter setDateFormat:@"HH:mm"];
            timestapL = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:date]];
        } else {
            NSTimeInterval yestodayStartInSecs = dayStartInSecs - 24 * 60 * 60;
            if (dateInSecs > yestodayStartInSecs && dateInSecs < dayStartInSecs) {
                // 昨天
                [dateFormatter setDateFormat:@"HH:mm"];
                timestapL = [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:date]];
            } else {
                NSTimeInterval aWeekBeforeInSecs = dayStartInSecs - 24 * 60 * 60 * 7;
                if (dateInSecs > aWeekBeforeInSecs && dateInSecs < yestodayStartInSecs) {
                    // 一周内
                    [dateFormatter setDateFormat:@"EEEE HH:mm"];
                    timestapL = [dateFormatter stringFromDate:date];
                } else {
                    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
                    timestapL = [dateFormatter stringFromDate:date];
                }
            }
        }

    }
    return timestapL;
}

+ (NSString *)timestampForConversationList:(NSTimeInterval)timeInterval
{
    NSString *timestapL = nil;
    
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDate *start;
    NSTimeInterval extends;
    NSCalendar *cal = [NSCalendar autoupdatingCurrentCalendar];
    NSDate *today = [NSDate date];
    BOOL success = [cal rangeOfUnit:NSCalendarUnitDay startDate:&start interval: &extends forDate:today];
    if (success) {
        NSTimeInterval dateInSecs = [date timeIntervalSinceReferenceDate];
        NSTimeInterval dayStartInSecs = [start timeIntervalSinceReferenceDate];
        if (dateInSecs > dayStartInSecs && dateInSecs < (dayStartInSecs + extends)) {
            // 今天
            [dateFormatter setDateFormat:@"HH:mm"];
            timestapL = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:date]];
        } else {
            NSTimeInterval yestodayStartInSecs = dayStartInSecs - 24 * 60 * 60;
            if (dateInSecs > yestodayStartInSecs && dateInSecs < dayStartInSecs) {
                // 昨天
                [dateFormatter setDateFormat:@"HH:mm"];
                timestapL = [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:date]];
            } else {
                NSTimeInterval aWeekBeforeInSecs = dayStartInSecs - 24 * 60 * 60 * 7;
                if (dateInSecs > aWeekBeforeInSecs && dateInSecs < yestodayStartInSecs) {
                    // 一周内
                    [dateFormatter setDateFormat:@"EEEE"];
                    timestapL = [dateFormatter stringFromDate:date];
                } else {
                    [dateFormatter setDateFormat:@"yy-MM-dd"];
                    timestapL = [dateFormatter stringFromDate:date];
                }
            }
        }
    } else {
        [dateFormatter setDateFormat:@"yy-MM-dd"];
        timestapL = [dateFormatter stringFromDate:date];
    }
    
    return timestapL;
}

+ (NSString *)timestampDesc:(NSTimeInterval)timeInterval
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    }
    
    return [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
}

+ (NSString *)timestampDescMMddHHmm:(NSTimeInterval)timeInterval
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    }
    
    return [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
}

+ (NSString *)timestampDescMMddHHmmss:(NSTimeInterval)timeInterval
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    }
    
    return [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
}

+ (NSString *)timestampDescHHmmss:(NSTimeInterval)timeInterval
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    }
    
    return [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
}

+ (NSDate *)timestampDescMMdd:(NSTimeInterval)timeInterval
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    }
    
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    return [dateFormatter dateFromString:dateStr];
}

+ (NSString *)timestampDescYYYYMMdd:(NSTimeInterval)timeInterval
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY/MM/dd"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    }
    
    return [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
}

+ (NSString *)timeYYMMDD:(NSDate *)date
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    }
    
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)timeHHMMSS:(NSDate *)date
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    }
    
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)timeMMddHHmmss:(NSDate *)date
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    }
    
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)timeMMddHHmm:(NSDate *)date
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    }
    
    return [dateFormatter stringFromDate:date];

}

+ (NSString *)timeYYMM:(NSDate *)date
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    }
    
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)timeYYYY:(NSDate *)date
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    }
    
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)timeMM:(NSDate *)date
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    }
    
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)timeHHmm:(NSDate *)date
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    }
    
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)timedd:(NSDate *)date
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    }
    NSString *str = [dateFormatter stringFromDate:date];
    NSInteger index = [str integerValue];
    return [NSString stringWithFormat:@"%ld",index];
}

+ (NSString *)timeStampCompareNowMMdd:(NSTimeInterval)timeInterval
{
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDate *date = [NSDate date];
    NSTimeInterval intevval = [date timeIntervalSinceDate:time];
    if (intevval < 60*60) {
        return @"刚刚";
    } else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM-dd HH:mm"];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
        }
        
        return [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    }
    
}

+ (NSString *)timestampWithDay:(NSTimeInterval)timeInterval
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
        
    }
     return [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
}

+ (NSString *)timestampWithMonth:(NSTimeInterval)timeInterval
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
        
    }
    return [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
}

+ (NSString *)timestampWithChineseMonth:(NSTimeInterval)timeInterval
{
    NSString *monthNum = [self timestampWithMonth:timeInterval];
    NSInteger num = [monthNum integerValue];
    switch (num) {
        case 1:
            return @"一月";
            break;
        case 2:
            return @"二月";
            break;
        case 3:
            return @"三月";
            break;
        case 4:
            return @"四月";
            break;
        case 5:
            return @"五月";
            break;
        case 6:
            return @"六月";
            break;
        case 7:
            return @"七月";
            break;
        case 8:
            return @"八月";
            break;
        case 9:
            return @"九月";
            break;
        case 10:
            return @"十月";
            break;
        case 11:
            return @"十一月";
            break;
        case 12:
            return @"十二月";
            break;
        default:
            return @"";
            break;
    }
}

+ (NSString *)dateTimeDifferenceWithStartTime:(NSDate *)startTime endTime:(NSDate *)endTime
{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval start = [startTime timeIntervalSince1970]*1;
    NSTimeInterval end = [endTime timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    int second = (int)value % 60;//秒
    int minute = (int)value /60 % 60;
    int house = (int)value / (24 * 3600 ) % 3600;
//    int day = (int)value / (24 * 3600);
    NSString *str;
//    if (house != 0) {
        str = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",house,minute,second];
//    }
//    else if (day== 0 && house== 0 && minute!=0) {
//        str = [NSString stringWithFormat:@"%.2d:%.2d",minute,second];
//    }else{
//        str = [NSString stringWithFormat:@"00:%.2d",second];
//        
//    }
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@"0"];
     return str;
}

+ (NSString *)dateTimeDifferenceWithStartTimeLate:(NSDate *)startTime endTime:(NSDate *)endTime
{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeInterval start = [startTime timeIntervalSince1970]*1;
    NSTimeInterval end = [endTime timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    int second = (int)value % 60;//秒
    int minute = (int)value /60 % 60;
    int house = (int)value / (24 * 3600 ) % 3600;
    int day = (int)value / (24 * 3600);
    NSString *str;
    if (day != 0) {
        str = [NSString stringWithFormat:@"%2d:%2d:%2d:%2d",day,house,minute,second];
    }else if (day==0 && house != 0) {
        str = [NSString stringWithFormat:@"%2d:%2d%2d",house,minute,second];
    }else if (day== 0 && house== 0 && minute!=0) {
        str = [NSString stringWithFormat:@"%2d:%2d",minute,second];
    }else{
        str = [NSString stringWithFormat:@"00:%2d",second];
        
    }
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@"0"];
    return str;

}

//将string类型的事件转化为date类型的时间
+ (NSDate *)dateTimeStringHHmmss:(NSString *)string
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];//指定转date得日期格式化形式

    return [dateFormatter dateFromString:string];
}

+ (NSDate *)dateTimeStringHHmm:(NSString *)string
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    [dateFormatter setDateFormat:@"HH:mm"];//指定转date得日期格式化形式
    
    return [dateFormatter dateFromString:string];
}

+ (NSDate *)dateTimeStringYYMMDD:(NSString *)string
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];//指定转date得日期格式化形式
    
    return [dateFormatter dateFromString:string];
}

+ (NSDate *)dateTimeStringYYMM:(NSString *)string
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    [dateFormatter setDateFormat:@"YYYY-MM"];//指定转date得日期格式化形式
    
    return [dateFormatter dateFromString:string];
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null],@"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

//比较两个日期---YYMMDD类型
+ (NSInteger)compareYYMMDDDateWithFirstDate:(id)firstDate SecondDate:(id)secondDate
{
    NSDate *date1 = nil;
    if ([firstDate isKindOfClass:[NSString class]]) {
        date1 = [self dateTimeStringYYMMDD:firstDate];
    } else {
        date1 = [self dateTimeStringYYMMDD:[self timeYYMMDD:firstDate]];
    }
    NSDate *date2 = nil;
    if ([secondDate isKindOfClass:[NSString class]]) {
        date2 = [self dateTimeStringYYMMDD:secondDate];
    } else {
        date2 = [self dateTimeStringYYMMDD:[self timeYYMMDD:secondDate]];
    }
    //-1  date1小    0 date1=date2   1  date1大
    return [date1 compare:date2];
    
}

+ (NSInteger)compareYYMMDateWithFirstDate:(id)firstDate SecondDate:(id)secondDate
{
    NSDate *date1 = nil;
    if ([firstDate isKindOfClass:[NSString class]]) {
        date1 = [self dateTimeStringYYMM:firstDate];
    } else {
        date1 = [self dateTimeStringYYMM:[self timeYYMM:firstDate]];
    }
    NSDate *date2 = nil;
    if ([secondDate isKindOfClass:[NSString class]]) {
        date2 = [self dateTimeStringYYMM:secondDate];
    } else {
        date2 = [self dateTimeStringYYMM:[self timeYYMM:secondDate]];
    }
    //-1  date1小    0 date1=date2   1  date1大
    return [date1 compare:date2];
}

+ (NSInteger)compareHHMMWithFirstDate:(id)firstDate secondDate:(id)secondDate
{
    NSString *date1 = nil;
    if ([firstDate isKindOfClass:[NSString class]]) {
        date1 = firstDate;
    } else {
        date1 = [self timeHHmm:firstDate];
    }
    
    NSString *date2 = nil;
    if ([secondDate isKindOfClass:[NSString class]]) {
        date2 = secondDate;
    } else {
        date2 = [self timeHHmm:secondDate];
    }
    
    NSString *date1HH = [[date1 componentsSeparatedByString:@":"] firstObject];
    NSString *date1mm = [[date1 componentsSeparatedByString:@":"] lastObject];
    NSString *date2HH = [[date2 componentsSeparatedByString:@":"] firstObject];
    NSString *date2mm = [[date2 componentsSeparatedByString:@":"] lastObject];
    
    if ([date1HH integerValue] < [date2HH integerValue]) {
        return -1;
    } else if ([date1HH integerValue] == [date2HH integerValue]) {
        if ([date1mm integerValue] < [date2mm integerValue]) {
            return -1;
        } else if ([date1mm integerValue] == [date2mm integerValue]) {
            return 0;
        } else {
            return 1;
        }
    } else {
        return 1;
    }
    //-1  date1小    0 date1=date2   1  date1大
}

@end
