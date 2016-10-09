//
//  SecondVC.m
//  TransitionLearning
//
//  Created by rhcf_wujh on 16/9/28.
//  Copyright © 2016年 wjh. All rights reserved.
//

#import "SecondVC.h"

@interface SecondVC ()

@property (nonatomic ,copy) UIImageView * currentIV;

@property (nonatomic ,copy) UIButton * backBtn;

@property (nonatomic ,copy) UIView * navView;

@property (nonatomic ,assign) CGRect oldFrame;
@end

static CGFloat const AnimationTime = 0.3;

@implementation SecondVC

- (instancetype)initWithIV:(UIImageView *)iv{
    self = [super init];
    if (self) {
        [self setup];
        self.oldFrame = [iv convertRect:iv.bounds toView:nil];
        self.currentIV.frame = self.oldFrame;
        self.currentIV.image = iv.image;
    }
    return self;
}

- (void)setup{
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.view.backgroundColor = [UIColor clearColor];
    
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipe];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self navView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:AnimationTime animations:^{
        self.view.backgroundColor = [UIColor greenColor];
        self.currentIV.frame = CGRectMake(0, 0, 200, 200);
        self.currentIV.center = CGPointMake(self.view.center.x, 200);
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark - Touch Events
- (void)back{
    [UIView animateWithDuration:AnimationTime animations:^{
        if ([self.type isEqualToString:@"vv"]) {
            self.view.center = CGPointMake(self.view.center.x, self.view.bounds.size.height*1.5);
        }else {
            self.currentIV.frame = self.oldFrame;
            self.view.backgroundColor = [UIColor clearColor];
        }
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    
}

- (void)swipe:(UISwipeGestureRecognizer *)recognizer{
//    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"做做做");
//    }
    [self back];
}

#pragma mark - Lazy
- (UIImageView *)currentIV{
    if (!_currentIV) {
        UIImageView * iv = [[UIImageView alloc]init];
//        iv.backgroundColor = [UIColor redColor];
        [self.view addSubview:iv];
        
        _currentIV = iv;
    }
    return _currentIV;
}

- (UIView *)navView{
    if (!_navView) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
        view.backgroundColor = [UIColor grayColor];
        [self.view addSubview:view];
        [view addSubview:self.backBtn];
        
        _navView = view;
    }
    return _navView;
}
- (UIButton *)backBtn{
    if (!_backBtn) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 34, 34)];
        btn.backgroundColor = [UIColor purpleColor];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        _backBtn = btn;
    }
    return _backBtn;
}


- (void)dealloc{
    NSLog(@"dealloc:%@",self);
}

@end
