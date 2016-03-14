//
//  ZXJCurrentCityView.h
//  GuaHao
//
//  Created by jianzhu on 16/3/1.
//  Copyright © 2016年 ikang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CURRENT_CITY_VIEW_HEIGHT        44
#define BUTTON_WIDTH                    ([[UIScreen mainScreen] bounds].size.width - 90) / 3

@protocol ZXJCurrentCityViewDelegate <NSObject>

- (void)currentCityDidSelected:(NSString *)cityModel;

@end

@interface ZXJCurrentCityView : UIView

- (instancetype)initWithSelectedCurrentCity:(void(^)(UIButton *button))selectedBlock;

@property (nonatomic, weak) id<ZXJCurrentCityViewDelegate> delegate;

@end
