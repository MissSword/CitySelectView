//
//  ZXJCityTableViewCell.m
//  GuaHao
//
//  Created by jianzhu on 16/3/4.
//  Copyright © 2016年 ikang. All rights reserved.
//

#import "ZXJCityTableViewCell.h"

@interface ZXJCityTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;


@end

@implementation ZXJCityTableViewCell


- (void)loadCellWithModel:(ZXJCityModel *)model
{
    _namelabel.text = model.cityName;
    if (model.subCities.count) {
        _arrowImageView.hidden = NO;
    }else {
        _arrowImageView.hidden = YES;
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
