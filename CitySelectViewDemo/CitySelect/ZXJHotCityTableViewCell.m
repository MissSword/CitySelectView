//
//  ZXJHotCityTableViewCell.m
//  GuaHao
//
//  Created by jianzhu on 16/3/1.
//  Copyright © 2016年 ikang. All rights reserved.
//

#import "ZXJHotCityTableViewCell.h"

@implementation ZXJHotCityTableViewCell
{
    NSArray *_hotCities;
}

- (void)buttonAction:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(didselectedHotCity:)]) {
        [self.delegate didselectedHotCity:_hotCities[btn.tag - 100]];
    }
}

- (void)loadCellWithCities:(NSArray *)citiesArray
{
    _hotCities = citiesArray;
    for (int i = 0; i < [citiesArray count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(15 + (i % 3) * (BUTTON_WIDTH + 15), 15 + (i / 3) * (15 + BUTTON_HEIGHT), BUTTON_WIDTH, BUTTON_HEIGHT);
        [button setTitle:[(ZXJCityModel *)citiesArray[i] cityName]forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16.0];
        button.tintColor = [UIColor blackColor];
        button.backgroundColor = [UIColor whiteColor];
        button.alpha = 0.8;
        button.tag = 100 + i;
        button.layer.borderColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1].CGColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 3;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
