//
//  YSKUView.m
//  YSKUView
//
//  Created by shusy on 2017/11/22.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import "YSKUView.h"
#import "SKUNumberView.h"
#import "NSString+SY.h"

@interface YSKUView()<UIScrollViewDelegate>
/**最下面的视图*/
@property(nonatomic,strong)UIView *innerView;
/**内容视图*/
@property(nonatomic,strong)UIView *contentView;
/**商品图片*/
@property(nonatomic,strong)UIImageView *imageView;
/**商品价格*/
@property(nonatomic,strong)UILabel *priceL;
/**商品库存*/
@property(nonatomic,strong)UILabel *storeL;
/**商品描述*/
@property(nonatomic,strong)UILabel *descL;
/**顶部分割线*/
@property(nonatomic,strong)UIView *lineView;
/**scrollView*/
@property(nonatomic,strong)UIScrollView *scrollView;
/**购买数量*/
@property(nonatomic,strong)UILabel *buyNumL;
/**底部确定按钮*/
@property(nonatomic,strong)UIButton *finishBtn;
/**SKUNumberView*/
@property(nonatomic,strong)SKUNumberView *numberView;
/**是否已经执行了动画效果*/
@property(nonatomic,assign)BOOL isAnimated ;
/**保存键盘是否已经弹起*/
@property(nonatomic,assign)BOOL isKeyboarShow ;
@end

@implementation YSKUView

@synthesize contentView = _contentView;
@synthesize imageView = _imageView;
@synthesize priceL = _priceL;
@synthesize storeL = _storeL;
@synthesize descL = _descL;
@synthesize scrollView = _scrollView;
@synthesize buyNumL = _buyNumL;
@synthesize finishBtn = _finishBtn;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

/**
 初始化
 */
- (void)setup{
    
    //是否动画属性默认是true
    self.isAnimated = true;
    
    //创建蒙版
    UIView *coverV = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    coverV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [coverV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverTap)]];
    [self addSubview:coverV];
    
    //创建界面控件
    _innerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENH, SKUWidth, SKUHeight)];
    _innerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_innerView];
    
    //底部按钮的高度
    CGFloat bottomBtnH = 45;
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SKUWidth, SKUHeight-bottomBtnH)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [_innerView addSubview:_contentView];
    
    //创建顶部商品图片
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SKUMargin, SKUMargin, 80, 80)];
    _imageView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = true;
    [_contentView addSubview:_imageView];
    
    //关闭按钮
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_contentView addSubview:closeBtn];
    CGFloat closeBtnW = 40;
    closeBtn.frame = CGRectMake(SKUWidth-closeBtnW, 0, closeBtnW, closeBtnW);

    CGFloat priceX = CGRectGetMaxX(_imageView.frame)+SKUMargin;
    CGFloat descH = 20;
    //价格
    _priceL = [[UILabel alloc] init];
    _priceL.text = @"¥ 0";
    _priceL.x = priceX;
    _priceL.y = CGRectGetMinY(_imageView.frame)+5;
    _priceL.height = descH;
    _priceL.textColor = [UIColor blackColor];
    _priceL.font = [UIFont systemFontOfSize:20];
    [_contentView addSubview:_priceL];
    
    //商品描述
    _descL = [[UILabel alloc] init];
    _descL.x = priceX;
    _descL.y = CGRectGetMaxY(_imageView.frame)-descH;
    _descL.height = descH;
    _descL.text = @"请选择规格";
    _descL.width = [self setNormalDesclW];
    _descL.numberOfLines = 0;
    _descL.textColor = [UIColor blackColor];
    _descL.font = [UIFont systemFontOfSize:12];
    [_contentView addSubview:_descL];
    
    //价格
    _storeL = [[UILabel alloc] init];
    _storeL.x = priceX;
    _storeL.y = CGRectGetMinY(_descL.frame)-descH;
    _storeL.height = descH;
    _storeL.text = @"库存 : 0件";
    _storeL.width = [_storeL.text textWidthWithHeight:descH font:12];
    _storeL.textColor = [UIColor blackColor];
    _storeL.font = [UIFont systemFontOfSize:12];
    [_contentView addSubview:_storeL];
    
   //创建scrollview
    CGFloat scrollviewY = CGRectGetMaxY(_imageView.frame)+SKUMargin;
    CGFloat scrollviewH = SKUHeight - scrollviewY - bottomBtnH;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollviewY, SKUWidth, scrollviewH)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(SKUWidth, scrollviewH+30);
    [_contentView addSubview:_scrollView];
    
    //分割线
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    _lineView.frame = CGRectMake(0, scrollviewY, _scrollView.width, 0.5);
    [_contentView addSubview:_lineView];

    //添加底部按钮
    UIButton *bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, _innerView.height-bottomBtnH, SKUWidth, bottomBtnH)];
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    bottomBtn.backgroundColor = [UIColor orangeColor];
    [bottomBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_innerView addSubview:bottomBtn];
    self.finishBtn = bottomBtn;
    
    //添加清扫手势
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swip:)];
    swip.direction = UISwipeGestureRecognizerDirectionUp|UISwipeGestureRecognizerDirectionDown;
    [_contentView addGestureRecognizer:swip];
    
    //监听键盘的弹出和消失通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 键盘相关通知
