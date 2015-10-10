//
//  HomeView.m
//  HongLingJin
//
//  Created by Anyson Chan on 15/10/10.
//  Copyright © 2015年 Anyson Chan. All rights reserved.
//

#import "HomeView.h"
#import <SDCAutoLayout/UIView+SDCAutoLayout.h>

@implementation HomeView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<HomeViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = delegate;
        [self setupSubviews];
    }
    return self;
}

- (void)setupLogoView {
    UIImageView *logoView = [Common generateImageViewWithImage:IMAGE(@"icon_home_logo")];
    [self addSubview:logoView];
    
    [logoView sdc_alignEdgesWithSuperview:UIRectEdgeTop insets:UIEdgeInsetsMake(CGHeightMake(60), 0, 0, 0)];
    [logoView sdc_horizontallyCenterInSuperview];
    [logoView sdc_pinSize:CGSizeMake1(126, 95)];
    
}

- (void)setupContentView {
    UIView *contentView = [Common generateViewWithBackgroundColor:[UIColor clearColor]];
    [self addSubview:contentView];
    [contentView sdc_pinHeight:CGHeightMake(211)];
    [contentView sdc_alignEdgesWithSuperview:UIRectEdgeLeft | UIRectEdgeRight insets:UIEdgeInsetsZero];
    [contentView sdc_centerInSuperview];
    
    UIButton *shoppingBtn = [Common generateButtonWithTarget:self action:@selector(shoppingBtnPress)];
    [shoppingBtn setBackgroundImage:IMAGE(@"icon_home_shopping_a") forState:UIControlStateNormal];
    [shoppingBtn setBackgroundImage:IMAGE(@"icon_home_shopping_b") forState:UIControlStateHighlighted];
    [contentView addSubview:shoppingBtn];
    [shoppingBtn sdc_horizontallyCenterInSuperview];
    [shoppingBtn sdc_alignEdgesWithSuperview:UIRectEdgeTop insets:UIEdgeInsetsZero];
    [shoppingBtn sdc_pinSize:CGSizeMake1(122, 122)];
    
    
    UIButton *couponBtn = [Common generateButtonWithTarget:self action:@selector(couponBtnPress)];
    [couponBtn setBackgroundImage:IMAGE(@"icon_home_coupon_a") forState:UIControlStateNormal];
    [couponBtn setBackgroundImage:IMAGE(@"icon_home_coupon_b") forState:UIControlStateHighlighted];
    [contentView insertSubview:couponBtn belowSubview:shoppingBtn];
    [couponBtn sdc_horizontallyCenterInSuperviewWithOffset:(CGWidthMake(23.5) + CGWidthMake(96)/2)];
    [couponBtn sdc_alignEdgesWithSuperview:UIRectEdgeTop insets:UIEdgeInsetsMake(CGHeightMake(71), 0, 0, 0)];
    [couponBtn sdc_pinSize:CGSizeMake1(96, 140)];
    
    
    UIButton *rainbowhomeBtn = [Common generateButtonWithTarget:self action:@selector(rainbowhomeBtnPress)];
    [rainbowhomeBtn setBackgroundImage:IMAGE(@"icon_home_Rainbowhome_a") forState:UIControlStateNormal];
    [rainbowhomeBtn setBackgroundImage:IMAGE(@"icon_home_Rainbowhome_b") forState:UIControlStateHighlighted];
    [contentView insertSubview:rainbowhomeBtn belowSubview:shoppingBtn];
    [rainbowhomeBtn sdc_horizontallyCenterInSuperviewWithOffset:-(CGWidthMake(23.5) + CGWidthMake(96)/2)];
    [rainbowhomeBtn sdc_alignEdgesWithSuperview:UIRectEdgeTop insets:UIEdgeInsetsMake(CGHeightMake(71), 0, 0, 0)];
    [rainbowhomeBtn sdc_pinSize:CGSizeMake1(96, 140)];
    
    
    UIView *line = [Common generateViewWithBackgroundColor:RGBA(214, 214, 214, 0.7)];
    [self addSubview:line];
    [line sdc_pinSize:CGSizeMake(1, CGHeightMake(44.5))];
    [line sdc_horizontallyCenterInSuperview];
    [line sdc_alignEdgesWithSuperview:UIRectEdgeBottom insets:UIEdgeInsetsMake(0, 0, -76, 0)];
    
    UIButton *messageBtn = [Common generateButtonWithTarget:self action:@selector(messageBtnPress)];
    [messageBtn setImage:IMAGE(@"icon_home_message_a") forState:UIControlStateNormal];
    [messageBtn setImage:IMAGE(@"icon_home_message_b") forState:UIControlStateHighlighted];
    [messageBtn setTitle:@"消息" forState:UIControlStateNormal];
    [messageBtn setTitleColor:RGBA(103, 103, 103, 0.8) forState:UIControlStateNormal];
    [self addSubview:messageBtn];
    [[messageBtn titleLabel] setFont:FONT(12)];
    [[messageBtn imageView] setBounds:CGRectMake1(0, 0, 37, 28)];
    [messageBtn sdc_alignEdgesWithSuperview:UIRectEdgeBottom insets:UIEdgeInsetsMake(0, 0, -76, 0)];
    [messageBtn sdc_alignHorizontalCenterWithView:rainbowhomeBtn];
    [messageBtn sdc_pinSize:CGSizeMake(88, CGHeightMake(44.5))];
    
    [messageBtn centerImageAndTitle:CGHeightMake(10)];
    
    
    UIButton *profileBtn = [Common generateButtonWithTarget:self action:@selector(profileBtnPress)];
    [profileBtn setImage:IMAGE(@"icon_home_my_a") forState:UIControlStateNormal];
    [profileBtn setImage:IMAGE(@"icon_home_my_b") forState:UIControlStateHighlighted];
    [profileBtn setTitle:@"我的" forState:UIControlStateNormal];
    [profileBtn setTitleColor:RGBA(103, 103, 103, 0.8) forState:UIControlStateNormal];
    [self addSubview:profileBtn];
    [[profileBtn titleLabel] setFont:FONT(12)];
    [[profileBtn imageView] setFrame:CGRectMake1(0, 0, 37, 28)];
    [profileBtn sdc_alignEdgesWithSuperview:UIRectEdgeBottom insets:UIEdgeInsetsMake(0, 0, -76, 0)];
    [profileBtn sdc_alignHorizontalCenterWithView:couponBtn];
    [profileBtn sdc_pinSize:CGSizeMake(88, CGHeightMake(44.5))];
    
    [profileBtn centerImageAndTitle:CGHeightMake(10)];
    
    
    UILabel *footerLabel = [Common generateLabelWithText:@"天虹官方APP" textAlignment:NSTextAlignmentCenter font:FONT(16) textColor:RGBA(48, 48, 48, 0.6)];
    [self addSubview:footerLabel];
    [footerLabel sdc_horizontallyCenterInSuperview];
    [footerLabel sdc_alignEdgesWithSuperview:UIRectEdgeBottom insets:UIEdgeInsetsMake(0, 0, CGHeightMake(-25), 0)];
}

- (void)setupSubviews {
    [self setupLogoView];
    [self setupContentView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - btn press actions
- (void)shoppingBtnPress {
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeViewShopping)]) {
        [self.delegate homeViewShopping];
    }
}

- (void)couponBtnPress {
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeViewCoupon)]) {
        [self.delegate homeViewCoupon];
    }
}

- (void)rainbowhomeBtnPress {
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeViewRainbowhome)]) {
        [self.delegate homeViewRainbowhome];
    }
}

- (void)messageBtnPress {
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeViewMessage)]) {
        [self.delegate homeViewMessage];
    }
}

- (void)profileBtnPress {
    if (self.delegate && [self.delegate respondsToSelector:@selector(homeViewProfile)]) {
        [self.delegate homeViewProfile];
    }
}

@end
