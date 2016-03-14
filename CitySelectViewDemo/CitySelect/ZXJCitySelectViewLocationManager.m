//
//  IKCitySelectViewTool.m
//  GuaHao
//
//  Created by jianzhu on 16/3/1.
//  Copyright © 2016年 ikang. All rights reserved.
//

#import "ZXJCitySelectViewLocationManager.h"

@interface ZXJCitySelectViewLocationManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geoCoder;

@property (nonatomic, copy) void(^complete)(ZXJLocationStatus locationStatus, NSString *cityName);


@end


@implementation ZXJCitySelectViewLocationManager

#pragma mark -- publicFunction --
- (void)getCurrentCityWithCompleteBlock:(void (^)(ZXJLocationStatus, NSString *))complete
{
    
    if (![CLLocationManager locationServicesEnabled]) {
        complete(ZXJLocationStatusNoGPS,nil);
        return;
    }
    _complete = complete;
    [self.locationManager startUpdatingLocation];
}

#pragma mark -- LocationDelegate --
//定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [self.locationManager stopUpdatingLocation];
    [self reverseGeoLocationWith:[locations lastObject]];
}

//定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    _complete([error code],nil);
}

#pragma mark -- privateFunction --
- (void)reverseGeoLocationWith:(CLLocation *)location
{
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error || placemarks.count == 0) {
            _complete(ZXJLocationStatusNoCity,nil);
        }else{
            CLPlacemark *placemark = [placemarks firstObject];
            NSDictionary *city = placemark.addressDictionary;
            _complete(ZXJLocationStatusSuccess,[city objectForKey:@"City"]);
        }
    }];
}

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            [_locationManager requestWhenInUseAuthorization];
        }
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.distanceFilter = 10.0f;
    }
    return _locationManager;
}

- (CLGeocoder *)geoCoder
{
    if (!_geoCoder) {
        _geoCoder = [[CLGeocoder alloc] init];
    }
    return _geoCoder;
}

@end
