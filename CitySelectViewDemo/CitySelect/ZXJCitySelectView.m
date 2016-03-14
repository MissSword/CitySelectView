//
//  ZXJCitySelectView.m
//  GuaHao
//
//  Created by jianzhu on 16/3/1.
//  Copyright © 2016年 ikang. All rights reserved.
//

#import "ZXJCitySelectView.h"
#import "ZXJHotCityTableViewCell.h"
#import "ZXJCityTableViewCell.h"
#import "ZXJCurrentCityView.h"
#import "ChineseToPinyin.h"

@interface ZXJCitySelectView () <UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDelegate,UITableViewDataSource,ZXJCurrentCityViewDelegate,ZXJHotCityTableViewCellDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;
@property (nonatomic, strong) ZXJCurrentCityView *currentCityView;

@property (nonatomic, strong) NSMutableArray *allCitiesArray;
@property (nonatomic, strong) NSMutableArray *searchResultArray;


@end

@implementation ZXJCitySelectView
{
    NSArray *_citiesArray;
    NSArray *_titilesArray;
    NSArray *_hotCitiesArray;
}

- (instancetype)initWithCities:(NSArray<ZXJCityModel *> *)citiesArray frame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _citiesArray = citiesArray;
        [self configData];
        [self addSubview:self.tableView];
        [self.tableView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame searchDisplaycontentsController:(UIViewController *)searchDisplaycontentsController
{
    self.searchDisplaycontentsController = searchDisplaycontentsController;
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configView];
    }
    return self;
}

- (void)setDataSource:(id<ZXJCitySelectViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self reloadData];
}

- (void)reloadData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self configData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    });
}

#pragma mark -- dataConfig --
- (void)configData
{
    if ([self.dataSource respondsToSelector:@selector(allCitiesInCitySelectView:)]) {
        _citiesArray = [self.dataSource allCitiesInCitySelectView:self];
    }
    if ([self.dataSource respondsToSelector:@selector(hotCitiesInCitySelectView:)]) {
        _hotCitiesArray = [self.dataSource hotCitiesInCitySelectView:self];
    }
    if (_hotCitiesArray.count) {
        NSDictionary *hotCityDictionary = @{CITY_SECTION_TITLE:@"热门城市",CITY_SECTION_CITIES:_hotCitiesArray};
        [self.allCitiesArray addObject:hotCityDictionary];
    }
    [self.allCitiesArray addObjectsFromArray:recomposeCities(_citiesArray)];
}


#pragma mark -- currentCityViewDelegate --
- (void)currentCityDidSelected:(UIButton *)cityButton
{
    NSLog(@"%@",cityButton.titleLabel.text);
    if ([self.delegate respondsToSelector:@selector(didSelectedCurrentCity:)]) {
        [self.delegate didSelectedCurrentCity:cityButton.titleLabel.text];
    }
}

- (void)didselectedHotCity:(ZXJCityModel *)cityModel
{
    if ([self.delegate respondsToSelector:@selector(didSelectedCity:)]) {
        [self.delegate didSelectedCity:cityModel];
    }
}

#pragma mark -- searchBarDelegate --
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    _searchDisplayController.active = YES;
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self.searchResultArray removeAllObjects];
    for (int i = 0; i < _citiesArray.count; i++) {
        if ([[ChineseToPinyin pinyinFromChiniseString:[_citiesArray[i] cityName]] hasPrefix:[searchString uppercaseString]] || [[_citiesArray[i] cityName] hasPrefix:searchString]) {
            [self.searchResultArray addObject:_citiesArray[i]];
        }
    }
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    [self searchDisplayController:controller shouldReloadTableForSearchString:_searchBar.text];
    return YES;
}


