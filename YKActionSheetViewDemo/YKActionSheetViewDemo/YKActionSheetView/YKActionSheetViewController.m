//
//  YKActionSheetViewController.m
//  YKActionSheetView
//
//  Created by zhaojijin on 2016/10/8.
//  Copyright © 2016年 yinker. All rights reserved.
//

#import "YKActionSheetViewController.h"

@interface YKActionSheetViewController ()

@property (nonatomic, strong) IBOutlet YKActionSheetView * actionSheetView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint * actionSheetViewHeightConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint * actionSheetViewBottomConstraint;
@property (nonatomic, strong) IBOutlet UIButton * backgroundButton;

@end

static const CGFloat animationInterval = 0.3;

@implementation YKActionSheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleActionSheetDataAndSelectedEvent];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIView animateWithDuration:animationInterval animations:^{
        self.actionSheetViewBottomConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - IBAction

- (IBAction)buttonClickAction:(id)sender {
    [self handleSelectedEvent:(self.actionSheetItemArray.count - 1)];
}

#pragma mark - Events

- (void)hiddenWithCompletion:(YKActionSheetHiddenCompletionBlock)complectionBlock {
    [UIView animateWithDuration:animationInterval animations:^{
        self.actionSheetViewBottomConstraint.constant = -self.actionSheetView.height;
        self.backgroundButton.alpha = 0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromParentViewController];
        [self.view removeFromSuperview];
        if (complectionBlock) {
            complectionBlock();
        }
    }];
}

- (void)handleActionSheetDataAndSelectedEvent {
    if (!self.actionSheetItemArray.count) {
        return;
    }
    [self.actionSheetView configureUIWithWidth:[UIScreen mainScreen].bounds.size.width actionSheetItemArray:self.actionSheetItemArray];
    self.actionSheetViewHeightConstraint.constant = self.actionSheetView.height;
    self.actionSheetViewBottomConstraint.constant = -self.actionSheetView.height;
    [self.view layoutIfNeeded];
    __weak typeof(self) weakSelf = self;
    self.actionSheetView.clickButtonAtIndexBlock = ^(NSInteger index){
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf handleSelectedEvent:index];
        }
    };
}

- (void)handleSelectedEvent:(NSInteger)index {
    if (self.clickButtonAtIndexBlock) {
        self.clickButtonAtIndexBlock(index);
    }
}

- (void)showInViewController:(UIViewController *)viewController {
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
    self.view.frame = viewController.view.frame;
    [self didMoveToParentViewController:viewController];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
