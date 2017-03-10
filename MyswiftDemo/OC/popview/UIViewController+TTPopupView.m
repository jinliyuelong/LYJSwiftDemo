//
//  UIViewController+TTPopupView.m
//  ALT399
//
//  Created by titengjiang on 15/12/10.
//  Copyright © 2015年 hand. All rights reserved.
//

#import "UIViewController+TTPopupView.h"
#import "TTPopupView.h"


#define kPopupModalAnimationDuration 0.35
#define kCustomSourceViewTag 23941
#define kCustomPopupViewTag 23942
#define kCustomBackgroundViewTag 23943
#define kCustomOverlayViewTag 23945

@interface UIViewController (TTPopupViewPrivate)
- (UIView*)topView;
- (void)presentPopupView:(UIView*)popupView;
@end


////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public

@implementation UIViewController (TTPopupView)

- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(TTPopupViewAnimation)animationType
{
    [self presentPopupView:popupViewController.view animationType:animationType];
}

- (void)dismissPopupViewControllerWithanimationType:(TTPopupViewAnimation)animationType
{
    UIView *sourceView = [self topView];
    UIView *popupView = [sourceView viewWithTag:kCustomPopupViewTag];
    UIView *overlayView = [sourceView viewWithTag:kCustomOverlayViewTag];
    
    if(animationType == TTPopupViewAnimationSlideBottomTop || animationType == TTPopupViewAnimationSlideBottomBottom || animationType == TTPopupViewAnimationSlideRightLeft) {
        [self slideViewOut:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType];
    } else {
        [self fadeViewOut:popupView sourceView:sourceView overlayView:overlayView];
    }
}

////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark View Handling

- (void)presentPopupView:(UIView*)popupView animationType:(TTPopupViewAnimation)animationType
{
    UIView *sourceView = [self topView];
    sourceView.tag = kCustomSourceViewTag;
    popupView.tag = kCustomPopupViewTag;
    
    // check if source view controller is not in destination
    if ([sourceView.subviews containsObject:popupView]) return;
    
    // customize popupView
//    popupView.layer.shadowPath = [UIBezierPath bezierPathWithRect:popupView.bounds].CGPath;
//    popupView.layer.masksToBounds = NO;
//    popupView.layer.shadowOffset = CGSizeMake(5, 5);
//    popupView.layer.shadowRadius = 5;
//    popupView.layer.shadowOpacity = 0.5;
    
    // Add semi overlay
    UIView *overlayView = [[UIView alloc] initWithFrame:sourceView.bounds];
    overlayView.tag = kCustomOverlayViewTag;
    overlayView.backgroundColor = [UIColor clearColor];
    
    // BackgroundView
     TTPopupView *backgroundView = [[TTPopupView alloc] initWithFrame:sourceView.bounds];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    backgroundView.tag = kCustomBackgroundViewTag;
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.0f;
    [overlayView addSubview:backgroundView];
    
    // Make the Background Clickable
    UIButton * dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissButton.backgroundColor = [UIColor clearColor];
    dismissButton.frame = sourceView.bounds;
    //    [overlayView addSubview:dismissButton];
    
    popupView.alpha = 0.0f;
    [overlayView addSubview:popupView];
    [sourceView addSubview:overlayView];
    
    
    
    if(animationType == TTPopupViewAnimationSlideBottomTop) {
        [dismissButton addTarget:self action:@selector(dismissPopupViewControllerWithanimationTypeSlideBottomTop) forControlEvents:UIControlEventTouchUpInside];
        [self slideViewIn:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType];
    } else if (animationType == TTPopupViewAnimationSlideRightLeft) {
        [dismissButton addTarget:self action:@selector(dismissPopupViewControllerWithanimationTypeSlideRightLeft) forControlEvents:UIControlEventTouchUpInside];
        [self slideViewIn:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType];
    } else if (animationType == TTPopupViewAnimationSlideBottomBottom) {
        [dismissButton addTarget:self action:@selector(dismissPopupViewControllerWithanimationTypeSlideBottomBottom) forControlEvents:UIControlEventTouchUpInside];
        [self slideViewIn:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType];
    } else {
        [dismissButton addTarget:self action:@selector(dismissPopupViewControllerWithanimationTypeFade) forControlEvents:UIControlEventTouchUpInside];
        [self fadeViewIn:popupView sourceView:sourceView overlayView:overlayView];
    }
}

-(UIView*)topView {
    UIViewController *recentView = self;
    
    while (recentView.parentViewController != nil) {
        recentView = recentView.parentViewController;
    }
    return recentView.view;
}

// TODO: find a better way to do this, thats horrible
- (void)dismissPopupViewControllerWithanimationTypeSlideBottomTop
{
    [self dismissPopupViewControllerWithanimationType:TTPopupViewAnimationSlideBottomTop];
}

