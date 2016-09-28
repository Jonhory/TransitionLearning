//
//  TransFromAnimation.h
//  动画_test
//
//  Created by YangJingping on 16/6/28.
//  Copyright © 2016年 YangJingping. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,YJPPresentAnimationType) {
    YJPPresentAnimationPresent = 0,
    YJPPresentAnimationDismiss
};

@interface TransFromAnimation : NSObject<UIViewControllerAnimatedTransitioning>


-(instancetype)initWithAnimationType:(YJPPresentAnimationType)type;
+(instancetype)transfromWithAnimationType:(YJPPresentAnimationType)type;

@end
