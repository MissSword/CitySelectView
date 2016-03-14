//
//  ZXJHotCityTableViewCell.h
//  GuaHao
//
//  Created by jianzhu on 16/3/1.
//  Copyright © 2016年 ikang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXJCityModel.h"

#define BUTTON_WIDTH       ([[UIScreen mainScreen] bounds].size.width - 90) / 3
#define BUTTON_HEIGHT       36


@protocol ZXJHotCityTableViewCellDelegate <NSObject>

- (void)didselectedHotCity:(ZXJCityModel *)cityModel;

@end

@interface ZXJHotCityTableViewCell : UITableViewCell

@property (nonatomic, weak) id<ZXJHotCityTableViewCellDelegate> delegate;
- (void)loadCellWithCities:(NSArray *)citiesArray;

@end
