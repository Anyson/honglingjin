//
//  HomeView.h
//  HongLingJin
//
//  Created by Anyson Chan on 15/10/10.
//  Copyright © 2015年 Anyson Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeViewDelegate <NSObject>

@optional

- (void)homeViewShopping;
- (void)homeViewCoupon;
- (void)homeViewRainbowhome;
- (void)homeViewMessage;
- (void)homeViewProfile;


@end

@interface HomeView : UIView

@property(weak,  nonatomic) id<HomeViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<HomeViewDelegate>)delegate;

@end
