//
//  SKUNumberView.h
//  YSKUView
//
//  Created by shusy on 2017/11/22.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKUNumberView : UIView
/**最小的购买数量*/
@property (nonatomic, assign) NSInteger minNumber;
/**最大的购买数量*/
@property (nonatomic, assign) NSInteger maxNumber;
/**默认文本框显示的值*/
@property (nonatomic, assign) NSInteger currentValue;
/**提示文字 默认为：购买数量*/
@property (nonatomic, strong,readonly) UILabel   *hintLabel;
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
