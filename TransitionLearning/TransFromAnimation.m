//
//  TransFromAnimation.m
//  动画_test
//
//  Created by YangJingping on 16/6/28.
//  Copyright © 2016年 YangJingping. All rights reserved.
//

#import "TransFromAnimation.h"
//#import "PresentToViewController.h"
//#import "PresentFromViewController.h"
#import "ViewController.h"
#import "SecondVC.h"

@interface TransFromAnimation ()

@property(nonatomic,assign)YJPPresentAnimationType type;

@end

@implementation TransFromAnimation

+(instancetype)transfromWithAnimationType:(YJPPresentAnimationType)type
{
    return [[self alloc]initWithAnimationType:type];
}

-(instancetype)initWithAnimationType:(YJPPresentAnimationType)type
{
    if (self = [super init]) {
        self.type=type;
    }
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (_type == YJPPresentAnimationPresent) {
        [self presentVC:transitionContext];
    }
    else if (_type == YJPPresentAnimationDismiss)
    {
        [self dismissVC:transitionContext];
    }
}


#pragma mark -
-(void)presentVC:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    //1
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    SecondVC *toVC=(SecondVC *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    //2. set vc frame
    UIView *containerView = [transitionContext containerView];

    
    toVC.view.frame = CGRectMake(0, 0, 1, containerView.frame.size.height);
    toVC.view.center = containerView.center;
    
    //规定视图必须放在container 中操作
    [containerView addSubview:toVC.view];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        toVC.view.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
        toVC.view.center = containerView.center;
    
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];

}

#pragma mark -
-(void)dismissVC:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    // 1.
    SecondVC *fromVC = (SecondVC *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    
    ViewController *toVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    // 3. Add target view to the container, and move it to back.
    UIView *containerView = [transitionContext containerView];
    
    
    //fullScreen模态状态下，即使我们自己不主动添加视图，系统也会主动添加
    //custom模式下，不要添加
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    // 4.
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromVC.view.frame = CGRectMake(0, 0, 1, containerView.frame.size.height);
        fromVC.view.center = containerView.center;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
