//
//  HomeViewController.m
//  HongLingJin
//
//  Created by Anyson Chan on 15/10/10.
//  Copyright © 2015年 Anyson Chan. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeView.h"

@interface HomeViewController ()<HomeViewDelegate>

@end

@implementation HomeViewController

- (void)setupSubviews {
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_home"]];
    [bgView setFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:bgView];
    
    HomeView *homeView = [[HomeView alloc] initWithFrame:[[UIScreen mainScreen] bounds] delegate:self];
    [self.view addSubview:homeView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSubviews];
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

#pragma mark - HomeView delegate
- (void)homeViewShopping {
    
}

- (void)homeViewCoupon {
    
}

- (void)homeViewRainbowhome {
    
}

- (void)homeViewMessage {
    
}

- (void)homeViewProfile {
    
}

@end
