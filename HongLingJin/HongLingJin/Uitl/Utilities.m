//
//  Utilities.m
//  Face2Face
//
//  Created by Anyson Chan on 14-6-23.
//  Copyright (c) 2014年 ANY. All rights reserved.
//

@import CoreBluetooth;
#import <CommonCrypto/CommonDigest.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#import <sys/utsname.h>
#import <sys/time.h>

#import "Utilities.h"
#import "AppDelegate.h"

#define USER_INFO_RELETE_FILE_NAME @"userInfoReletete.plist"

#define DELTA_TIME 604800 //7*24*60*60

static NSMutableDictionary *friendsChatHistoryInfoDict;

@implementation Utilities

+ (NSURL *)fileDirectory:(NSString *)fileName {
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *path = [url URLByAppendingPathComponent:fileName];
    return path;
}

+ (NSString *)filePath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:fileName];
}

+ (float)getRihgtWidth:(float)w {
    double height = ( double )[ [ UIScreen mainScreen ] bounds ].size.height;
    if (( fabs(  height - ( double )736.0f ) < DBL_EPSILON )) {
        //iphone 6 plus
        return w;
    } else if (fabs(  height - ( double )667.0f ) < DBL_EPSILON) {
        //iphone 6
        return w * 375.0f / 414.0f;
    } else if (fabs(  height - ( double )568.0f ) < DBL_EPSILON) {
        //iphone 5s/5c/5
        return w * 320.0f / 414.0f;
    }
    return w * 320.0f / 414.0f;
}

+ (float)getRihgtHeight:(float)h {
    double height = ( double )[ [ UIScreen mainScreen ] bounds ].size.height;
    if (( fabs(  height - ( double )736.0f ) < DBL_EPSILON )) {
        //iphone 6 plus
        return h;
    } else if (fabs(  height - ( double )667.0f ) < DBL_EPSILON) {
        //iphone 6
        return h * 667.0f / 736.0f;
    }
    return h * 568.0f / 736.0f;
}


+ (int)getTimezone {
    NSTimeZone *timezone = [NSTimeZone localTimeZone];
    int gmtTimezone =(int) [timezone secondsFromGMT] / 60 / 60;
    NSLog_DEBUG(@"gmtTimezone %d", gmtTimezone);
    return gmtTimezone;
}

+ (void)roundImage:(UIView *)imageView
       borderColor:(UIColor *)borderColor
       borderWidth:(float)borderWidth {
    CALayer *layer = [imageView layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:imageView.frame.size.width / 2];
    [layer setBorderWidth:borderWidth];
    [layer setBorderColor:borderColor.CGColor];
}

+ (CGSize)calcScaledSize:(CGSize)origin bound:(CGSize)size {
    if (size.width > origin.width && size.height > origin.height) {
        return origin;
    }
    
    CGSize result;
    CGFloat scaledHeight = origin.height / (origin.width / size.width);
    if (scaledHeight <= size.height) {
        result = CGSizeMake(size.width, scaledHeight);
    }
    
    CGFloat scaledWidth = origin.width / (origin.height / size.height);
    if (scaledWidth <= size.width) {
        result = CGSizeMake(scaledWidth, size.height);
    }
    
    return result;
}


//截取部分图像
+ (UIImage *)getSubImage:(CGRect)rect
                 image:(UIImage *)image {
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage *smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    return smallImage;
}

+ (UIImage *)reSizeImage:(UIImage *)image
                  toSize:(CGSize)size {
    CGFloat width = CGImageGetWidth(image.CGImage);
    CGFloat height = CGImageGetHeight(image.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (BOOL)isSameDay:(NSDate *)date1 date2:(NSDate *)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day] == [comp2 day] && [comp1 month] == [comp2 month] &&[comp1 year] == [comp2 year];
}

+ (NSString *)formatHHMMTime:(NSInteger)t {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:t];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *formatStr = [dateFormatter stringFromDate:date];
    
    return formatStr;
}

