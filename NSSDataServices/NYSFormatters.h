//
//  Created by Nikolay Spassov on 29.11.14.
//  Copyright (c) 2014 г. Nikolay Spassov. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* const NYSHTTPDateHeaderFormat = @"EEE, dd MMM yyyy HH:mm:ss zzz";


@interface NYSFormatters : NSObject

+ (NSDateFormatter *)technicalDateFormatter;
+ (NSDateFormatter *)technicalDateFormatterWithFormat:(NSString *)format;

+ (NSDateFormatter *)dateFormatter;

+ (NSDateFormatter *)dateFormatterRelative;
+ (NSDateFormatter *)dateFormatterRelativeInTimeZone:(NSTimeZone *)tz;

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format;
+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format inTimeZone:(NSTimeZone *)tz;

+ (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
+ (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle inTimeZone:(NSTimeZone *)tz;

+ (NSNumberFormatter *)numberFormatter;

+ (NSNumberFormatter *)currencyFormatter;
+ (NSNumberFormatter *)currencyFormatterWithoutCurrencySymbol;
+ (NSNumberFormatter *)currencyFormatterWithCurrencySymbol:(NSString *)cs;

+ (NSNumberFormatter *)decimalNumberFormatter;

@end
