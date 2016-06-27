//
//  Created by Nikolay Spassov on 29.11.14.
//  Copyright (c) 2014 г. Nikolay Spassov. All rights reserved.
//

#import "NYSFormatters.h"

@interface NYSFormatters ()

@property (strong, nonatomic) NSCalendar* calendar;
@property (strong, nonatomic) NSDateFormatter* technicalDateFormatter;
@property (strong, nonatomic) NSDateFormatter* dateFormatter;
@property (strong, nonatomic) NSNumberFormatter* numberFormatter;

@end

@implementation NYSFormatters

+ (instancetype)sharedInstance
{
    static NYSFormatters* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

+ (NSCalendar *)calendar
{
    return [[self sharedInstance] calendar];
}

#pragma mark - Date Formatters

+ (NSDateFormatter *)technicalDateFormatter
{
    return [[self sharedInstance] technicalDateFormatter];
}

+ (NSDateFormatter *)technicalDateFormatterWithFormat:(NSString *)format
{
    [self.technicalDateFormatter setDateFormat:format];
    return [self technicalDateFormatter];
}


+ (NSDateFormatter *)dateFormatter
{
    return [[self sharedInstance] dateFormatter];
}

+ (NSDateFormatter *)dateFormatterRelative
{
    return [self dateFormatterRelativeInTimeZone:[[self calendar] timeZone]];
}

+ (NSDateFormatter *)dateFormatterRelativeInTimeZone:(NSTimeZone *)tz
{
    [self.dateFormatter setTimeZone:tz];
    [self.dateFormatter setDoesRelativeDateFormatting:YES];
    [self.dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    return [self dateFormatter];
}

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format
{
    return [self dateFormatterWithFormat:format inTimeZone:[[self calendar] timeZone]];
}

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format inTimeZone:(NSTimeZone *)tz
{
    [self.dateFormatter setTimeZone:tz];
    [self.dateFormatter setDoesRelativeDateFormatting:NO];
    [self.dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [self.dateFormatter setDateFormat:format];
    return [self dateFormatter];
}

+ (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle
{
    return [self dateFormatterWithDateStyle:dateStyle timeStyle:timeStyle inTimeZone:[[self calendar] timeZone]];
}

+ (NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle inTimeZone:(NSTimeZone *)tz
{
    [self.dateFormatter setTimeZone:tz];
    [self.dateFormatter setDoesRelativeDateFormatting:NO];
    [self.dateFormatter setDateStyle:dateStyle];
    [self.dateFormatter setTimeStyle:timeStyle];
    return [self dateFormatter];
}


#pragma mark - Number Formatters

+ (NSNumberFormatter *)numberFormatter
{
    return [[self sharedInstance] numberFormatter];
}

+ (NSNumberFormatter *)currencyFormatter
{
    return [self currencyFormatterWithCurrencySymbol:[[self numberFormatter] currencySymbol]];
}

+ (NSNumberFormatter *)currencyFormatterWithoutCurrencySymbol
{
    return [self currencyFormatterWithCurrencySymbol:nil];
}

+ (NSNumberFormatter *)currencyFormatterWithCurrencySymbol:(NSString *)cs
{
    [self.numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    if(!cs || ![cs length]) {
        [self.numberFormatter setNegativePrefix:@"–"];
        [self.numberFormatter setNegativeSuffix:@""];
        [self.numberFormatter setPositivePrefix:@""];
        [self.numberFormatter setPositiveSuffix:@""];
    }
    else if([cs length] == 1) {
        [self.numberFormatter setNegativePrefix:[NSString stringWithFormat:@"%@ –", cs]];
        [self.numberFormatter setNegativeSuffix:@""];
        [self.numberFormatter setPositivePrefix:[NSString stringWithFormat:@"%@", cs]];
        [self.numberFormatter setPositiveSuffix:@""];
    }
    else {
        [self.numberFormatter setNegativePrefix:@"–"];
        [self.numberFormatter setNegativeSuffix:[NSString stringWithFormat:@" %@", cs]];
        [self.numberFormatter setPositivePrefix:@""];
        [self.numberFormatter setPositiveSuffix:[NSString stringWithFormat:@" %@", cs]];
    }
    return [self numberFormatter];
}

+ (NSNumberFormatter *)decimalNumberFormatter
{
    [self.numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [self.numberFormatter setNegativePrefix:@"–"];
    [self.numberFormatter setNegativeSuffix:@""];
    [self.numberFormatter setPositivePrefix:@""];
    [self.numberFormatter setPositiveSuffix:@""];
    return [self numberFormatter];
}


#pragma mark - Getters

- (NSCalendar *)calendar
{
    if(!_calendar) {
        _calendar = [NSCalendar currentCalendar];
    }
    return _calendar;
}

- (NSDateFormatter *)technicalDateFormatter
{
    if(!_technicalDateFormatter) {
        _technicalDateFormatter = [NSDateFormatter new];
        [_technicalDateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
        [_technicalDateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    }
    return _technicalDateFormatter;
}

- (NSDateFormatter *)dateFormatter
{
    if(!_dateFormatter) {
        _dateFormatter = [NSDateFormatter new];
        [_dateFormatter setLocale:[NSLocale autoupdatingCurrentLocale]];
    }
    return _dateFormatter;
}

- (NSNumberFormatter *)numberFormatter
{
    if(!_numberFormatter) {
        _numberFormatter = [NSNumberFormatter new];
        [_numberFormatter setLocale:[NSLocale autoupdatingCurrentLocale]];
    }
    return _numberFormatter;
}

@end
