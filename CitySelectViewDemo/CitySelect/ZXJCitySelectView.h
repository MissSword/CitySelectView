//
//  ZXJCitySelectView.h
//  GuaHao
//
//  Created by jianzhu on 16/3/1.
//  Copyright © 2016年 ikang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXJCityModel.h"
#import "ZXJCitySelectTool.h"
#define CITY_SECTION_TITLE          @"CITY_SECTION_TITLE"
#define CITY_SECTION_CITIES         @"CITY_SECTION_CITIES"

@class ZXJCitySelectView;
@protocol ZXJCitySelectViewDataSource <NSObject>

@optional
- (NSArray<ZXJCityModel *> *)allCitiesInCitySelectView:(ZXJCitySelectView *)citySelectView;
- (NSArray<ZXJCityModel *> *)hotCitiesInCitySelectView:(ZXJCitySelectView *)citySelectView;

@end

@protocol ZXJCitySelectViewDelegate <NSObject>

@optional
- (void)didSelectedCity:(ZXJCityModel *)cityModel;
- (void)didSelectedCurrentCity:(NSString *)currentCity;

@end

@interface ZXJCitySelectView : UIView

- (instancetype)initWithCities:(NSArray<ZXJCityModel *> *)citiesArray frame:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame searchDisplaycontentsController:(UIViewController *)searchDisplaycontentsController;

@property (nonatomic, weak) UIViewController *searchDisplaycontentsController;
@property (nonatomic, weak) id<ZXJCitySelectViewDataSource> dataSource;
@property (nonatomic, weak) id<ZXJCitySelectViewDelegate> delegate;

- (void)reloadData;

@end
