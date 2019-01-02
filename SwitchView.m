//
//  SwitchView.m
//  Client
//
//  Created by 张鹏 on 2018/12/26.
//  Copyright © 2018 c4ibD3. All rights reserved.
//

#import "SwitchView.h"
@interface SwitchView()

@property (nonatomic,strong) UIButton *switchButton;

@property (nonatomic,assign) BOOL isFirst;

@end

@implementation SwitchView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.isFirst = YES;
        self.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1].CGColor;
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = self.bounds.size.height / 2.0;
        self.clipsToBounds = YES;
        [self addSubview:self.switchButton];
        self.switchButton.layer.cornerRadius = self.switchButton.bounds.size.height / 2.0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(switcherButtonTouch:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (UIButton *)switchButton{
    if (!_switchButton) {
        _switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _switchButton.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
        [_switchButton setImage:[UIImage imageNamed:@"Group 8"] forState:UIControlStateNormal];
        [_switchButton setImage:[UIImage imageNamed:@"Group 2"] forState:UIControlStateSelected];
        [_switchButton addTarget:self action:@selector(switcherButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchButton;
}
- (void)switcherButtonTouch:(UIButton *)sender{
    self.on = !self.on;
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchView_didChangeValue:value:)]) {
        [self.delegate switchView_didChangeValue:self value:self.on];
    }
}
- (void)setOn:(BOOL)on{
    _on = on;
    if (_on && self.isFirst) {
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:141/255.0 blue:150/255.0 alpha:1];
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor colorWithRed:0/255.0 green:141/255.0 blue:150/255.0 alpha:1].CGColor;
        self.layer.borderWidth = 1.0f;
        self.switchButton.selected = YES;
        self.switchButton.frame = CGRectMake(self.bounds.size.width - self.bounds.size.height, 0, self.bounds.size.height, self.bounds.size.height);
        self.isFirst = NO;
    }else{
        [self animationSwitcherButton];
        self.isFirst = NO;
    }
}

- (void)animationSwitcherButton{
    if (self.on) {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            rotateAnimation.fromValue = [NSNumber numberWithFloat:-M_PI];
            rotateAnimation.toValue = [NSNumber numberWithFloat:0.0];
            rotateAnimation.duration = 0.45;
            rotateAnimation.cumulative = NO;
            [self.switchButton.layer addAnimation:rotateAnimation forKey:@"rotate"];
            
            self.backgroundColor = [UIColor colorWithRed:0/255.0 green:141/255.0 blue:150/255.0 alpha:1];
            self.layer.masksToBounds = YES;
            self.layer.borderColor = [UIColor colorWithRed:0/255.0 green:141/255.0 blue:150/255.0 alpha:1].CGColor;
            self.layer.borderWidth = 1.0f;
            
            self.switchButton.selected = YES;
            self.switchButton.frame = CGRectMake(self.bounds.size.width - self.bounds.size.height, 0, self.bounds.size.height, self.bounds.size.height);
        } completion:^(BOOL finished) {
            self.switchButton.selected = YES;
            self.switchButton.frame = CGRectMake(self.bounds.size.width - self.bounds.size.height, 0, self.bounds.size.height, self.bounds.size.height);
        }];
    }else{
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            rotateAnimation.toValue = [NSNumber numberWithFloat:-M_PI];
            rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
            rotateAnimation.duration = 0.45;
            rotateAnimation.cumulative = NO;
            [self.switchButton.layer addAnimation:rotateAnimation forKey:@"rotate"];
            self.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
            self.layer.masksToBounds = YES;
            self.layer.borderColor = [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1].CGColor;
            self.layer.borderWidth = 1.0f;
            self.switchButton.selected = NO;
            self.switchButton.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
        } completion:^(BOOL finished) {
            self.switchButton.selected = NO;
           self.switchButton.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
        }];
    }
}
@end
