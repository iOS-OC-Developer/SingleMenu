//
//  ZZLSingleMenuView.h
//  SingleMenuDemo
//
//  Created by lei on 2017/6/20.
//  Copyright © 2017年 lei. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 滚动方向
 */
typedef NS_ENUM(NSInteger, MenuViewScrollDirection) {
    MenuViewScrollDirectionVertical,
    MenuScrollDirectionHorizontal
};


/**
 选中线位置
 */
typedef NS_ENUM(NSInteger, MenuViewLineViewAlignment) {
    MenuViewLineViewAlignmentBottom,
    MenuViewLineViewAlignmentTop,
    MenuViewLineViewAlignmentLeft,
    MenuViewLineViewAlignmentRight
};


typedef NS_OPTIONS(NSUInteger, MenuViewScrollPosition) {
    MenuViewScrollPositionNone                 = 0,
    
    MenuViewScrollPositionTop                  = 1 << 0,
    MenuViewScrollPositionCenteredVertically   = 1 << 1,
    MenuViewScrollPositionBottom               = 1 << 2,
    
    MenuViewScrollPositionLeft                 = 1 << 3,
    MenuViewScrollPositionCenteredHorizontally = 1 << 4,
    MenuViewScrollPositionRight                = 1 << 5
};


typedef void(^SelectItemBlock)(NSInteger item);



@interface ZZLSingleMenuView : UICollectionView
NS_ASSUME_NONNULL_BEGIN

/**
 文字字体
 */
@property (nonatomic,strong) UIFont *textFont;

/**
 字体颜色
 */
@property (nonatomic,strong) UIColor *textColor;

/**
 选中的字体颜色
 */
@property (nonatomic,strong) UIColor *selectTextColor;

/**
 按钮的背景颜色
 */
@property (nonatomic,strong) UIColor *itemBackgroundColor;

/**
 选中的按钮背景颜色
 */
@property (nonatomic,strong) UIColor *selectItemBackgroundColor;

/**
 view的内边距
 */
@property (nonatomic) UIEdgeInsets viewInset;

/**
 标题数组
 */
@property (nonatomic,strong) NSArray *titles;

/**
 按钮间的距离
 */
@property (nonatomic,assign) CGFloat itemMargin;

/**
 按钮的最小宽度
 */
@property (nonatomic,assign) CGFloat itemMinWidth;

/**
 按钮的最大宽度
 */
@property (nonatomic,assign) CGFloat itemMaxWidth;

/**
 按钮大小
 */
@property (nonatomic) CGSize itemSize;


/**
 选中线位置
 */
@property (nonatomic) MenuViewLineViewAlignment lineViewAlignment;


/**
 选中Item滚动位置(默认为中间位置)
 */
@property (nonatomic) MenuViewScrollPosition selectScrollPosition;

/**
 底部线的颜色
 */
@property (nonatomic)        UIColor *lineColor;

/**
 选中的底部线的颜色
 */
@property (nonatomic)        UIColor *selectLineColor;

/**
 底部线的高度
 */
@property (nonatomic,assign) CGFloat lineHeightOrWidth;

/**
 默认选中的按钮
 */
@property (nonatomic,assign) NSInteger defaultSelectItem;

/**
 初始化
 
 @param frame  尺寸
 @param titles 标题数组
 
 @return menuView
 */
- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray * _Nullable )titles ScrollDirection:(MenuViewScrollDirection)scrollDirection;

/**
 选中某个item
 
 @param item 从0开始
 */
- (void)selectItem:(NSInteger)item;



/**
 选中按钮返回
 
 @param selectItemBlock 返回选中位置
 */
- (void)menuViewDidSelectItem:(SelectItemBlock)selectItemBlock;

NS_ASSUME_NONNULL_END

@end


@interface MenuViewCell : UICollectionViewCell
NS_ASSUME_NONNULL_BEGIN
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic)        UIColor *lineColor;
@property (nonatomic)        UIColor *selectLineColor;
//选中线的高度
@property (nonatomic,assign) CGFloat lineHeight;

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIColor *selectTextColor;
@property (nonatomic,strong) UIColor *cellBackgroundColor;
@property (nonatomic,strong) UIColor *selectBackgroundColor;
@property (nonatomic) MenuViewLineViewAlignment lineViewAlignment;

NS_ASSUME_NONNULL_END
@end

