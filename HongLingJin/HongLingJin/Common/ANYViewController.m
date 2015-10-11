//
//  ANYViewController.m
//  HongLingJin
//
//  Created by Anyson Chan on 15/10/10.
//  Copyright © 2015年 Anyson Chan. All rights reserved.
//

#import "ANYViewController.h"
#import <UINavigationController+FDFullscreenPopGesture.h>

@interface ANYViewController ()

@end

@implementation ANYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    // Do any additional setup after loading the view.
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
