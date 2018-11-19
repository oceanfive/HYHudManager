//
//  HYHudManager.m
//  HYHudManager
//
//  Created by ocean on 2018/11/7.
//  Copyright © 2018年 ocean. All rights reserved.
//

#import "HYHudManager.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <SVProgressHUD/SVProgressHUD.h>

static const NSTimeInterval HYHudDefaultDuration = 3.0f;
static NSInteger HYHudDefaultStyle = HYHudStyleLight;
static NSArray *HYLoadingImages;

@implementation HYHudManager

+ (UIView *)_sharedView {
    UIWindow *window;
    window = [UIApplication sharedApplication].delegate.window;
    if (!window) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    if (!window) {
        window = [UIApplication sharedApplication].windows.lastObject;
    }
    return window;
}

#pragma mark - 居中

+ (void)showText:(NSString *)text {
    [self showText:text
             style:HYHudDefaultStyle];
}

+ (void)showText:(NSString *)text
           style:(HYHudStyle)style {
    [self showText:text
        detailText:nil
             style:style];
}

+ (void)showText:(NSString *)text
      detailText:(NSString *)detailText {
    [self showText:text
        detailText:detailText
             style:HYHudDefaultStyle];
}

+ (void)showText:(NSString *)text
      detailText:(NSString *)detailText
           style:(HYHudStyle)style {
    [self showText:text
        detailText:detailText
             style:style
    verticalOffset:0];
}

#pragma mark - 靠近底部
+ (void)showTextNearBottom:(NSString *)text {
    [self showTextNearBottom:text
                       style:HYHudDefaultStyle];
}

+ (void)showTextNearBottom:(NSString *)text
                     style:(HYHudStyle)style {
    [self showTextNearBottom:text
                  detailText:nil
                       style:style];
}

+ (void)showTextNearBottom:(NSString *)text
                detailText:(NSString *)detailText {
    [self showTextNearBottom:text
                  detailText:detailText
                       style:HYHudDefaultStyle];
}

+ (void)showTextNearBottom:(NSString *)text
                detailText:(NSString *)detailText
                     style:(HYHudStyle)style {
    
    CGFloat offset = [UIScreen mainScreen].bounds.size.height * 0.25;
    
    [self showText:text
        detailText:detailText
             style:style
    verticalOffset:offset];
}

#pragma mark - 偏移量 控制入口

+ (void)showText:(NSString *)text
      detailText:(NSString *)detailText
           style:(HYHudStyle)style
  verticalOffset:(CGFloat)verticalOffset {
    [self showText:text
        detailText:detailText
            atView:nil
             style:style
    verticalOffset:verticalOffset
          duration:HYHudDefaultDuration];
}

#pragma mark - style 控制入口

+ (void)showText:(NSString *)text
      detailText:(NSString *)detailText
          atView:(nullable UIView *)view
           style:(HYHudStyle)style
  verticalOffset:(CGFloat)verticalOffset
        duration:(NSTimeInterval)duration {

    UIColor *textColor = [self _contentColorForStyle:style];
    UIColor *backgroundColor = [self _backgroundColorForStyle:style];
    
    [self _showText:text
         detailText:detailText
             atView:view
          textColor:textColor
    backgroundColor:backgroundColor
     verticalOffset:verticalOffset
           duration:duration];
}

#pragma mark - 总的控制入口

+ (void)_showText:(NSString *)text
       detailText:(NSString *)detailText
           atView:(nullable UIView *)view
        textColor:(nullable UIColor *)textColor
  backgroundColor:(nullable UIColor *)backgroundColor
   verticalOffset:(CGFloat)verticalOffset
         duration:(NSTimeInterval)duration {
    
    if (text.length <= 0 &&
        detailText.length <= 0) {
        return;
    }
    
    if (duration <= 0) {
        return;
    }
    
    UIView *mView = view;
    if (!mView) {
        mView = [self _sharedView];
    }
    if (!mView) {
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:mView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.detailsLabel.text = detailText;
    if (textColor) hud.contentColor = textColor;
    if (backgroundColor) {
        hud.bezelView.backgroundColor = backgroundColor;
    }
    hud.offset = CGPointMake(0, verticalOffset);
    hud.userInteractionEnabled = NO; // 不会影响用户的操作
    [hud hideAnimated:YES afterDelay:duration];
}

#pragma mark - Image
+ (void)showText:(NSString *)text
           image:(UIImage *)image {
    [self showText:text
             image:image
             style:HYHudDefaultStyle];
}

+ (void)showText:(NSString *)text
           image:(UIImage *)image
           style:(HYHudStyle)style {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self _sharedView] animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    if (image) {    
        hud.customView = [[UIImageView alloc] initWithImage:image];
    }
    hud.label.text = text;
    [self _handleHUDColor:hud style:style];
    hud.userInteractionEnabled = NO; // 不会影响用户的操作
    [hud hideAnimated:YES afterDelay:HYHudDefaultDuration];
}

