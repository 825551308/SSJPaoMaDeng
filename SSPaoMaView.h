//
//  SSPaoMaView.h
//  跑马灯demo
//
//  Created by jssName on 16/3/15.
//  Copyright © 2016年 jssName. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSPaoMaLabel;

typedef NS_ENUM(NSUInteger,PositionType){
    /** 顶部 */
    PositionTypeOfTop = 0,
    /** 中间 */
    PositionTypeOfCenter = 1,
};


@interface SSPaoMaView : UIView
@property (nonatomic , strong) NSString *txtStr;//label内容
@property (nonatomic , assign) CGFloat fontSizeStr;//字体大小

#pragma  延伸属性设置
/** label字体颜色色 */
@property (nonatomic , strong) UIColor *textColor;
/** label背景色 */
@property (nonatomic , strong) UIColor *bcgColor;
/** 循环次数   默认为无限循环 */
@property (nonatomic , assign) NSInteger loopCount ;
/** 速度:值越小 滚动速度越快 */
@property (nonatomic , assign) CGFloat speed;//滚动速度  默认为0.08

/** 是否长条形滚动--Yes:当文字长度小于SSPaoMaView宽度时也会滚动（从尾部开始） */
@property (nonatomic , assign) BOOL tongZhi;

/** 是否增加事件:点击SSPaoMaView本身就会移除 */
@property (nonatomic,assign) BOOL whetherSelfAction;


typedef void(^AnimateEndBlock)(SSPaoMaLabel *paoMaLabel);
@property (nonatomic,copy) AnimateEndBlock animateEndBlock;

#pragma  行为
/** 开始滚动 */
- (void)startBuildView;

/** 加到window上 */
- (instancetype)initWithWindowCente:(float)width height:(float)height position:(PositionType)positionType;



@end

/**     使用案例
 
 - (void)showYesterdayPayCount{
    __weak typeof(self) weakSelf = self;
     self.paoMa = [[SSPaoMaView alloc]initWithWindowCente:screen_width height:20 position:PositionTypeOfTop];
     self.paoMa.txtStr = @"您昨天一共花费了 60元!";
     self.paoMa.loopCount = 5;
     self.paoMa.backgroundColor = [UIColor grayColor];
     self.paoMa.bcgColor = [UIColor orangeColor];
     self.paoMa.tongZhi = YES;
     self.paoMa.animateEndBlock = ^(SSPaoMaLabel *paoMaLabel){
     NSLog(@"滚动结束");
     [weakSelf.paoMa removeFromSuperview];
     };
     [self.paoMa startBuildView];
 }
 */