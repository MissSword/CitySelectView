//
//  ZXJSelectCityViewController.m
//  GuaHao
//
//  Created by jianzhu on 16/3/2.
//  Copyright © 2016年 ikang. All rights reserved.
//

#import "ZXJSelectCityViewController.h"
#import "ZXJSubAreasViewController.h"
#import "ZXJCitySelectView.h"
#import "ZXJCitySelectViewModel.h"

@interface ZXJSelectCityViewController () <ZXJCitySelectViewDataSource,ZXJCitySelectViewDelegate>

@property (nonatomic, strong) ZXJCitySelectViewModel *cityViewModel;
@property (nonatomic, strong) ZXJCitySelectView *citySelectView;

@end

@implementation ZXJSelectCityViewController
{
    NSArray *_allCitiesArray;
    NSArray *_hotCitiesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight ;
    self.title = @"选择省份";
    [self.view addSubview:self.citySelectView];
    [self.cityViewModel getCitiesWithSuccessBlock:^(NSArray *cities, NSArray *hotCites) {
        _allCitiesArray = cities;
        _hotCitiesArray = hotCites;
        [self.citySelectView reloadData];
    }];
    
}

- (NSArray<ZXJCityModel *> *)allCitiesInCitySelectView:(ZXJCitySelectView *)citySelectView
{
    return _allCitiesArray;
}

- (NSArray<ZXJCityModel *> *)hotCitiesInCitySelectView:(ZXJCitySelectView *)citySelectView
{
    return _hotCitiesArray;
}

- (void)didSelectedCity:(ZXJCityModel *)cityModel
{
    NSLog(@"%@",cityModel.cityName);
    if (cityModel.subCities.count > 0) {
        ZXJSubAreasViewController *subAreasVC = [[ZXJSubAreasViewController alloc] init];
        subAreasVC.subAreasArray = cityModel.subCities;
        [self.navigationController pushViewController:subAreasVC animated:YES];
    }
}

- (ZXJCitySelectViewModel *)cityViewModel
{
    if (!_cityViewModel) {
        _cityViewModel = [[ZXJCitySelectViewModel alloc] init];
    }
    return _cityViewModel;
}

- (ZXJCitySelectView *)citySelectView
{
    if (!_citySelectView) {
        _citySelectView = [[ZXJCitySelectView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) searchDisplaycontentsController:self];
        _citySelectView.dataSource = self;
        _citySelectView.delegate = self;
    }
    return _citySelectView;
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
