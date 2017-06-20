//
//  ViewController.m
//  SingleMenuDemo
//
//  Created by lei on 2017/6/20.
//  Copyright © 2017年 lei. All rights reserved.
//

#import "ViewController.h"
#import "ZZLSingleMenuView.h"
#import "UIColor+Kit.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
static const CGFloat leftClassWidth = 80;
static const CGFloat secondClassHeight = 40;
#define Font_12 [UIFont systemFontOfSize:12]
@interface ViewController ()
@property (nonatomic,weak) ZZLSingleMenuView *firstClassMenu;
@property (nonatomic,weak) ZZLSingleMenuView *secondClassMenu;
@property (nonatomic,strong) ZZLSingleMenuView *thirdClassMenu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setClassView];
}
- (void)setClassView
{
    
    NSArray *array = @[@"123312",@"14242",@"41234124",@"42141",@"421412"];
    ZZLSingleMenuView *leftClassMenu = [[ZZLSingleMenuView alloc] initWithFrame:CGRectZero Titles:nil ScrollDirection:MenuViewScrollDirectionVertical];
    leftClassMenu.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    leftClassMenu.itemBackgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    leftClassMenu.selectItemBackgroundColor = [UIColor whiteColor];
    leftClassMenu.selectLineColor = [UIColor colorWithHexString:@"#e72a2a"];
    leftClassMenu.selectTextColor = [UIColor colorWithHexString:@"#e72a2a"];
    leftClassMenu.lineViewAlignment = MenuViewLineViewAlignmentLeft;
    leftClassMenu.textColor = [UIColor colorWithHexString:@"#333333"];
    leftClassMenu.textFont = Font_12;
    leftClassMenu.itemSize = CGSizeMake(leftClassWidth, 50);
    leftClassMenu.itemMargin = 0.5;
    leftClassMenu.titles =array;
    [leftClassMenu menuViewDidSelectItem:^(NSInteger item) {
        self.secondClassMenu.sd_layout.heightIs(secondClassHeight);
        self.thirdClassMenu.sd_layout.heightIs(0);
        //在这里得到请求数据,具体请看ZZLSingleMenuView
    }];
    
    [self.view addSubview:leftClassMenu];
    leftClassMenu.sd_layout.leftSpaceToView(self.view,0).topSpaceToView(self.view,60).bottomSpaceToView(self.view,0).widthIs(leftClassWidth);
    self.firstClassMenu = leftClassMenu;
    
    ZZLSingleMenuView *secondClassMenu = [[ZZLSingleMenuView alloc] init];
    [self.view addSubview:secondClassMenu];
    secondClassMenu.sd_layout.leftSpaceToView(leftClassMenu,1).topSpaceToView(self.view,60).rightSpaceToView(self.view,0).heightIs(0);
    secondClassMenu.titles  = array;
    secondClassMenu.selectLineColor = [UIColor colorWithHexString:@"#e72a2a"];
    secondClassMenu.textColor = [UIColor colorWithHexString:@"#333333"];
    
    [secondClassMenu menuViewDidSelectItem:^(NSInteger item) {
        
        self.thirdClassMenu.sd_layout.heightIs(secondClassHeight);
        
       
    }];
    
    
    
    
    self.secondClassMenu = secondClassMenu;
    
    self.thirdClassMenu = [[ZZLSingleMenuView alloc] init];
    [self.view addSubview:self.thirdClassMenu];
    self.thirdClassMenu.sd_layout.leftEqualToView(secondClassMenu).topSpaceToView(secondClassMenu,0).rightEqualToView(secondClassMenu).heightIs(0);
    
    self.thirdClassMenu.selectTextColor = [UIColor colorWithHexString:@"#e72a2a"];
    self.thirdClassMenu.textColor = [UIColor colorWithHexString:@"#333333"];
    self.thirdClassMenu.itemBackgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    self.thirdClassMenu.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    self.thirdClassMenu.titles = array;
    [self.thirdClassMenu menuViewDidSelectItem:^(NSInteger item) {
        
       
    }];
    
    
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
