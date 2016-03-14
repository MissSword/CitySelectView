
//
//  GHCitySelectViewModel.m
//  GuaHao
//
//  Created by jianzhu on 16/3/4.
//  Copyright © 2016年 ikang. All rights reserved.
//

#import "ZXJCitySelectViewModel.h"
#import "ZXJCityModel.h"

@implementation ZXJCitySelectViewModel

- (void)getCitiesWithSuccessBlock:(void (^)(NSArray *, NSArray *))successBlock
{
    [self requestCitiesWithSuccessBlock:successBlock];
}

- (void)requestCitiesWithSuccessBlock:(void (^)(NSArray *, NSArray *))successBlock
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"TestCityList" ofType:@"plist"];
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
        NSLog(@"%@",dic);
        
        NSMutableArray *allCitiesArray = [NSMutableArray array];
        NSMutableArray *hotCitiesArray = [NSMutableArray array];
        NSArray *cities = [dic objectForKey:@"cityList"];
        NSArray *hotCities = [dic objectForKey:@"hotCities"];
        for (NSDictionary *cityDic in cities) {
            ZXJCityModel *model = [ZXJCityModel new];
            [model setValuesForKeysWithDictionary:cityDic];
            if ([[cityDic objectForKey:@"subCities"] count] > 0) {
                NSMutableArray *subCities = [NSMutableArray new];
                for (NSDictionary *subDic in [cityDic objectForKey:@"subCities"]) {
                    ZXJCityModel *subModel = [ZXJCityModel new];
                    [subModel setValuesForKeysWithDictionary:subDic];
                    [subCities addObject:subModel];
                }
                model.subCities = subCities;
            }
            [allCitiesArray addObject:model];
        }
        
        for (NSDictionary *hotDic in hotCities) {
            ZXJCityModel *model = [ZXJCityModel new];
            [model setValuesForKeysWithDictionary:hotDic];
            [hotCitiesArray addObject:model];
        }
        
       dispatch_async(dispatch_get_main_queue(), ^{
           
           NSLog(@"allCities:%@",allCitiesArray);
           NSLog(@"hotCities:%@",hotCitiesArray);
           successBlock(allCitiesArray,hotCitiesArray);
           
       });
    });
}

@end
