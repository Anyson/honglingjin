//
//  ShoppingViewController.m
//  HongLingJin
//
//  Created by Anyson Chan on 15/10/10.
//  Copyright © 2015年 Anyson Chan. All rights reserved.
//

#import "ShoppingViewController.h"
#import <UIView+SDCAutoLayout.h>

@interface ShoppingViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    NSArray *_searchData;
    NSArray *_searchFilterData;
    
    __block NSArray *searchBarAlignConstraints;
}

@property (strong, nonatomic) UIView   *toolBar;
@property (strong, nonatomic) UIButton *backBtn;
@property (strong, nonatomic) UIButton *scanBtn;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UISearchDisplayController *searchDisplayController;


@property (strong, nonatomic) UITableView *tableView;


@end

@implementation ShoppingViewController

- (void)setupToolBar {
    _toolBar = [Common generateViewWithBackgroundColor:RGB(255, 44, 35)];
    [self.view addSubview:_toolBar];
    [_toolBar sdc_alignEdgesWithSuperview:UIRectEdgeTop | UIRectEdgeLeft | UIRectEdgeRight insets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_toolBar sdc_pinHeight:64];
    
    _backBtn = [Common generateButtonWithTarget:self action:@selector(back)];
    [_backBtn setImage:IMAGE(@"icon_nav_back_light") forState:UIControlStateNormal];
    [_toolBar addSubview:_backBtn];
    [_backBtn sdc_pinSize:CGSizeMake(44, 44)];
    [_backBtn sdc_alignEdgesWithSuperview:UIRectEdgeTop | UIRectEdgeLeft insets:UIEdgeInsetsMake(20, 0, 0, 0)];
    
    _searchBar = [[UISearchBar alloc] init];
    [_searchBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    _searchBar.placeholder = @"搜索商品";
    [_searchBar setImage:IMAGE(@"icon_top_search") forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [_searchBar setSearchFieldBackgroundImage:IMAGE(@"top_search_bg") forState:UIControlStateNormal];
    _searchBar.searchBarStyle = UISearchBarStyleProminent;
    [[[_searchBar.subviews objectAtIndex:0].subviews objectAtIndex:0]removeFromSuperview];
    _searchBar.tintColor = RGB(240, 240, 240);
    _searchBar.delegate = self;
    [_toolBar addSubview:_searchBar];
    searchBarAlignConstraints = [_searchBar sdc_alignEdgesWithSuperview:UIRectEdgeAll insets:UIEdgeInsetsMake(20, 35, 0, -35)];
    
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar contentsController:self];
    _searchDisplayController.searchResultsDataSource = self;
    _searchDisplayController.searchResultsDelegate = self;
    
    
    _scanBtn = [Common generateButtonWithTarget:self action:@selector(scan)];
    [_scanBtn setImage:IMAGE(@"icon_more_scan") forState:UIControlStateNormal];
    [_toolBar addSubview:_scanBtn];
    [_scanBtn sdc_pinSize:CGSizeMake(44, 44)];
    [_scanBtn sdc_alignEdgesWithSuperview:UIRectEdgeTop | UIRectEdgeRight insets:UIEdgeInsetsMake(20, 0, 0, 0)];
}

- (void)setupContentView {
    _tableView = [[UITableView alloc] init];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = RGB(246, 246, 246);
    [self.view addSubview:_tableView];
    [_tableView sdc_alignEdgesWithSuperview:UIRectEdgeAll
                                     insets:UIEdgeInsetsMake(64, 0, 0, 0)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(246, 246, 246);
    [self setupToolBar];
    [self setupContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - btn actions 
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scan {
    
}

#pragma mark - searchBar Delegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [_toolBar removeConstraints:searchBarAlignConstraints];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.025f
                     animations:^{
                         _backBtn.alpha = 0.0f;
                         _scanBtn.alpha = 0.0f;
                         searchBarAlignConstraints = [_searchBar sdc_alignEdgesWithSuperview:UIRectEdgeAll insets:UIEdgeInsetsMake(20, 0, 0, 0)];
                         [self.view layoutIfNeeded];
                     }];
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [_toolBar removeConstraints:searchBarAlignConstraints];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.025f
                     animations:^{
                         _backBtn.alpha = 1.0f;
                         _scanBtn.alpha = 1.0f;
                         searchBarAlignConstraints = [_searchBar sdc_alignEdgesWithSuperview:UIRectEdgeAll insets:UIEdgeInsetsMake(20, 35, 0, -35)];
                         [self.view layoutIfNeeded];
                     }];
}


#pragma mark - tablevie dataSource and delegate0
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableView == tableView) {
        return 2;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = @"aaa";
    return cell;
}

@end
