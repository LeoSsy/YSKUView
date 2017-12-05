//
//  YSKUView.h
//  YSKUView
//
//  Created by shusy on 2017/11/22.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKUNumberView.h"

/**sku视图的高度*/
#define SKUHeight [UIScreen mainScreen].bounds.size.height*0.7
#define SKUWidth [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SKUMargin 15 //间距
#define SKUNumberViewH 75 //数量选择视图的高度 默认是75 高度 同时也是最小的高度，如果设置比此值下会出现按钮无法点击的问题
#define KeyWindow [UIApplication sharedApplication].windows.firstObject

@protocol YSKUViewDelegate <NSObject>

@optional
/**
 *  配置图片、价格、库存数量
 *
 *  @parames
 *  @param  imageView       图片视图
 *  @param  priceL      价格视图
 *  @param  storeL      库存视图
 *  @param  descL       描述视图
 *  @param  finishBtn   完成按钮
 *  @param  numberView   数量选择视图
 */
- (void) configImageView:(UIImageView *) imageView
                   price:(UILabel *) priceL
                   store:(UILabel *) storeL
                    desc:(UILabel *) descL
               finishBtn:(UIButton *) finishBtn
                  number:(SKUNumberView *) numberView;

/**
 *  配置滚动视图区域内的元素，在reloadData的时候会调用此方法
 *  @param  scrollView  滚动视图
 *  @param  contentW   内容视图的宽度
 *  @param  numViewH 数量选择视图的高度
 */
- (void) configScrollViewData:(UIScrollView *) scrollView contentW:(CGFloat)contentW numViewH:(CGFloat)numViewH;

/**
 * sku视图,关闭按钮点击的时候会调用此方法
 */
- (void) skuCloseBtnClicked;

/**
 * sku视图,完成按钮点击的时候会调用此方法
 */
- (void) skuFinishBtnClicked;

@end

@interface YSKUView : UIView
/**代理*/
@property(nonatomic,weak)id<YSKUViewDelegate> delegate;
/**商品图片*/
@property(nonatomic,strong,readonly)UIImageView *imageView;
/**底部确定按钮*/
@property(nonatomic,strong,readonly)UIButton *finishBtn;
/** 刷新数据 调用此方法会会执行代理方法 重新布局界面*/
- (void) reloadData;
/**设置商品价格*/
- (void)setPriceText:(NSString*)text;
/**设置商品库存*/
- (void)setStoreText:(NSString*)text;
/**设置商品描述*/
- (void)setDescText:(NSString*)text;
/**获取购买数量*/
- (NSInteger)num;
/**显示方法*/
- (void)show;
/**消失方法*/
- (void)dismiss;
@end

@interface UIView (SY)

@property(nonatomic,assign)CGSize size;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;
@end



