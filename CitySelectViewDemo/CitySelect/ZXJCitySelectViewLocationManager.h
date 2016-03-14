//
//  IKCitySelectViewTool.h
//  GuaHao
//
//  Created by jianzhu on 16/3/1.
//  Copyright © 2016年 ikang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZXJLocationStatus) {
    ZXJLocationStatusBadNet = 0,        //网络异常，开启了定位，
    ZXJLocationStatusServiceError = 1,  //定位失败，未开启应用定位权限
    ZXJLocationStatusSuccess,           //定位成功
    ZXJLocationStatusNoGPS,             //定位失败，未开启定位
    ZXJLocationStatusNoCity             //定位失败，未找到当前位置城市信息
};

@interface ZXJCitySelectViewLocationManager : NSObject

- (void)getCurrentCityWithCompleteBlock:(void(^)(ZXJLocationStatus locationStatus, NSString *cityName))complete;

@end
