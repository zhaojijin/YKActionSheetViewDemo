//
//  YKActionSheetMgr.h
//  YKActionSheetView
//
//  Created by zhaojijin on 2016/10/8.
//  Copyright © 2016年 yinker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKActionSheetViewController.h"
#import "YKActionSheetItem.h"

@interface YKActionSheetViewMgr : NSObject

/**
 数组中最后一项是取消或者退出

 @param viewController actionSheet所在的父控制器
 @param actionSheetItemArray     actionSheet中从上往下要显示的内容
 @param clickButtonAtIndexBlock  回调所选择的index
 */
+ (void)showActionSheetViewInViewController:(UIViewController *)viewController actionSheetItemArray:(NSArray <YKActionSheetItem *>*)actionSheetItemArray clickButtonAtIndexBlock:(YKActionSheetClickButtonAtIndexBlock)clickButtonAtIndexBlock;

+ (void)hiddenActionSheetViewControllerCompletion:(YKActionSheetHiddenCompletionBlock)completionBlock;

/**
 此方法不处理小红点逻辑，要想处理小红点逻辑，请自定义ActionSheetItemArray

 @param titleArray 标题数组
 @return actionSheetItemArray
 */
+ (NSMutableArray *)configActionSheetItemArray:(NSArray *)titleArray;

@end