#pragma mark ------------------tableViewDelegate----------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _tableView) {
        return [self.allCitiesArray count];
    }else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _tableView) {
        if (section == 0 && _hotCitiesArray.count > 0) {
            return 1;
        }else {
            return [_allCitiesArray[section][CITY_SECTION_CITIES] count];
        }
        return 0;
    }else{
        return [self.searchResultArray count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView) {
        if (indexPath.section == 0 && _hotCitiesArray.count > 0) {
            return ceil((float)[_hotCitiesArray count] / 3) * (BUTTON_HEIGHT + 15) + 15;
        }
        return 44;
    }else{
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _tableView) {
        static NSString *identifier = @"HOTCELL";
        if (indexPath.section == 0 && _hotCitiesArray.count > 0) {
            ZXJHotCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[ZXJHotCityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell loadCellWithCities:_hotCitiesArray];
            return cell;
        }else {
            static NSString *identifier = @"CELL";
            ZXJCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ZXJCityTableViewCell" owner:self options:nil] lastObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            ZXJCityModel *model = _allCitiesArray[indexPath.section][CITY_SECTION_CITIES][indexPath.row];
            [cell loadCellWithModel:model];
            return cell;
        }
    }else {
        static NSString *identifier = @"SEARCHCELL";
        ZXJCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ZXJCityTableViewCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        ZXJCityModel *model = self.searchResultArray[indexPath.row];
        [cell loadCellWithModel:model];
        return cell;
    }
    return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView == _tableView) {
        NSMutableArray *titleSectionArray = [NSMutableArray array];
        for (int i = 0; i < [_allCitiesArray count]; i++) {
            if (_hotCitiesArray.count > 0 & i == 0) {
                
            }else {
                NSString *title = _allCitiesArray[i][CITY_SECTION_TITLE];
                [titleSectionArray addObject:title];
            }
        }
        return titleSectionArray;
    }else{
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == _tableView) {
        UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
        sectionView.backgroundColor = [UIColor colorWithRed:233 / 255.0 green:233 / 255.0 blue:233 / 255.0 alpha:1];
        UILabel * titleLabel = [[ UILabel alloc ] initWithFrame:CGRectMake(15, 5, tableView.frame.size.width - 30, 20)];
        [sectionView addSubview:titleLabel];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor colorWithRed:199 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:1];
        titleLabel.text = _allCitiesArray[section][CITY_SECTION_TITLE];
        return sectionView;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _tableView) {
        return 30.0f;
    }else{
        return 0.01;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView) {
        if (indexPath.section == 0 && _hotCitiesArray.count > 0) {
            
        }else {
            if ([self.delegate respondsToSelector:@selector(didSelectedCity:)]) {
                [self.delegate didSelectedCity:_allCitiesArray[indexPath.section][CITY_SECTION_CITIES][indexPath.row]];
            }
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(didSelectedCity:)]) {
            [self.delegate didSelectedCity:self.searchResultArray[indexPath.row]];
        }
    }
}

#pragma mark ------------------------configView-----------------------
- (void)configView
{
    [self addSubview:self.searchBar];
    [self searchDisplayController];
    [self addSubview:self.currentCityView];
    [self addSubview:self.tableView];
    
    [self.searchBar setFrame:CGRectMake(0, 0, self.frame.size.width,44)];
    [self.currentCityView setFrame:CGRectMake(0, self.searchBar.frame.origin.y + 44, self.frame.size.width, CURRENT_CITY_VIEW_HEIGHT)];
    [self.tableView setFrame:CGRectMake(0, self.currentCityView.frame.origin.y + CURRENT_CITY_VIEW_HEIGHT, self.frame.size.width, self.frame.size.height - self.currentCityView.frame.origin.y - CURRENT_CITY_VIEW_HEIGHT)];
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.placeholder = @"搜索城市";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.frame.size.width, self.frame.size.height - 44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
        _tableView.sectionIndexColor = [UIColor colorWithRed:16 / 255.0 green:103 / 255.0 blue:1 alpha:1];
        _tableView.backgroundColor = [UIColor colorWithRed:233 / 255.0 green:233 / 255.0 blue:233 / 255.0 alpha:1];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UISearchDisplayController *)searchDisplayController
{
    if (!_searchDisplayController) {
        _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self.searchDisplaycontentsController];
        _searchDisplayController.delegate = self;
        _searchDisplayController.searchResultsDelegate = self;
        _searchDisplayController.searchResultsDataSource = self;
    }
    return _searchDisplayController;
}

- (NSMutableArray *)allCitiesArray
{
    if (!_allCitiesArray) {
        _allCitiesArray = [NSMutableArray array];
    }
    return _allCitiesArray;
}

- (NSMutableArray *)searchResultArray
{
    if (!_searchResultArray) {
        _searchResultArray = [NSMutableArray array];
    }
    return _searchResultArray;
}

- (ZXJCurrentCityView *)currentCityView
{
    if (!_currentCityView) {
        _currentCityView = [[ZXJCurrentCityView alloc] init];
        _currentCityView.delegate = self;
    }
    return _currentCityView;
}


@end
