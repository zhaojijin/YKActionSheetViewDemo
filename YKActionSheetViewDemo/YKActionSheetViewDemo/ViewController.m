//
//  ViewController.m
//  YKActionSheetViewDemo
//
//  Created by zhaojijin on 2016/12/6.
//  Copyright © 2016年 yinker. All rights reserved.
//

#import "ViewController.h"
#import "YKActionSheetViewMgr.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSArray *)titleArray {
    if (nil == _titleArray) {
        _titleArray = @[@"设置",@"说明",@"查看",@"取消"];
    }
    return _titleArray;
}

- (IBAction)action:(id)sender {
    __weak typeof(self) weakSelf = self;
    NSMutableArray *titleArrayM = [NSMutableArray array];
    for (NSInteger i = 0; i < self.titleArray.count; i++) {
        YKActionSheetItem *actionSheetItem = [[YKActionSheetItem alloc] init];
        actionSheetItem.title = self.titleArray[i];
        if (i == 1) {
            actionSheetItem.newIdentifierShowType = YKShowTypeShow;
        } else {
            actionSheetItem.newIdentifierShowType = YKShowTypeHidden;
        }
        [titleArrayM addObject:actionSheetItem];
    }
    [YKActionSheetViewMgr showActionSheetViewInViewController:self actionSheetItemArray:titleArrayM clickButtonAtIndexBlock:^(NSInteger index) {
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf handleClickEvent:index];
        }
    }];
}

- (void)handleClickEvent:(NSInteger)index {
    [YKActionSheetViewMgr hiddenActionSheetViewControllerCompletion:^{
    }];
    if (index < self.titleArray.count) {
        NSLog(@"click:%@",self.titleArray[index]);
    }
    switch (index) {
        case 0:
//            action
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