+ (UIImage *)scaleImage:(UIImage *)image
                toScale:(float)scaleSize {
    
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIImage*) grayscale:(UIImage*)anImage type:(char)type {
    CGImageRef  imageRef;
    imageRef = anImage.CGImage;
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    // ピクセルを構成するRGB各要素が何ビットで構成されている
    size_t                  bitsPerComponent;
    bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    
    // ピクセル全体は何ビットで構成されているか
    size_t                  bitsPerPixel;
    bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
    // 画像の横1ライン分のデータが、何バイトで構成されているか
    size_t                  bytesPerRow;
    bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    // 画像の色空間
    CGColorSpaceRef         colorSpace;
    colorSpace = CGImageGetColorSpace(imageRef);
    
    // 画像のBitmap情報
    CGBitmapInfo            bitmapInfo;
    bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    // 画像がピクセル間の補完をしているか
    bool                    shouldInterpolate;
    shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    // 表示装置によって補正をしているか
    CGColorRenderingIntent  intent;
    intent = CGImageGetRenderingIntent(imageRef);
    
    // 画像のデータプロバイダを取得する
    CGDataProviderRef   dataProvider;
    dataProvider = CGImageGetDataProvider(imageRef);
    
    // データプロバイダから画像のbitmap生データ取得
    CFDataRef   data;
    UInt8*      buffer;
    data = CGDataProviderCopyData(dataProvider);
    buffer = (UInt8*)CFDataGetBytePtr(data);
    
    // 1ピクセルずつ画像を処理
    NSUInteger  x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8*  tmp;
            tmp = buffer + y * bytesPerRow + x * 4; // RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす
            
            // RGB値を取得
            UInt8 red,green,blue;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            
            UInt8 brightness;
            
            switch (type) {
                case 1://モノクロ
                    // 輝度計算
                    brightness = (77 * red + 28 * green + 151 * blue) / 256;
                    
                    *(tmp + 0) = brightness;
                    *(tmp + 1) = brightness;
                    *(tmp + 2) = brightness;
                    break;
                    
                case 2://セピア
                    *(tmp + 0) = red;
                    *(tmp + 1) = green * 0.7;
                    *(tmp + 2) = blue * 0.4;
                    break;
                    
                case 3://色反転
                    *(tmp + 0) = 255 - red;
                    *(tmp + 1) = 255 - green;
                    *(tmp + 2) = 255 - blue;
                    break;
                    
                default:
                    *(tmp + 0) = red;
                    *(tmp + 1) = green;
                    *(tmp + 2) = blue;
                    break;
            }
            
        }
    }
    
    // 効果を与えたデータ生成
    CFDataRef   effectedData;
    effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
    // 効果を与えたデータプロバイダを生成
    CGDataProviderRef   effectedDataProvider;
    effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
    // 画像を生成
    CGImageRef  effectedCgImage;
    UIImage*    effectedImage;
    effectedCgImage = CGImageCreate(
                                    width, height,
                                    bitsPerComponent, bitsPerPixel, bytesPerRow,
                                    colorSpace, bitmapInfo, effectedDataProvider,
                                    NULL, shouldInterpolate, intent);
    effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    
    // データの解放
    CGImageRelease(effectedCgImage);
    CFRelease(effectedDataProvider);
    CFRelease(effectedData);
    CFRelease(data);
    
    return effectedImage;
}

