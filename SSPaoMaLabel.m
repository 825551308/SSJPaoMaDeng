//
//  SSPaoMaLabel.m
//  跑马灯demo
//
//  Created by jssName on 16/3/15.
//  Copyright © 2016年 jssName. All rights reserved.
//

#import "SSPaoMaLabel.h"
#import "SSJPaoMaDengTools.h"

@implementation SSPaoMaLabel
{
    int currentCount;//记录当前已经循环了的次数  默认已经循环
    int marqueeViewCount;//记录marqueeView方法执行的次数
}
/*******Head************************跑马灯效果*****************************/
static CGRect firstFrame;
- (void)marqueeView
{
    if (marqueeViewCount == 0) {
        firstFrame = self.frame;
    }
    CGRect frame = self.frame;
    frame.origin.x = frame.origin.x -2;
    //方案一
    if(frame.origin.x<-frame.size.width){
        frame.origin.x = CGRectGetMaxX(firstFrame);
        //如果循环次数>0
        if (_loopCount >0) {
            currentCount ++;
            if (currentCount == _loopCount) {
                frame.origin.x = CGRectGetMaxX(self.frame);
                self.frame = frame;
                if (_animateEndBlock) {
                    _animateEndBlock(self);
                }
                return;
            }
        }
        
    }
    self.frame = frame;
    //方案二
    //    if(frame.origin.x<-frame.size.width){
    //        frame.origin.x = CGRectGetMaxX(self.frame);
    //        [UIView animateWithDuration:1 animations:^{
    //            self.frame = frame;
    //        }];
    //    }else{
    //        self.frame = frame;
    //    }
    marqueeViewCount ++ ;
    //延时递归调用
    [self performSelector:@selector(marqueeView) withObject:nil afterDelay:_speed==0?(0.08):(_speed)];
}
/*******End************************跑马灯效果*****************************/


@end
