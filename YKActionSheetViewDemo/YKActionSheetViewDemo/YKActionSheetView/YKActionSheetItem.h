//
//  YKActionSheetItem.h
//  SimpleFinance
//
//  Created by zhaojijin on 2017/8/28.
//  Copyright © 2017年 yinker. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YKShowType) {
    YKShowTypeUnknown,
    YKShowTypeShow,
    YKShowTypeHidden,
};

@interface YKActionSheetItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) YKShowType newIdentifierShowType;

@end
