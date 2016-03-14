//
//  ZXJCityModel.m
//  GuaHao
//
//  Created by jianzhu on 16/3/1.
//  Copyright © 2016年 ikang. All rights reserved.
//

#import "ZXJCityModel.h"
#import "ChineseToPinyin.h"

@implementation ZXJCityModel

- (NSString *)initial
{
    if (!_initial.length) {
        return [self firstCharactor:_cityName];
    }
    return _initial;
}

- (NSString *)firstCharactor:(NSString *)string
{
    if (!string)
    {
        return nil;
    }
    if ([string length] == 0)
    {
        return @"#";
        
    }else if ([string canBeConvertedToEncoding: NSASCIIStringEncoding])
    {
        //如果是英语
        return [[NSString stringWithFormat:@"%c",[string characterAtIndex:0]] uppercaseString];
    }
    else
    {
        NSString *aString = [ChineseToPinyin pinyinFromChiniseString:string];
        return [aString substringWithRange:NSMakeRange(0, 1)];
    }
}


@end
