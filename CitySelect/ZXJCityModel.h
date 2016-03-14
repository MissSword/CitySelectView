//
//  ZXJCityModel.h
//  GuaHao
//
//  Created by jianzhu on 16/3/1.
//  Copyright © 2016年 ikang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXJCityModel : NSObject

@property (nonatomic, strong) NSNumber *cityId;
@property (nonatomic, strong) NSString *cityName;

@property (nonatomic, strong) NSArray *subCities;

@property (nonatomic, strong) NSString *initial;

@property (nonatomic, strong) NSString *parentId;

@end