- (void)dismissPopupViewControllerWithanimationTypeSlideBottomBottom
{
    [self dismissPopupViewControllerWithanimationType:TTPopupViewAnimationSlideBottomBottom];
}

- (void)dismissPopupViewControllerWithanimationTypeSlideRightLeft
{
    [self dismissPopupViewControllerWithanimationType:TTPopupViewAnimationSlideRightLeft];
}

- (void)dismissPopupViewControllerWithanimationTypeFade
{
    [self dismissPopupViewControllerWithanimationType:TTPopupViewAnimationFade];
}

//////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Animations

#pragma mark --- Slide

- (void)slideViewIn:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView withAnimationType:(TTPopupViewAnimation)animationType
{
    UIView *backgroundView = [overlayView viewWithTag:kCustomBackgroundViewTag];
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupStartRect;
    if(animationType == TTPopupViewAnimationSlideBottomTop || animationType == TTPopupViewAnimationSlideBottomBottom) {
        popupStartRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                    sourceSize.height,
                                    popupSize.width,
                                    popupSize.height);
    } else {
        popupStartRect = CGRectMake(sourceSize.width,
                                    (sourceSize.height - popupSize.height) / 2,
                                    popupSize.width,
                                    popupSize.height);
    }
    CGRect popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                     (sourceSize.height - popupSize.height) / 2,
                                     popupSize.width,
                                     popupSize.height);
    
    // Set starting properties
    popupView.frame = popupStartRect;
    popupView.alpha = 1.0f;
    [UIView animateWithDuration:kPopupModalAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        backgroundView.alpha = 1.0f;
        popupView.frame = popupEndRect;
    } completion:^(BOOL finished) {
    }];
}

- (void)slideViewOut:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView withAnimationType:(TTPopupViewAnimation)animationType
{
    UIView *backgroundView = [overlayView viewWithTag:kCustomBackgroundViewTag];
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupEndRect;
    if(animationType == TTPopupViewAnimationSlideBottomTop) {
        popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                  -popupSize.height,
                                  popupSize.width,
                                  popupSize.height);
    } else if(animationType == TTPopupViewAnimationSlideBottomBottom) {
        popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                  sourceSize.height,
                                  popupSize.width,
                                  popupSize.height);
    } else {
        popupEndRect = CGRectMake(-popupSize.width,
                                  popupView.frame.origin.y,
                                  popupSize.width,
                                  popupSize.height);
    }
    
    [UIView animateWithDuration:kPopupModalAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        popupView.frame = popupEndRect;
        backgroundView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [popupView removeFromSuperview];
        [overlayView removeFromSuperview];
    }];
}

#pragma mark --- Fade

- (void)fadeViewIn:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView
{
    
    
    
    [popupView layoutIfNeeded];
    
    UIView *backgroundView = [overlayView viewWithTag:kCustomBackgroundViewTag];
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                     (sourceSize.height - popupSize.height) / 2,
                                     popupSize.width,
                                     popupSize.height);
    
    
    
    // Set starting properties
    popupView.frame = popupEndRect;
    popupView.alpha = 0.0f;
    
    
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    [popupView setTransform:CGAffineTransformScale(transform, 0.3, 0.3)];
    
    [UIView animateWithDuration:0.2 animations:^{
        backgroundView.alpha = 0.4f;
        popupView.alpha = 1.0f;
        //[popupView setAlpha:0.5];
        [popupView setTransform:CGAffineTransformScale(transform, 1.1, 1.1)];
    } completion:^(BOOL finished) {
        [self bounceOutAnimationStopped:popupView];
    }];
    
    //    CGAffineTransform transform = CGAffineTransformIdentity;
//    [popupView setTransform:CGAffineTransformScale(transform, 0.3, 0.3)];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.2];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(bounceOutAnimationStopped)];
//    [popupView setAlpha:0.5];
//    [popupView setTransform:CGAffineTransformScale(transform, 1.1, 1.1)];
//    [UIView commitAnimations];
}

- (void)fadeViewOut:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView
{
    UIView *backgroundView = [overlayView viewWithTag:kCustomBackgroundViewTag];
    [UIView animateWithDuration:kPopupModalAnimationDuration animations:^{
        backgroundView.alpha = 0.0f;
        popupView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [popupView removeFromSuperview];
        [overlayView removeFromSuperview];
    }];
}

- (void)bounceOutAnimationStopped:(UIView *)popupView
{
    [UIView animateWithDuration:0.13 animations:^{
        //[popupView setAlpha:0.8];
        [popupView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9)];
    } completion:^(BOOL finished) {
        [self bounceInAnimationStopped:popupView];
    }];
}


- (void)bounceInAnimationStopped:(UIView *)popupView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.13];
    [UIView setAnimationDelegate:self];
    //[UIView setAnimationDidStopSelector:@selector(bounceNormalAnimationStopped)];
    [popupView setAlpha:1.0];
    [popupView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)];
    [UIView commitAnimations];
}


@end
