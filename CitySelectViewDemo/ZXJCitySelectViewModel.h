//
//  GHCitySelectViewModel.h
//  GuaHao
//
//  Created by jianzhu on 16/3/4.
//  Copyright © 2016年 ikang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXJCitySelectViewModel : NSObject


- (void)getCitiesWithSuccessBlock:(void(^)(NSArray *cities,NSArray *hotCites))successBlock;

@end
