//
//  SwitchView.h
//  Client
//
//  Created by 张鹏 on 2018/12/26.
//  Copyright © 2018 c4ibD3. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SwitchView;
NS_ASSUME_NONNULL_BEGIN
@protocol  SwitchViewDelegate <NSObject>

- (void)switchView_didChangeValue:(SwitchView *)zpswitch value:(BOOL)value;

@end

@interface SwitchView : UIView

@property (nonatomic, assign) BOOL on;

@property (nonatomic, weak) id<SwitchViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
