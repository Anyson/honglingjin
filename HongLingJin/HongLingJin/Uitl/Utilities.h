//
//  Utilities.h
//  Face2Face
//
//  Created by Anyson Chan on 14-6-23.
//  Copyright (c) 2014年 ANY. All rights reserved.
//

#import "AppDelegate.h"

#define IS_IOS_VENSION_8 (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1)

CG_INLINE CGRect

CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)

{
    float autoSizeScaleX;
    float autoSizeScaleY;
    if(SCREEN_HEIGHT > 480){
        autoSizeScaleX = SCREEN_WIDTH/320;
        autoSizeScaleY = SCREEN_HEIGHT/568;
    }else{
        autoSizeScaleX = 1.0;
        autoSizeScaleY = 1.0;
    }
    
    CGRect rect;
    
    rect.origin.x = x * autoSizeScaleX; rect.origin.y = y * autoSizeScaleY;
    
    rect.size.width = width * autoSizeScaleX; rect.size.height = height * autoSizeScaleY;
    
    return rect;
    
}

CG_INLINE CGSize
CGSizeMake1(CGFloat width, CGFloat height) {
    CGFloat cg_width = round(width * (SCREEN_HEIGHT > 480? SCREEN_WIDTH/320 : 1.0));
    CGFloat cg_height = round(height * (SCREEN_HEIGHT > 480? SCREEN_HEIGHT/568 : 1.0));
    return CGSizeMake(cg_width, cg_height);
}

CG_INLINE CGFloat
CGWidthMake(CGFloat width) {
    CGFloat cg_width = round(width * (SCREEN_HEIGHT > 480? SCREEN_WIDTH/320 : 1.0));
    return cg_width;
}


CG_INLINE CGFloat
CGHeightMake(CGFloat height) {
    CGFloat cg_height = round(height * (SCREEN_HEIGHT > 480? SCREEN_HEIGHT/568 : 1.0));
    return cg_height;
}

//
#ifdef DEBUG

#define NSLog_INFO(xx, ...) NSLog(xx, ##__VA_ARGS__)
#define NSLog_DEBUG(xx, ...) NSLog(@"%@ %s %d: " xx, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __func__, __LINE__, ##__VA_ARGS__)

#else

#define NSLog_INFO(xx, ...)
#define NSLog_DEBUG(xx, ...)

#endif

///////////////////////////////////////////
// UIWindow Level
///////////////////////////////////////////
#define UIWindowLevelHighestPriorit UIWindowLevelStatusBar + 1

#define MAIN_BLOCK(block) dispatch_async(dispatch_get_main_queue(), block)
#define DEFAULT_BLOCK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#define STR(key) NSLocalizedString(key, @"")

@interface Utilities : NSObject

+ (float)getRihgtWidth:(float)w;
+ (float)getRihgtHeight:(float)h;

//获取时区
+ (int)getTimezone;


////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 格式化时间
////////////////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)formatTimeByYMD:(long)ftime;
+ (NSString *)formatTime:(long)ftime;


////////////////////////////////////////////////////////////////////////////////////////////////////////////
// NSData 和 NSString互换
////////////////////////////////////////////////////////////////////////////////////////////////////////////
//base64
+ (NSString *)toBase64String:(NSData *)data;
+ (NSData *)getDataWithBase64String:(NSString *)str;

//json
+ (NSData *)toJsonData:(NSDictionary *)dict;
+ (NSString *)toJsonString:(NSDictionary *)dict;
+ (NSDictionary *)getDataWithJsonData:(NSData *)data;
+ (NSDictionary *)getDataWithJsonString:(NSString *)str;

+ (CATransition *)generateViewControllerFadeInAnimationWithDelegate:(id)delegate;

////////////////////////////////////////////////////////////////////////////////////////////////////////////
// json & dict transfer
////////////////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)dict2Json:(NSDictionary *)dict;
+ (NSDictionary *)json2dict:(NSString *)json;

@end


/**
 * UIButton 方法扩展
 *
 **/
@interface UIButton (UIButtonExt)
- (void)centerImageAndTitle:(float)space;
- (void)centerImageAndTitle;
@end