- (void)keyboardWillShow:(NSNotification*)note {
    self.isKeyboarShow = true;
    [self.scrollView setContentOffset:CGPointMake(0, CGRectGetMinY(self.numberView.frame)+SKUMargin) animated:YES];
}

- (void)keyboardWillHide:(NSNotification*)note {
    [self.scrollView setContentOffset:CGPointMake(0, -SKUMargin) animated:YES];
    //延迟设置退下属性
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isKeyboarShow = false;
    });
}

/**
 计算默认描述信息的宽度
 */
- (CGFloat)setNormalDesclW{
    CGFloat descH = 20;
    //重新计算描述信息的宽度
    CGFloat priceX = 80+2*SKUMargin;
    CGFloat desicNomalW =  SKUWidth-priceX-40;
    CGFloat descW = [_descL.text textWidthWithHeight:descH font:_descL.font.pointSize];
    if (descW>desicNomalW) {
        descW = desicNomalW;
    }
    return descW;
}

/**
 计算执行动画后描述信息的宽度
 */
- (CGFloat)setAnimatedDesclW{
    CGFloat descH = 20;
    //重新计算描述信息的宽度
    CGFloat descW = [_descL.text textWidthWithHeight:descH font:_descL.font.pointSize];
    if (descW>SKUWidth-2*SKUMargin) {
        descW = SKUWidth-2*SKUMargin;
    }
    return descW;
}

#pragma mark 重新布局界面
- (void)reloadData {
    //先删除之前所有的子控件
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //向代理获取数据
    if ([self.delegate respondsToSelector:@selector(configScrollViewData:contentW:numViewH:)]) {
        [self.delegate configScrollViewData:self.scrollView contentW:self.scrollView.width-2*SKUMargin numViewH:SKUNumberViewH];
    }
    //重新布局数量选择视图的y值为当前scrollview的contentSize的height
    CGFloat contentsizeH = self.scrollView.contentSize.height;
    //重新添加数量选择视图
    CGFloat buyNumLY = contentsizeH;
    _numberView = [[SKUNumberView alloc] initWithFrame:CGRectMake(0, buyNumLY+SKUMargin, SKUWidth, SKUNumberViewH)];
    [_scrollView addSubview:_numberView];
    //重新设置当前scrollview的contentSize的height为原来的加上numberView的高度 再加上一段间距
    CGFloat endContentSizeH = contentsizeH+SKUNumberViewH+30;
    if (endContentSizeH > self.scrollView.height) {
        self.scrollView.contentSize = CGSizeMake(0,endContentSizeH);
    }else{
        self.scrollView.contentSize = CGSizeMake(0,self.scrollView.height+30);
    }
    //设置相关控件的样式
    if ([self.delegate respondsToSelector:@selector(configImageView:price:store:desc:finishBtn:number:)]) {
        [self.delegate configImageView:self.imageView price:self.priceL store:self.storeL desc:self.descL finishBtn:self.finishBtn number:self.numberView];
        //监听到值改了之后的重新设置尺寸
        CGFloat descH = 20;
        if (self.priceL.text.length > 0 ) {
            _priceL.width = [_priceL.text textWidthWithHeight:descH font:_priceL.font.pointSize];
        }
        if (self.storeL.text.length > 0 ) {
            _storeL.width = [_storeL.text textWidthWithHeight:descH font:_storeL.font.pointSize];
        }
        if (self.descL.text.length > 0 ) {
            _descL.width = [_descL.text textWidthWithHeight:descH font:_descL.font.pointSize];
        }
    }
}

#pragma mark event -

