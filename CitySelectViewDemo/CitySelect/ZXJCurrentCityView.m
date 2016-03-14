
//
//  ZXJCurrentCityView.m
//  GuaHao
//
//  Created by jianzhu on 16/3/1.
//  Copyright © 2016年 ikang. All rights reserved.
//

#import "ZXJCurrentCityView.h"
#import "ZXJCitySelectViewLocationManager.h"

@interface ZXJCurrentCityView ()

@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIView *locationView;
@property (nonatomic, strong) UIButton *currentCityButton;
@property (nonatomic, strong) ZXJCitySelectViewLocationManager *locationManager;

@property (nonatomic, copy) void(^selectedCurrentCityBlock)(UIButton *button);

@end

@implementation ZXJCurrentCityView

- (instancetype)initWithSelectedCurrentCity:(void (^)(UIButton *))selectedBlock
{
    _selectedCurrentCityBlock = selectedBlock;
    return [self init];
}

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self getCurrentCity];
    }
    return self;
}

- (void)getCurrentCity
{
    [self showLocationView];
    [self.locationManager getCurrentCityWithCompleteBlock:^(ZXJLocationStatus locationStatus, NSString *cityName) {
        [self hideLocationView];
        switch (locationStatus) {
            case ZXJLocationStatusSuccess:
            {
                [self showCurrentCityButton:cityName];
            }
                break;
            default:
            {
                [self statusLabelConfig:locationStatus];
            }
                break;
        }
    }];
}

- (void)buttonAction:(UIButton *)btn
{
    if (_selectedCurrentCityBlock) {
        _selectedCurrentCityBlock(btn);
    }
    if ([self.delegate respondsToSelector:@selector(currentCityDidSelected:)]) {
        [self.delegate currentCityDidSelected:btn.titleLabel.text];
    }
}

- (void)statusLabelConfig:(ZXJLocationStatus)status
{
    [self cleanView];
    [self addSubview:self.statusLabel];
    self.statusLabel.textColor = [UIColor colorWithRed:170 / 255.0 green:170 / 255.0 blue:170 / 255.0 alpha:1];
    self.statusLabel.frame = CGRectMake(15, 0, 290, CURRENT_CITY_VIEW_HEIGHT);
    switch (status) {
        case ZXJLocationStatusNoGPS:
        {
            NSString *tempString = @"定位失败，请开启GPS定位服务";
            NSMutableAttributedString *attrituteString = [[NSMutableAttributedString alloc] initWithString:tempString];
            NSRange range1 = [tempString rangeOfString:@"GPS"];
            [attrituteString setAttributes:@{NSForegroundColorAttributeName :[UIColor colorWithRed:48 / 255.0 green:50 / 255.0 blue:51 / 255.0 alpha:1],   NSFontAttributeName : [UIFont systemFontOfSize:15]} range:range1];
            self.statusLabel.attributedText = attrituteString;
        }
            break;
            case ZXJLocationStatusBadNet:
        {
            self.statusLabel.text = @"定位失败，请检查网络是否异常";
        }
            break;
            case ZXJLocationStatusServiceError:
        {
            self.statusLabel.text = @"定位失败，请检查是否设置位置信息权限";
        }
            break;
            case ZXJLocationStatusNoCity:
        {
            self.statusLabel.text = @"定位失败，没有您所在城市信息";
        }
            break;
        default:
            break;
    }
    
}

- (void)showCurrentCityButton:(NSString *)cityName
{
    [self cleanView];
    [self addSubview:self.currentCityButton];
    [self.currentCityButton setTitle:cityName forState:UIControlStateNormal];
    self.currentCityButton.frame = CGRectMake(15,(CURRENT_CITY_VIEW_HEIGHT - 36) / 2,BUTTON_WIDTH,36);
    
    [self addSubview:self.statusLabel];
    self.statusLabel.text = @"GPS定位";
    self.statusLabel.textColor = [UIColor grayColor];
    self.statusLabel.frame = CGRectMake(15 + self.currentCityButton.frame.origin.x + BUTTON_WIDTH, 0, 80, CURRENT_CITY_VIEW_HEIGHT);
}

- (void)cleanView
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (void)showLocationView
{
    [self addSubview:self.locationView];
    self.locationView.frame = CGRectMake(0, 0, 200, self.frame.size.height);
}

- (void)hideLocationView
{
    [self.locationView removeFromSuperview];
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
        _statusLabel.font = [UIFont systemFontOfSize:15];
    }
    return _statusLabel;
}

- (UIView *)locationView
{
    if (!_locationView) {
        _locationView = [UIView new];
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] init];
        activityIndicatorView.frame = CGRectMake(15, 0, CURRENT_CITY_VIEW_HEIGHT, CURRENT_CITY_VIEW_HEIGHT);
        activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        activityIndicatorView.color = [UIColor grayColor];
        activityIndicatorView.hidesWhenStopped = YES;
        [activityIndicatorView startAnimating];
        [_locationView addSubview:activityIndicatorView];
        
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(activityIndicatorView.frame.origin.x + CURRENT_CITY_VIEW_HEIGHT, 0, 100, CURRENT_CITY_VIEW_HEIGHT);
        label.text = @"定位中....";
        label.font = [UIFont systemFontOfSize:15.0f];
        [_locationView addSubview:label];
    }
    return _locationView;
}

- (UIButton *)currentCityButton
{
    if (!_currentCityButton) {
        _currentCityButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _currentCityButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _currentCityButton.tintColor = [UIColor blackColor];
        _currentCityButton.backgroundColor = [UIColor whiteColor];
        _currentCityButton.alpha = 0.8;
        _currentCityButton.layer.borderColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1].CGColor;
        _currentCityButton.layer.borderWidth = 1;
        _currentCityButton.layer.cornerRadius = 3;
        [_currentCityButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _currentCityButton;
}

- (ZXJCitySelectViewLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[ZXJCitySelectViewLocationManager alloc] init];
    }
    return _locationManager;
}


@end
