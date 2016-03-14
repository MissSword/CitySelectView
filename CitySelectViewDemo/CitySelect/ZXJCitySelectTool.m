//
//  ZXJCitySelectTool.m
//  GuaHao
//
//  Created by jianzhu on 16/3/4.
//  Copyright © 2016年 ikang. All rights reserved.
//

#import "ZXJCitySelectTool.h"

@implementation ZXJCitySelectTool

NSArray * recomposeCities(NSArray *cities)
{
    
    
    NSMutableArray * desArray = [NSMutableArray arrayWithCapacity:0];
    //对数组a-z排序
    NSArray * tmpArray = [cities sortedArrayUsingFunction:sort context:NULL];
    NSArray * zimuKeyArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"#"];
    
    int count = 0;
    for (NSString * key in zimuKeyArray)
    {
        NSMutableDictionary * sectionDataSource = [NSMutableDictionary dictionaryWithCapacity:0];
        [sectionDataSource setObject:key forKey:CITY_SECTION_TITLE];
        
        NSMutableArray * sectionDataArray = [NSMutableArray arrayWithCapacity:0 ];
        [sectionDataSource setObject:sectionDataArray forKey:CITY_SECTION_CITIES];
        
        for (int index = 0; index < [tmpArray count]; index++)
        {
            ZXJCityModel * model = tmpArray[index];
            if ([model.initial isEqualToString:key]) {
                [sectionDataArray addObject:model];
            }
            count ++;
        }
        //过滤去除空索引
        if ([sectionDataArray count])
        {
            [desArray addObject:sectionDataSource];
        }
    }
    
    NSLog(@"%d",count);
    return desArray;
}

NSInteger sort(id area1, id area2, void *context)
{
    ZXJCityModel *region1 = (ZXJCityModel *)area1;
    ZXJCityModel *region2 = (ZXJCityModel *)area2;
    return  [region1.cityName localizedCompare:region2.cityName];
}


@end
