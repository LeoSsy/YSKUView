//
//  ViewController.m
//  YSKUView
//
//  Created by shusy on 2017/11/22.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import "ViewController.h"
#import "YSKUView.h"


@interface ViewController ()<YSKUViewDelegate>
@property(nonatomic,strong)   YSKUView *sku;
@property(nonatomic,strong)   UILabel *lastL;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    YSKUView *sku = [[YSKUView alloc] init];
    sku.delegate = self;
    self.sku = sku;
    [sku reloadData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.sku show];
}

#pragma mark YSKUViewDelegate
- (void)configScrollViewData:(UIScrollView *)scrollView contentW:(CGFloat)contentW numViewH:(CGFloat)numViewH {
    //计算每一个lael的尺寸
    CGFloat titleHMargin = 20; //标题横向间距
    CGFloat titleVMargin = 15;//标题垂直间距
    NSUInteger rowCount = 10;
    UILabel *lastLael = nil;
    CGFloat titleH = 30;
    NSArray *titles = @[@"九体粉20盒装",@"米糊粉20盒装",@"fdsfs是咖啡店",@"发第三方是的"];
    UILabel *section1 = [[UILabel alloc] init];
    section1.text = @"类型";
    section1.font = [UIFont systemFontOfSize:12];
    section1.textColor = [UIColor blackColor];
    [scrollView addSubview:section1];
    section1.frame = CGRectMake(10, 0, 120, 40);
    for (int i = 0; i < titles.count ; i++) {
        //当前的标题
        NSString *title = titles[i];
        CGRect rect = CGRectZero;
        if (lastLael == nil) { //第一个
            //计算标题的宽度
            CGFloat titleW = [self textWidthWithText:title height:titleH contentW:contentW];
            rect = CGRectMake(CGRectGetMinX(section1.frame), CGRectGetMaxY(section1.frame), titleW, titleH);
        }else{
            //计算标题的宽度
            CGFloat titleW = [self textWidthWithText:title height:titleH contentW:contentW];
            //获取上一个标题的最大的x值
            CGFloat x =  CGRectGetMaxX(lastLael.frame)+titleHMargin;
            CGFloat maxX = x+titleW;
            rect = CGRectMake(x, CGRectGetMinY(lastLael.frame), titleW, titleH);
            //判断总的宽度是否大于内容的宽度
            if (maxX>contentW) { //如果大于 然后布局到下一行
                rect.origin.y = CGRectGetMaxY(lastLael.frame)+titleVMargin;
                rect.origin.x = CGRectGetMinX(section1.frame);
            }
        }
        UILabel *label = [[UILabel alloc] init];
        label.frame = rect;
        label.text = title;
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
        label.userInteractionEnabled = true;
        label.layer.cornerRadius = titleH*0.5;
        label.layer.masksToBounds = true;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
        [scrollView addSubview:label];
        lastLael = label;
    }
    
    UILabel *section2 = [[UILabel alloc] init];
    section2.text = @"颜色";
    section2.font = [UIFont systemFontOfSize:12];
    section2.textColor = [UIColor blackColor];
    [scrollView addSubview:section2];
    section2.frame = CGRectMake(10, CGRectGetMaxY(lastLael.frame), 120, 40);
    lastLael = nil;
    for (int i = 0; i < titles.count ; i++) {
        //当前的标题
        NSString *title = titles[i];
        CGRect rect = CGRectZero;
        if (lastLael == nil) { //第一个
            //计算标题的宽度
            CGFloat titleW = [self textWidthWithText:title height:titleH contentW:contentW];
            rect = CGRectMake(CGRectGetMinX(section2.frame), CGRectGetMaxY(section2.frame), titleW, titleH);
        }else{
            //计算标题的宽度
            CGFloat titleW = [self textWidthWithText:title height:titleH contentW:contentW];
            //获取上一个标题的最大的x值
            CGFloat x =  CGRectGetMaxX(lastLael.frame)+titleHMargin;
            CGFloat maxX = x+titleW;
            rect = CGRectMake(x, CGRectGetMinY(lastLael.frame), titleW, titleH);
            //判断总的宽度是否大于内容的宽度
            if (maxX>contentW) { //如果大于 然后布局到下一行
                rect.origin.y = CGRectGetMaxY(lastLael.frame)+titleVMargin;
                rect.origin.x = CGRectGetMinX(section1.frame);
            }
        }
        UILabel *label = [[UILabel alloc] init];
        label.frame = rect;
        label.text = title;
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
        label.userInteractionEnabled = true;
        label.layer.cornerRadius = titleH*0.5;
        label.layer.masksToBounds = true;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
        [scrollView addSubview:label];
        lastLael = label;
    }
    
    UILabel *section3 = [[UILabel alloc] init];
    section3.text = @"尺码";
    section3.font = [UIFont systemFontOfSize:12];
    section3.textColor = [UIColor blackColor];
    [scrollView addSubview:section3];
    section3.frame = CGRectMake(10, CGRectGetMaxY(lastLael.frame), 120, 40);
    lastLael = nil;
    for (int i = 0; i < titles.count ; i++) {
        //当前的标题
        NSString *title = titles[i];
        CGRect rect = CGRectZero;
        if (lastLael == nil) { //第一个
            //计算标题的宽度
            CGFloat titleW = [self textWidthWithText:title height:titleH contentW:contentW];
            rect = CGRectMake(CGRectGetMinX(section3.frame), CGRectGetMaxY(section3.frame), titleW, titleH);
        }else{
            //计算标题的宽度
            CGFloat titleW = [self textWidthWithText:title height:titleH contentW:contentW];
            //获取上一个标题的最大的x值
            CGFloat x =  CGRectGetMaxX(lastLael.frame)+titleHMargin;
            CGFloat maxX = x+titleW;
            rect = CGRectMake(x, CGRectGetMinY(lastLael.frame), titleW, titleH);
            //判断总的宽度是否大于内容的宽度
            if (maxX>contentW) { //如果大于 然后布局到下一行
                rect.origin.y = CGRectGetMaxY(lastLael.frame)+titleVMargin;
                rect.origin.x = CGRectGetMinX(section1.frame);
            }
        }
        UILabel *label = [[UILabel alloc] init];
        label.frame = rect;
        label.text = title;
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
        label.userInteractionEnabled = true;
        label.layer.cornerRadius = titleH*0.5;
        label.layer.masksToBounds = true;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
        [scrollView addSubview:label];
        lastLael = label;
    }
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, CGRectGetMaxY(lastLael.frame));
}