#pragma mark 显示方法
- (void)show{
    [KeyWindow addSubview:self];
    self.frame = [UIScreen mainScreen].bounds;
    [UIView animateWithDuration:0.25 animations:^{
        _innerView.y = SCREENH - SKUHeight;
    }];
}

#pragma mark 消失方法
- (void)dismiss{
    [UIView animateWithDuration:0.25 animations:^{
        _innerView.y = SCREENH;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/**
 执行动画
 */
- (void)startAnimation{
    self.isAnimated = true;
    CGFloat imageW = SKUWidth*0.65;
    CGFloat imageMargin = (SKUWidth-imageW)*0.5;
    CGFloat bottomBtnH = 45;
    [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        //商品图片
        _imageView.frame =  CGRectMake(imageMargin, 3*SKUMargin, imageW, imageW);
        //价格
        _priceL.font = [UIFont systemFontOfSize:15];
        _priceL.y = CGRectGetMaxY(_imageView.frame)+SKUMargin;
        _priceL.centerX = self.centerX;
        //库存
        _storeL.y = CGRectGetMaxY(_priceL.frame);
        _storeL.centerX = self.centerX;
        //商品描述
         _descL.y = CGRectGetMaxY(_storeL.frame);
         _descL.width =  [self setAnimatedDesclW];
        _descL.centerX = self.centerX;
        //创建scrollview
        CGFloat scrollviewY = CGRectGetMaxY(_descL.frame)+SKUMargin;
        CGFloat scrollviewH = SKUHeight - scrollviewY - bottomBtnH;
        _scrollView.frame = CGRectMake(0, scrollviewY, SKUWidth, scrollviewH);
        //分割线
        _lineView.y = scrollviewY;
    } completion:^(BOOL finished) {}];
}

/**
 结束动画
 */
- (void)resentFrame{
    self.isAnimated = false;
    CGFloat descH = 20;
    CGFloat bottomBtnH = 45;
    [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        //商品图片
        _imageView.frame = CGRectMake(SKUMargin, SKUMargin, 80, 80);
        //分割线
        _lineView.y = CGRectGetMaxY(_imageView.frame)+SKUMargin;
        CGFloat priceX = CGRectGetMaxX(_imageView.frame)+SKUMargin;
        //价格
        _priceL.frame =CGRectMake(priceX,CGRectGetMinY(_imageView.frame)+5,_priceL.width, descH);
        _priceL.font = [UIFont systemFontOfSize:20];
        //商品描述
        //重新计算描述信息的宽度
        _descL.frame = CGRectMake(priceX, CGRectGetMaxY(_imageView.frame)-descH,  [self setNormalDesclW], descH);
        //价格
        _storeL.frame = CGRectMake(priceX, CGRectGetMinY(_descL.frame)-descH, _storeL.width, 20);
        //创建scrollview
        CGFloat scrollviewY = CGRectGetMaxY(_imageView.frame)+SKUMargin;
        CGFloat scrollviewH = SKUHeight - scrollviewY - bottomBtnH;
        _scrollView.frame = CGRectMake(0, scrollviewY, SKUWidth, scrollviewH);
    } completion:^(BOOL finished) {}];
}

/**
 蒙版的点击
 */
- (void)coverTap{
    [self dismiss];
}

/**
 关闭按钮点击
 */
- (void)closeBtnClick{
    if ([self.delegate respondsToSelector:@selector(skuCloseBtnClicked)]) {
        [self.delegate skuCloseBtnClicked];
    }
}

/**
 确定按钮点击
 */
- (void)bottomBtnClick{
    if ([self.delegate respondsToSelector:@selector(skuFinishBtnClicked)]) {
        [self.delegate skuFinishBtnClicked];
    }
}

#pragma mark swip
- (void)swip:(UISwipeGestureRecognizer*)swip {
    [self endEditing:YES];
    //往下滑动 执行动画
    if (self.isAnimated) { //如果已经动画了 就恢复动画
        [self resentFrame];
    }else{
        [self startAnimation];
    }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //键盘退下也会执行此方法 此时不需要执行动画
    if (self.isKeyboarShow) { return; }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0 ) { //小于0 表示用户往下拖拽
        //如果已经执行过动画 就不需要重新执行
        [self startAnimation];
    }
}

@end

@implementation UIView (SY)

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size
{
    return self.frame.size;
}
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width
{
    return self.frame.size.width;
}
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x
{
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

@end
