//
//  YKActionSheetViewController.h
//  YKActionSheetView
//
//  Created by zhaojijin on 2016/10/8.
//  Copyright © 2016年 yinker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKActionSheetView.h"

typedef void(^YKActionSheetHiddenCompletionBlock)();

@interface YKActionSheetViewController : UIViewController

@property (nonatomic, copy) YKActionSheetClickButtonAtIndexBlock clickButtonAtIndexBlock;

@property (nonatomic, strong) NSArray *actionSheetItemArray;

- (void)hiddenWithCompletion:(YKActionSheetHiddenCompletionBlock)complectionBlock;

- (void)showInViewController:(UIViewController *)viewController;

@end
