//
//  NSString+SY.h
//  YSKUView
//
//  Created by shusy on 2017/11/23.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (SY)

/**
 计算文字的宽度
 @param height 高度
 @param font 字体
 @return 文本实际的宽度
 */
- (CGFloat)textWidthWithHeight:(CGFloat)height font:(CGFloat)font;
@end
