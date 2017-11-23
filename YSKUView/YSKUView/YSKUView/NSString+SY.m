//
//  NSString+SY.m
//  YSKUView
//
//  Created by shusy on 2017/11/23.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import "NSString+SY.h"

@implementation NSString (SY)

- (CGFloat)textWidthWithHeight:(CGFloat)height font:(CGFloat)font {
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size.width;
}

@end
