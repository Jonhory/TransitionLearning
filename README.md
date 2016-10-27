写在艰苦的日子里。

# iOS伪转场动画

- 本人在[简书作者BOC](http://www.jianshu.com/users/0aa102467302/latest_articles)提供的思路下来实现一些动画效果。

- 通过modal进行转场，设置`modalTransitionStyle`为`UIModalTransitionStyleCrossDissolve`,设置`modalPresentationStyle`为`UIModalPresentationOverFullScreen`

## 图片放大缩小的效果
外部只需要传入一个外部的`UIImageView`即可
1.创建一个`UIImageView`和一个`CGRect`来保存图片信息和图片frame信息。
  使用`- (CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view;`方法来获取图片的相对位置。
2.视图将要出现时做动画效果
```
    - (void)viewWillAppear:(BOOL)animated{
        [super viewWillAppear:animated];
        [UIView animateWithDuration:AnimationTime animations:^{       
        //这里可以自由发挥了
        self.view.backgroundColor = [UIColor greenColor];self.currentIV.frame = CGRectMake(0, 0, 200, 200);   self.currentIV.center = CGPointMake(self.view.center.x, 200);
        } completion:^(BOOL finished) {
        }];
    }
```
3.返回的点击事件处理
```
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
```
4.就这样，效果就出来啦

![](http://ww3.sinaimg.cn/large/c6a1cfeagw1f96m6g44y2g20b80kcqv6.gif)

##Boss直聘动画效果
用的是截屏的方法来实现背景缩小后置的效果
1.在当前`UIViewController`用一个`UIImageView`来保存截图
```
-(UIImage *)screenImageWithSize:(CGSize )imgSize{
    UIGraphicsBeginImageContext(imgSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate; //获取app的appdelegate，便于取到当前的window用来截屏
    [app.window.layer renderInContext:context];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
```
2.在下一个VC创建一个减方法，在当前VC中使用
```
[self presentViewController:vc animated:NO completion:nil];
    
    [UIView animateWithDuration:0.3 animations:^{
    //当前VC下截图的缩小效果
        self.screenshot.bounds = CGRectMake(50, 50, SCREEN.width - 100, SCREEN.height - 100);
    } completion:^(BOOL finished) {
    //这就是减方法 =_= 动画结束时，改变背景块的frame
        [vc changeBigView];
    }];
```
3.在下一个VC返回时，当前VC的截图视图移除。
```
[weakSelf.screenshot removeFromSuperview];
```
4.这样，BOSS直聘的动画效果就出现了。

![](http://ww3.sinaimg.cn/large/c6a1cfeagw1f96nktfwdfg20bg0keh5f.gif)

###按以上思路，就可以实现一些简单常见的动画效果^0^