- (void)configImageView:(UIImageView *)imageView price:(UILabel *)priceL store:(UILabel *)storeL desc:(UILabel *)descL finishBtn:(UIButton *)finishBtn number:(SKUNumberView *)numberView {
    priceL.text =@"¥ 9999.99";
    storeL.text = @"库存数量 : 9999999件";
    descL.text = @"请选择你需要的产品类型规格";
    numberView.minNumber =1;
    numberView.maxNumber = 10;
    numberView.hintLabel.font = [UIFont systemFontOfSize:12];
    imageView.image = [UIImage imageNamed:@"123"];
    finishBtn.backgroundColor = YSKUColorFromRGB(0xd32f2f);
}

- (void)skuCloseBtnClicked {
    [self.sku dismiss];
}

- (void)skuFinishBtnClicked {
    [self.sku dismiss];
}

- (CGFloat)textWidthWithText:(NSString*)text height:(CGFloat)height contentW:(CGFloat)contentW {
    return [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.width+20;
}

#pragma mark event
- (void)tap:(UITapGestureRecognizer*)tap {
    if (self.lastL != nil) {
        self.lastL.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
        self.lastL.textColor = [UIColor blackColor];
    }
    UILabel *label =   (UILabel*)tap.view;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = YSKUColorFromRGB(0xd32f2f);;
    self.lastL = label;
}

@end
