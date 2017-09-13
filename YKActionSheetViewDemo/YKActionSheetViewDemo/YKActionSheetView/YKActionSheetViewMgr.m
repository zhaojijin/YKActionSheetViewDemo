//
//  YKActionSheetMgr.m
//  YKActionSheetView
//
//  Created by zhaojijin on 2016/10/8.
//  Copyright © 2016年 yinker. All rights reserved.
//

#import "YKActionSheetViewMgr.h"

@interface YKActionSheetViewMgr () <UIActionSheetDelegate>

@property (nonatomic, weak) YKActionSheetViewController * actionSheetViewController;

@end

static YKActionSheetViewMgr * actionSheetViewMgr = nil;

@implementation YKActionSheetViewMgr

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        actionSheetViewMgr = [[YKActionSheetViewMgr alloc] init];
    });
    return actionSheetViewMgr;
}

+ (void)showActionSheetViewInViewController:(UIViewController *)viewController actionSheetItemArray:(NSArray <YKActionSheetItem *>*)actionSheetItemArray clickButtonAtIndexBlock:(YKActionSheetClickButtonAtIndexBlock)clickButtonAtIndexBlock {
    YKActionSheetViewController * actionSheetViewController = [[YKActionSheetViewController alloc] initWithNibName:@"YKActionSheetViewController" bundle:nil];
    actionSheetViewController.actionSheetItemArray = actionSheetItemArray;
    [YKActionSheetViewMgr sharedInstance].actionSheetViewController = actionSheetViewController;
    [actionSheetViewController showInViewController:viewController];
    actionSheetViewController.clickButtonAtIndexBlock = ^(NSInteger index){
        if (clickButtonAtIndexBlock) {
            clickButtonAtIndexBlock(index);
        }
    };
}

+ (void)hiddenActionSheetViewControllerCompletion:(YKActionSheetHiddenCompletionBlock)completionBlock {
    [[YKActionSheetViewMgr sharedInstance].actionSheetViewController hiddenWithCompletion:^{
        if (completionBlock) {
            completionBlock();
        }
    }];
}

+ (NSMutableArray *)configActionSheetItemArray:(NSArray *)titleArray {
    NSMutableArray *titleArrayM = [NSMutableArray array];
    for (NSInteger i = 0; i < titleArray.count; i++) {
        YKActionSheetItem *actionSheetItem = [[YKActionSheetItem alloc] init];
        actionSheetItem.title = titleArray[i];
        actionSheetItem.newIdentifierShowType = YKShowTypeHidden;
        [titleArrayM addObject:actionSheetItem];
    }
    return titleArrayM;
}

@end