#pragma mark - Loading
+ (void)showLoadingToView:(UIView *)view {
    [self showLoadingToView:view
                       text:nil];
}

+ (void)showLoadingToView:(UIView *)view
                     text:(nullable NSString *)text {
    [self showLoadingToView:view
                       text:text
                      style:HYHudStyleLight];
}

+ (void)showLoadingToView:(UIView *)view
                     text:(nullable NSString *)text
                    style:(HYHudStyle)style {
    if (!view) return;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    [self _handleHUDColor:hud style:style];
}

+ (void)hideLoading:(UIView *)view {
    if (!view) return;
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    while (hud) {
        [hud hideAnimated:YES];
        hud = [MBProgressHUD HUDForView:view];
    }
}

#pragma mark - Progress Loading
+ (void)showProgressLoadingToView:(UIView *)view
                         progress:(CGFloat)progress {
    [self showProgressLoadingToView:view
                           progress:progress
                               text:nil];
}

+ (void)showProgressLoadingToView:(UIView *)view
                         progress:(CGFloat)progress
                             text:(nullable NSString *)text {
    [self showProgressLoadingToView:view
                           progress:progress
                               text:text
                              style:HYHudDefaultStyle];
}

+ (void)showProgressLoadingToView:(UIView *)view
                         progress:(CGFloat)progress
                             text:(nullable NSString *)text
                            style:(HYHudStyle)style {
    if (!view || progress > 1.0) return;
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = text;
        [self _handleHUDColor:hud style:style];
    }
    hud.progress = progress;
    if (progress >= 1.0) {
        [hud hideAnimated:YES];
    }
}

#pragma mark - Custom Loading
+ (void)showLoadingToView:(UIView *)view
                   images:(NSArray *)images {
    [self showLoadingToView:view
                     images:images];
}

+ (void)showLoadingToView:(UIView *)view
                   images:(NSArray *)images
                    style:(HYHudStyle)style {
    if (!view || images.count <= 0) {
        return;
    }
    if (HYLoadingImages.count == 0) {
        // mark : 传入的images 外部使用 static 修饰，不会存在多份，在内存只会存在一份
        HYLoadingImages = images;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    [self _handleHUDColor:hud style:style];
    
    // custom view, 使用 autolayout
    UIImageView *mImageView = [[UIImageView alloc] init];
    mImageView.backgroundColor = [UIColor clearColor];
    mImageView.contentMode = UIViewContentModeScaleAspectFit;
    [mImageView setAnimationImages:HYLoadingImages];
    mImageView.animationDuration = 1;
    mImageView.animationRepeatCount = 0;
    [mImageView startAnimating];
    hud.customView = mImageView;
    mImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 只需要 Width 和 Height 约束即可
    [mImageView addConstraint:[NSLayoutConstraint constraintWithItem:mImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:70]];
    [mImageView addConstraint:[NSLayoutConstraint constraintWithItem:mImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:70]];
}


#pragma mark - private

+ (void)_handleHUDColor:(MBProgressHUD *)hud
                  style:(HYHudStyle)style {
    if (!hud) return;
    
    UIColor *backgroundColor = [self _backgroundColorForStyle:style];
    if (backgroundColor) {
        hud.bezelView.backgroundColor = backgroundColor;
    }
    if (style == HYHudStyleClear) {
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [UIColor clearColor];
    }
    
    UIColor *textColor = [self _contentColorForStyle:style];
    if (textColor) {
        hud.label.textColor = textColor;
        hud.detailsLabel.textColor = textColor;
    }
}

+ (UIColor *)_backgroundColorForStyle:(HYHudStyle)style {
    UIColor *backgroundColor;
    switch (style) {
        case HYHudStyleLight:
        {
            
        }
            break;
            
        case HYHudStyleDark:
        {
            backgroundColor = [UIColor blackColor];
        }
            break;
            
        case HYHudStyleClear:
        {
            backgroundColor = [UIColor clearColor];
        }
            break;
            
        default:
            break;
    }
    return backgroundColor;
}

+ (UIColor *)_contentColorForStyle:(HYHudStyle)style {
    UIColor *textColor;
    switch (style) {
        case HYHudStyleLight:
        {
            
        }
            break;
            
        case HYHudStyleDark:
        {
            textColor = [UIColor whiteColor];
        }
            break;
            
        default:
            break;
    }
    return textColor;
}


@end
