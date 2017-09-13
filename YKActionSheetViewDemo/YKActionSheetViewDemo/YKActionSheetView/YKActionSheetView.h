//
//  YKActionSheetView.h
//  YKActionSheetView
//
//  Created by zhaojijin on 2016/9/30.
//  Copyright © 2016年 yinker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YKActionSheetClickButtonAtIndexBlock)(NSInteger index);

@interface YKActionSheetView : UIView

@property (nonatomic, copy) YKActionSheetClickButtonAtIndexBlock clickButtonAtIndexBlock;

@property (nonatomic, assign, readonly) CGFloat height;

- (void)configureUIWithWidth:(CGFloat)width actionSheetItemArray:(NSArray *)actionSheetItemArray;

@end
