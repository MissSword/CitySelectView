//
//  ViewController.m
//  CitySelectViewDemo
//
//  Created by jianzhu on 16/3/14.
//  Copyright © 2016年 ZXJ. All rights reserved.
//

#import "ViewController.h"
#import "ZXJSelectCityViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnAction:(id)sender {
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[ZXJSelectCityViewController new]];
    [self presentViewController:nav animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
