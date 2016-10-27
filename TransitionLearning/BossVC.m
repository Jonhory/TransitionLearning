//
//  BossVC.m
//  TransitionLearning
//
//  Created by rhcf_wujh on 16/10/9.
//  Copyright © 2016年 wjh. All rights reserved.
//

#import "BossVC.h"

@interface BossVC ()

@property (nonatomic ,copy) UIButton * backBtn;

@property (nonatomic ,copy) UIView * navView;

@property (nonatomic ,copy) UIView * boss_backView;

@end

#define SCREEN [UIScreen mainScreen].bounds.size
static CGFloat const AnimationTime = 0.3;

@implementation BossVC

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

- (UIView *)boss_backView{
    if (!_boss_backView) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN.width , 100)];
        view.center = CGPointMake(SCREEN.width/2, SCREEN.height/2);
        [self.view addSubview:view];
        view.backgroundColor = [UIColor greenColor];
        
        _boss_backView = view;
    }
    return _boss_backView;
}

- (instancetype)init{
    if (self == [super init]) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

- (void)changeBigView{
    [UIView animateWithDuration:AnimationTime animations:^{
        self.boss_backView.frame = CGRectMake(0, 64, SCREEN.width, SCREEN.height - 64);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navView];
    [self boss_backView];
    
    // Do any additional setup after loading the view.
}


#pragma mark - Touch Events
- (void)back{
    
    self.block();
    
    [UIView animateWithDuration:AnimationTime animations:^{
        
            self.view.center = CGPointMake(self.view.center.x, self.view.bounds.size.height*1.5);
            self.view.backgroundColor = [UIColor clearColor];
        
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
