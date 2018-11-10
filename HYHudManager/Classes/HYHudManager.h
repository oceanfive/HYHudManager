//
//  HYHudManager.h
//  HYHudManager
//
//  Created by ocean on 2018/11/7.
//  Copyright © 2018年 ocean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 样式
typedef NS_ENUM(NSUInteger, HYHudStyle) {
    /** 灰底黑字，默认的 */
    HYHudStyleLight,
    /** 黑底白字 */
    HYHudStyleDark,
    /** 没有背景颜色 */
    HYHudStyleClear
};

@interface HYHudManager : NSObject

#pragma mark - Text -----

#pragma mark - 居中显示

/// 默认样式，居中显示
+ (void)showText:(NSString *)text;
/// style 样式，居中显示
+ (void)showText:(NSString *)text
           style:(HYHudStyle)style;

/// 默认样式，居中显示
+ (void)showText:(NSString *)text
      detailText:(nullable NSString *)detailText;
/// style 样式，居中显示
+ (void)showText:(NSString *)text
      detailText:(nullable NSString *)detailText
           style:(HYHudStyle)style;


#pragma mark - 靠近底部显示
/// 默认样式，靠近底部显示
+ (void)showTextNearBottom:(NSString *)text;
/// style 样式，靠近底部显示
+ (void)showTextNearBottom:(NSString *)text
                     style:(HYHudStyle)style;
/// 默认样式，靠近底部显示
+ (void)showTextNearBottom:(NSString *)text
                detailText:(nullable NSString *)detailText;
/// style 样式，靠近底部显示
+ (void)showTextNearBottom:(NSString *)text
                detailText:(nullable NSString *)detailText
                     style:(HYHudStyle)style;

#pragma mark -

/**
 toast显示

 @param text 文字
 @param detailText 详情文字
 @param view 添加到的view，nil表示窗口window上
 @param style 样式
 @param verticalOffset 竖直方向上的偏移量
 @param duration 显示时间
 */
+ (void)showText:(NSString *)text
      detailText:(nullable NSString *)detailText
          atView:(nullable UIView *)view
           style:(HYHudStyle)style
  verticalOffset:(CGFloat)verticalOffset
        duration:(NSTimeInterval)duration;

#pragma mark - Image -----

/// 默认样式，图片显示，图片大小推荐 37*37
+ (void)showText:(NSString *)text
           image:(UIImage *)image;
/// style 样式，图片显示，图片大小推荐 37*37
+ (void)showText:(NSString *)text
           image:(UIImage *)image
           style:(HYHudStyle)style;

#pragma mark - Loading -----

/// 默认样式，无文字
+ (void)showLoadingToView:(UIView *)view;
/// 默认样式，text 文字
+ (void)showLoadingToView:(UIView *)view
                     text:(nullable NSString *)text;
/// style样式，text 文字
+ (void)showLoadingToView:(UIView *)view
                     text:(nullable NSString *)text
                    style:(HYHudStyle)style;
/// 隐藏loading
+ (void)hideLoading:(UIView *)view;

#pragma mark - Progress Loading -----
/// 默认样式
+ (void)showProgressLoadingToView:(UIView *)view
                         progress:(CGFloat)progress;
/// 默认样式，带有文字
+ (void)showProgressLoadingToView:(UIView *)view
                         progress:(CGFloat)progress
                             text:(nullable NSString *)text;

/**
 渐进式加载

 @param view UIView
 @param progress 进度 0-1
 @param text 文字
 @param style HYHudStyle
 */
+ (void)showProgressLoadingToView:(UIView *)view
                         progress:(CGFloat)progress
                             text:(nullable NSString *)text
                            style:(HYHudStyle)style;


#pragma mark - Custom Loading -----
/// 自定义加载动画
+ (void)showLoadingToView:(UIView *)view
                   images:(NSArray *)images;
/// 自定义加载动画
+ (void)showLoadingToView:(UIView *)view
                   images:(NSArray *)images
                    style:(HYHudStyle)style;

@end

NS_ASSUME_NONNULL_END
