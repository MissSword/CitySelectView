//
//  ZXJCitySelectTool.h
//  GuaHao
//
//  Created by jianzhu on 16/3/4.
//  Copyright © 2016年 ikang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXJCityModel.h"

#define CITY_SECTION_TITLE          @"CITY_SECTION_TITLE"
#define CITY_SECTION_CITIES         @"CITY_SECTION_CITIES"

@interface ZXJCitySelectTool : NSObject

NSArray * recomposeCities(NSArray *cities);



@end
