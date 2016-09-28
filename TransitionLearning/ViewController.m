//
//  ViewController.m
//  TransitionLearning
//
//  Created by rhcf_wujh on 16/9/28.
//  Copyright © 2016年 wjh. All rights reserved.
//

#import "ViewController.h"
#import "SecondVC.h"

#import "TransFromAnimation.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate>

@property (nonatomic ,weak) UITableView * tableView;

@property (nonatomic ,assign) NSInteger lastIndexRow;

@end

@implementation ViewController

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        
        _tableView = tableView;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Fisrt VC";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"NO.%zi",indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"icon1"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row > 9) {
        [self presentVC:cell.imageView type:@"vv"];
    }else {
        [self presentVC:cell.imageView type:nil];
    }

//    switch (indexPath.row) {
//        case 0:
//            [self presentVC:cell.imageView];
//            break;
//            
//        default:
//            break;
//    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%zi",self.lastIndexRow);
    if (self.lastIndexRow < indexPath.row) {
        NSLog(@"向下");
        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DRotate(transform, 0, 0, 0, 1);//渐变
        transform = CATransform3DScale(transform, 1.2, 1.5, 0);//由小变大
        cell.layer.transform = transform;
        cell.layer.opacity = 0.0;
        
        [UIView animateWithDuration:0.3 animations:^{
            cell.layer.transform = CATransform3DIdentity;
            cell.layer.opacity = 1;
        }];
    }
    else if (self.lastIndexRow > indexPath.row){
        NSLog(@"向上");
    }
    
    
    self.lastIndexRow = indexPath.row;
}

- (void)presentVC:(UIImageView *)iv type:(NSString *)type{
    SecondVC * vc = [[SecondVC alloc]initWithIV:iv];
//    vc.transitioningDelegate = self;
    vc.type = type;
    [self presentViewController:vc animated:NO completion:nil];
    //[self.navigationController pushViewController:vc animated:NO];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [TransFromAnimation transfromWithAnimationType:YJPPresentAnimationPresent];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [TransFromAnimation transfromWithAnimationType:YJPPresentAnimationDismiss];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
