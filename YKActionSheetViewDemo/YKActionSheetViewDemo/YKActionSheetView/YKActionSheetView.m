//
//  YKActionSheetView.m
//  YKActionSheetView
//
//  Created by zhaojijin on 2016/9/30.
//  Copyright © 2016年 yinker. All rights reserved.
//

#import "YKActionSheetView.h"
#import "YKActionSheetItem.h"

@interface YKActionSheetView ()

@property (nonatomic, assign, readwrite) CGFloat height;

@end

static const CGFloat itemHieghtDefault = 50;
static const CGFloat lineHieghtDefault = 1;
static const NSInteger buttonBasicTag = 161008; // 16年10月8号
static const NSInteger imageViewBasicTag = 170828;

@implementation YKActionSheetView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)configureUIWithWidth:(CGFloat)width actionSheetItemArray:(NSArray *)actionSheetItemArray {
    self.height = 0;
    for (NSInteger i = 0; i < actionSheetItemArray.count; i++) {
        CGFloat orgX = 0;
        CGFloat orgY = (itemHieghtDefault+lineHieghtDefault) * i;
        YKActionSheetItem * item = actionSheetItemArray[i];
        if (i == actionSheetItemArray.count - 1) {
            UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(orgX, orgY - lineHieghtDefault, width, 4)];
            lineView.backgroundColor = [self colorWithValue:0xfff0f0f0];
            [self addSubview:lineView];
            [self configureButtonWithItem:item rect:CGRectMake(orgX, CGRectGetMaxY(lineView.frame), width, itemHieghtDefault) tag:i];
            self.height += (4 + itemHieghtDefault);
        } else {
            CGRect rect = CGRectMake(orgX, orgY, width, itemHieghtDefault);
            [self configureButtonWithItem:item rect:rect tag:i];
            self.height += itemHieghtDefault;
            CGRect lineRect = CGRectMake(orgX, orgY+itemHieghtDefault, width, lineHieghtDefault);
            [self configureImageViewWithRect:lineRect];
            self.height += lineHieghtDefault;
        }
    }
}

- (void)configureButtonWithItem:(YKActionSheetItem *)item rect:(CGRect)rect tag:(NSInteger)tag {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [self colorWithValue:0xff373737];
    titleLabel.text = item.title;
    [titleLabel sizeToFit];
    titleLabel.center = CGPointMake(rect.size.width/2, rect.origin.y + rect.size.height/2);
    [self addSubview:titleLabel];
    
    if (YKShowTypeShow == item.newIdentifierShowType) {
        UIImage *newImage = [UIImage imageNamed:@"icon_new"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame)+2, rect.origin.y + 12, newImage.size.width, newImage.size.height)];
        imageView.image = newImage;
        imageView.tag = tag + imageViewBasicTag;
        [self addSubview:imageView];
    }
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    button.tag = tag + buttonBasicTag;
    [button setBackgroundImage:[UIImage imageNamed:@"button_dot"] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"button_dot"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(handleButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (void)configureImageViewWithRect:(CGRect)rect {
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = [UIImage imageNamed:@"line_width"];
    [self addSubview:imageView];
}

- (void)handleButtonClickAction:(UIButton *)button {
    NSInteger tag = button.tag - buttonBasicTag;
    NSInteger imageViewTag = tag + imageViewBasicTag;
    UIImageView *imageView = [self viewWithTag:imageViewTag];
    imageView.hidden = YES;
    if (self.clickButtonAtIndexBlock) {
        self.clickButtonAtIndexBlock(tag);
    }
}

- (UIColor *)colorWithValue:(NSUInteger)colorValue {
    
    CGFloat red = ((colorValue & 0x00FF0000) >> 16) / 255.0;
    
    CGFloat green = ((colorValue & 0x0000FF00) >> 8) / 255.0;
    
    CGFloat blue = (colorValue & 0x000000FF) / 255.0;
    
    CGFloat alpha = ((colorValue & 0xFF000000) >> 24) / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
