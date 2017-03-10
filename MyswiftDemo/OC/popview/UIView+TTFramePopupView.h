//
//  UIViewController+TTFramePopupView.h
//  ALT399
//
//  Created by titengjiang on 15/12/10.
//  Copyright © 2015年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    TTFramePopupViewSlideTopBottom = 1,
    TTFramePopupViewSlideBottomTop=2,
    TTFramePopupViewAnimationSlideRightLeft,
    TTFramePopupViewAnimationFade
}  TTFramePopupViewAnimation ;


@interface UIView (TTFramePopupView)


- (void)ttPresentFramePopupView:(UIView*)popupView animationType:(TTFramePopupViewAnimation)animationType dismissed:(void(^)(void))dismissed;


- (void)ttDismissPopupViewControllerWithanimationType:(TTFramePopupViewAnimation)animationType;

@end
