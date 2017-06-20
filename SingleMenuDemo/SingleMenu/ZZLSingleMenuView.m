//
//  ZZLSingleMenuView.m
//  SingleMenuDemo
//
//  Created by lei on 2017/6/20.
//  Copyright © 2017年 lei. All rights reserved.
//

#import "ZZLSingleMenuView.h"

@interface ZZLSingleMenuView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) SelectItemBlock selectItemBlock;
@property (nonatomic) MenuViewScrollDirection scrollDirection;
@end

@implementation ZZLSingleMenuView

- (instancetype)init
{
    self = [self initWithFrame:CGRectZero Titles:nil ScrollDirection:MenuScrollDirectionHorizontal];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)titles ScrollDirection:(MenuViewScrollDirection)scrollDirection
{
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = (UICollectionViewScrollDirection)scrollDirection;
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.textFont = [UIFont systemFontOfSize:14];
        _titles = titles;
        self.dataSource = self;
        self.delegate   = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[MenuViewCell class] forCellWithReuseIdentifier:@"MenuViewCell"];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        //        self.bounces = NO;
        //        self.defaultSelectItem = 0;
        _lineHeightOrWidth = 1;
        _scrollDirection = scrollDirection;
        
        if (_scrollDirection == MenuViewScrollDirectionVertical) {
            _selectScrollPosition = MenuViewScrollPositionCenteredVertically;
        }else{
            _selectScrollPosition = MenuViewScrollPositionCenteredHorizontally;
        }
        
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titles.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MenuViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.titles[indexPath.item];
    cell.textColor = _textColor;
    cell.selectTextColor = _selectTextColor;
    cell.selectBackgroundColor = _selectItemBackgroundColor;
    cell.cellBackgroundColor = _itemBackgroundColor;
    cell.titleLabel.font = _textFont;
    cell.lineColor = _lineColor;
    cell.selectLineColor = _selectLineColor;
    cell.lineHeight = _lineHeightOrWidth;
    cell.lineViewAlignment = _lineViewAlignment;
    
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    //    if (_scrollDirection == MenuViewScrollDirectionVertical) {
    //        return 1;
    //    }
    return self.itemMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    //    if (_scrollDirection == MenuViewScrollDirectionVertical) {
    //        return self.itemMargin;
    //    }
    return 0;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.viewInset;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_itemSize.width<=0.0&&_itemSize.height<=0.0) {
        NSString *str = self.titles[indexPath.item];
        
        NSDictionary *attri = @{NSFontAttributeName:self.textFont};
        
        NSInteger itemWidth = [str boundingRectWithSize:CGSizeMake(self.frame.size.width, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil].size.width+20;
        
        if (itemWidth<_itemMinWidth&&_itemMinWidth>0) {
            itemWidth = _itemMinWidth;
        }else if (itemWidth>_itemMaxWidth&&_itemMaxWidth>0){
            itemWidth = _itemMaxWidth;
        }
        
        if (_scrollDirection == MenuViewScrollDirectionVertical) {
            return CGSizeMake(self.frame.size.width,50);
        }
        
        return CGSizeMake(itemWidth, self.frame.size.height);
    }
    return _itemSize;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _defaultSelectItem = indexPath.item;
    
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPosition)_selectScrollPosition animated:YES];
    
    
    if (_selectItemBlock) {
        _selectItemBlock(indexPath.item);
    }
}

- (void)menuViewDidSelectItem:(SelectItemBlock)selectItemBlock
{
    _selectItemBlock = selectItemBlock;
}

- (void)selectItem:(NSInteger)item
{
    _defaultSelectItem = item;
    
    if (item<self.titles.count) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        [UIView performWithoutAnimation:^{
            [self reloadItemsAtIndexPaths:@[indexPath]];
        }];
        
        [self selectItemAtIndexPath:indexPath animated:YES scrollPosition:(UICollectionViewScrollPosition)_selectScrollPosition];
        [self collectionView:self didSelectItemAtIndexPath:indexPath];
    }
    
}


- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    [self reloadData];
}


@end



@implementation MenuViewCell



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeRightMargin relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeBottomMargin relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _lineView = [[UIView alloc] init];
        [self.contentView addSubview:_lineView];
        
        _lineView.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.backgroundColor = self.cellBackgroundColor;
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    if (selected) {
        _titleLabel.textColor = self.selectTextColor;
        self.backgroundColor = _selectBackgroundColor;
        _lineView.backgroundColor = _selectLineColor;
        
    }else{
        _titleLabel.textColor = self.textColor;
        self.backgroundColor = self.cellBackgroundColor;
        _lineView.backgroundColor = _lineColor;
    }
    
}

- (void)setCellBackgroundColor:(UIColor *)cellBackgroundColor
{
    _cellBackgroundColor = cellBackgroundColor;
    if (!self.selected) {
        self.backgroundColor = cellBackgroundColor;
    }
}


- (void)setSelectLineColor:(UIColor *)selectLineColor
{
    _selectLineColor = selectLineColor;
    if (self.selected) {
        _lineView.backgroundColor = selectLineColor;
    }
}

//- (void)setLineHeight:(CGFloat)lineHeight
//{
//    _lineHeight = lineHeight;
//    CGRect frame = _lineView.frame;
//    frame.origin.y = self.frame.size.height - lineHeight;
//    frame.size.height = lineHeight;
//    _lineView.frame = frame;
//}


- (void)setLineViewAlignment:(MenuViewLineViewAlignment)lineViewAlignment
{
    _lineViewAlignment = lineViewAlignment;
    
    
    if (lineViewAlignment==MenuViewScrollPositionTop) {
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:_lineHeight]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        
        
    }else if (lineViewAlignment==MenuViewLineViewAlignmentLeft){
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:_lineHeight]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        
        
        
    }else if (lineViewAlignment==MenuViewLineViewAlignmentRight){
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:_lineHeight]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        
        
        
    }else if (lineViewAlignment==MenuViewLineViewAlignmentBottom){
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:_lineHeight]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        
        
        
        
        
    }
    
}


@end

