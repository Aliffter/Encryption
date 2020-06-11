//
//  ZLXBaseViewController.m
//  数据加密
//
//  Created by leo on 2020/4/27.
//  Copyright © 2020年 AID. All rights reserved.
//

#import "ZLXBaseViewController.h"

@interface ZLXBaseViewController ()

@end

@implementation ZLXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
