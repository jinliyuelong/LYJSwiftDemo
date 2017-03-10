//
//  UIViewController+TTPopupView.h
//  ALT399
//
//  Created by titengjiang on 15/12/10.
//  Copyright © 2015年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TTPopupViewAnimationSlideBottomTop = 1,
    TTPopupViewAnimationSlideRightLeft,
    TTPopupViewAnimationSlideBottomBottom,
    TTPopupViewAnimationFade
} TTPopupViewAnimation;

@interface UIViewController (TTPopupView)




- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(TTPopupViewAnimation)animationType;
- (void)dismissPopupViewControllerWithanimationType:(TTPopupViewAnimation)animationType;
- (void)presentPopupView:(UIView*)popupView animationType:(TTPopupViewAnimation)animationType;
- (void)slideViewIn:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView withAnimationType:(TTPopupViewAnimation)animationType;
- (void)slideViewOut:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView withAnimationType:(TTPopupViewAnimation)animationType;
- (void)fadeViewIn:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView;
- (void)fadeViewOut:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView;
@end