+ (NSString *)formatTimeByYMD:(long)ftime {
    NSString *ret = @"";
    NSDate *contactDate = [NSDate dateWithTimeIntervalSince1970:ftime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YY年MM月d日"];
    NSString *formatStr = [dateFormatter stringFromDate:contactDate];
    ret = formatStr;
    
    return ret;
}

+ (NSString *)formatTime:(long)ftime {
    NSString *ret = @"";
    
    NSDate *nowDate = [NSDate date];
    NSDate *contactDate = [NSDate dateWithTimeIntervalSince1970:ftime];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSString *hhmm = [self formatHHMMTime:ftime];
    
    //今天
    if ([Utilities isSameDay:nowDate date2:contactDate]) {
        ret = [NSString stringWithFormat:@"%@ %@",STR(@"today"), hhmm];
        
        return ret;
    }
    
    NSDate *yesterday = [nowDate dateByAddingTimeInterval:-86400];
    
    //昨天
    if ([self isSameDay:yesterday date2:contactDate]) {
        return [NSString stringWithFormat:@"%@ %@",STR(@"yesterday"), hhmm];
    }
    
    NSCalendar *calendar;
    NSDateComponents *comps;
    
    int currenTime = (int)time(NULL);
    if (currenTime -  ftime < DELTA_TIME) {
        //周几 (相差一个星期)
        calendar = [NSCalendar currentCalendar];
        comps = [calendar components:NSWeekdayCalendarUnit fromDate:contactDate];
        NSInteger weekday = [comps weekday];
        switch (weekday) {
            case 1:
                ret = [NSString stringWithFormat:@"%@ %@",STR(@"Sun"), hhmm];
                break;
            case 2:
                ret = [NSString stringWithFormat:@"%@ %@",STR(@"Mon"), hhmm];
                break;
            case 3:
                ret = [NSString stringWithFormat:@"%@ %@",STR(@"Tue"), hhmm];
                break;
            case 4:
                ret = [NSString stringWithFormat:@"%@ %@",STR(@"Wed"), hhmm];
                break;
            case 5:
                ret = [NSString stringWithFormat:@"%@ %@",STR(@"Thu"), hhmm];
                break;
            case 6:
                ret = [NSString stringWithFormat:@"%@ %@",STR(@"Fri"), hhmm];
                break;
            case 7:
                ret = [NSString stringWithFormat:@"%@ %@",STR(@"Sat"), hhmm];
                break;
            default:
                break;
        }
        
        return ret;
    }
    
    //MM-dd (上周之前)
    comps = [calendar components:NSYearCalendarUnit fromDate:nowDate];
    NSInteger year = [comps year];
    comps = [calendar components:NSYearCalendarUnit fromDate:contactDate];
    NSInteger contactYear = [comps year];
    if (year == contactYear) {
        [dateFormatter setDateFormat:@"M-d"];
        NSString *formatStr = [NSString stringWithFormat:@"%@ %@",[dateFormatter stringFromDate:contactDate], hhmm];
        ret = formatStr;
        
        return ret;
    }
    
    //yy-MM-dd (去年之前)
    [dateFormatter setDateFormat:@"yy-M-d"];
    NSString *formatStr = [NSString stringWithFormat:@"%@ %@",[dateFormatter stringFromDate:contactDate], hhmm];;
    ret = formatStr;
    
    return ret;
}

+ (NSString *)toBase64String:(NSData *)data {
    NSString *string;
    string = [data base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
    return string;
}

+ (NSData *)getDataWithBase64String:(NSString *)str {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}

//json
+ (NSData *)toJsonData:(NSDictionary *)dict {
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    if (error) {
        NSLog_DEBUG(@"to json error :%@", error);
        return nil;
    }
    
    return data;
}

+ (NSString *)toJsonString:(NSDictionary *)dict {
    NSData *data = [self toJsonData:dict];
    return [[NSString alloc] initWithData:data
                                 encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)getDataWithJsonData:(NSData *)data {
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    if (error) {
        NSLog_DEBUG(@"JSON to dictionary error : %@", error);
        return nil;
    }
    return dict;
}

+ (NSDictionary *)getDataWithJsonString:(NSString *)str {
    return [self getDataWithJsonData:[str dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (uint64_t)getTimeInMS {
    struct timeval tv;
    struct timezone tz;
    uint64_t val;
    
    gettimeofday(&tv, &tz);
    val = (uint64_t)(tv.tv_sec * 1000) + tv.tv_usec / 1000;
    
    return val;
}

+ (unsigned long)hashpjw:(char *)arKey  nKeyLength:(unsigned int)nKeyLength {
    unsigned long h = 0, g;
    char *arEnd = arKey + nKeyLength;
    while (arKey < arEnd) {
        h = (h << 4) + *arKey++;
        if ((g = (h & 0xF0000000))) {
            h = h ^ (g >> 24);
            h = h ^ g;
        }
    }
    return h;
}

+ (CATransition *)generateViewControllerFadeInAnimationWithDelegate:(id)delegate {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.delegate = delegate;
    
    return transition;
}

+ (NSString *)dict2Json:(NSDictionary *)dict {
    NSString *ret = @"";
    if ([NSJSONSerialization isValidJSONObject:dict]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        ret =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return ret;
}

+ (NSDictionary *)json2dict:(NSString *)json {
    NSDictionary *dict = nil;
    if (json) {
        NSError *error;
        dict = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    }
    
    return dict;
}

@end


/**
 * UIButton 方法扩展
 *
 **/
@implementation UIButton (UIButtonExt)
- (void)centerImageAndTitle:(float)spacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (totalHeight - titleSize.height),0.0);
}

- (void)centerImageAndTitle
{
    const int DEFAULT_SPACING = 6.0f;
    [self centerImageAndTitle:DEFAULT_SPACING];
}
@end