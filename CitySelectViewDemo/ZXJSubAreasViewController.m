//
//  ZXJSubAreasViewController.m
//  GuaHao
//
//  Created by jianzhu on 16/3/3.
//  Copyright © 2016年 ikang. All rights reserved.
//

#import "ZXJSubAreasViewController.h"
#import "ZXJCitySelectView.h"

@interface ZXJSubAreasViewController () <ZXJCitySelectViewDataSource,ZXJCitySelectViewDelegate>

@end

@implementation ZXJSubAreasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight ;
    
    self.title = @"选择城市";
    
    ZXJCitySelectView *cityView = [[ZXJCitySelectView alloc] initWithCities:self.subAreasArray frame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    cityView.delegate = self;
    [self.view addSubview:cityView];
}

- (NSArray<NSString *> *)allCitiesInCitySelectView:(ZXJCitySelectView *)citySelectView
{
    return self.subAreasArray;
}


- (void)didSelectedCity:(ZXJCityModel *)cityModel
{
    NSLog(@"%@",cityModel.cityName);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
