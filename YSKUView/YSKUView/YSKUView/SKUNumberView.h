//
//  SKUNumberView.h
//  YSKUView
//
//  Created by shusy on 2017/11/22.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKUNumberViewDelegate <NSObject>
@optional
/**
 * 数量改变的时候会调用此方法
 */
- (void) numberDidChanged:(NSInteger)num;

@end

@interface SKUNumberView : UIView
/**代理*/
@property(nonatomic,weak)id<SKUNumberViewDelegate> delegate;
/**最小的购买数量 默认为1*/
@property (nonatomic, assign) NSInteger minNumber;
/**最大的购买数量 默认为1*/
@property (nonatomic, assign) NSInteger maxNumber;
/**默认文本框显示的值*/
@property (nonatomic, assign) NSInteger currentValue;
/**提示文字 默认为：购买数量*/
@property (nonatomic, strong,readonly) UILabel   *hintLabel;
/**是否显示提示文字*/
@property (nonatomic, assign) BOOL  showHintLabel;
/**减号按钮*/
@property (nonatomic, strong,readonly) UIButton  *minusButton;
/**加号按钮*/
@property (nonatomic, strong,readonly) UIButton  *addButton;
/**文本框*/
@property (nonatomic, strong,readonly) UITextField *textField;
/**文本框上面的线条*/
@property (nonatomic, strong,readonly) UIView *topLine;
/**文本框下面的线条*/
@property (nonatomic, strong,readonly) UIView *bottomLine;
@end

