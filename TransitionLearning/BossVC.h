//
//  BossVC.h
//  TransitionLearning
//
//  Created by rhcf_wujh on 16/10/9.
//  Copyright © 2016年 wjh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^backBolck)();

@interface BossVC : UIViewController

@property (nonatomic ,copy) backBolck block;

- (void)changeBigView;

@end
