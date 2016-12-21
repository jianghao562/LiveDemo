//
//  JHNavViewController.m
//  JHLiveDemo
//
//  Created by JiangHao on 16/11/20.
//  Copyright © 2016年 JiangHao. All rights reserved.
//

#import "JHNavViewController.h"

@interface JHNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation JHNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] init];
    pan.delegate=self;
    #pragma clang diagnostic ignored "-Wundeclared-selector"
    [pan addTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled=NO;
    
    
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.viewControllers.count>1;
}


@end
