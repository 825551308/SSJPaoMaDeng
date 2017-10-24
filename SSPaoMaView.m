//
//  SSPaoMaView.m
//  跑马灯demo
//
//  Created by jssName on 16/3/15.
//  Copyright © 2016年 jssName. All rights reserved.
//

#import "SSPaoMaView.h"
#import "SSPaoMaLabel.h"
#import "SSJPaoMaDengTools.h"
@implementation SSPaoMaView
//屏幕大小尺寸
#define SSPaoMaScreen_width [UIScreen mainScreen].bounds.size.width
#define SSPaoMaScreen_height [UIScreen mainScreen].bounds.size.height

/** 开始滚动 */
- (void)startBuildView{
    //创建label
    SSPaoMaLabel *contentLabel=[SSPaoMaLabel new];
    _fontSizeStr = _fontSizeStr==0?(14.0):(_fontSizeStr);
    contentLabel.font=[UIFont systemFontOfSize:_fontSizeStr];
    contentLabel.text = _txtStr;
    //    contentLabel.frame=CGRectMake(2, 2, [SSJPaoMaDengTools widthForText:contentLabel.text size:_fontSizeStr], self.frame.size.height-4);
    contentLabel.frame=CGRectMake(self.frame.size.width-[SSJPaoMaDengTools widthForText:contentLabel.text size:_fontSizeStr], 2, [SSJPaoMaDengTools widthForText:contentLabel.text size:_fontSizeStr], self.frame.size.height-4);
    
    contentLabel.textColor = _textColor==nil?([UIColor blackColor]):(_textColor);
    contentLabel.backgroundColor = _bcgColor==nil?([UIColor clearColor]):(_bcgColor);
    
    contentLabel.loopCount = _loopCount;
    if (_speed > 0) {
        contentLabel.speed = _speed;
    }
    
    [self addSubview:contentLabel];
    //    contentLabel.width = self.frame.size.width;
    
    //设置超出view部分不现实
    self.clipsToBounds=YES;
    
    //根据label字体是否超出  判断是否需要滚动
    if (_tongZhi) {
        if (_animateEndBlock) {
            contentLabel.animateEndBlock = ^(SSPaoMaLabel *label){
                _animateEndBlock(label);
            };
        }
        [contentLabel marqueeView];
    }else{
        if ([SSJPaoMaDengTools widthForText:contentLabel.text size:_fontSizeStr]>self.frame.size.width) {
            if (_animateEndBlock) {
                contentLabel.animateEndBlock = ^(SSPaoMaLabel *label){
                    _animateEndBlock(label);
                };
            }
            [contentLabel marqueeView];
            
        }
    }
    if (_whetherSelfAction) {
        /**< 添加点击self消失事件 */
        UIButton *coverButton = [UIButton new];
        coverButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [coverButton addTarget:self action:@selector(coverButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:coverButton];
    }
}

/** 加到window上 */
- (instancetype)initWithWindowCente:(float)width height:(float)height position:(PositionType)positionType{
    self = [super init];
    if (self) {
        if (width > 0 && height > 0) {
            switch (positionType) {
                case PositionTypeOfTop:
                {
                    self.frame = CGRectMake((SSPaoMaScreen_width - width)/2, 20,  width,  height);
                    [[UIApplication sharedApplication].keyWindow addSubview:self];
                }
                    break;
                case PositionTypeOfCenter:
                {
                    self.frame = CGRectMake((SSPaoMaScreen_width - width)/2, (SSPaoMaScreen_height- height)/2,  width,  height);
                    [[UIApplication sharedApplication].keyWindow addSubview:self];
                }
                    break;
                default:
                    break;
            }
            
        }
    }
    return self;
}

/** 点击即消失 */
- (void)coverButtonAction{
    [self removeFromSuperview];
}
@end
