//
//  LiveAggregation.h
//  JHLiveDemo
//
//  Created by JiangHao on 16/11/20.
//  Copyright © 2016年 JiangHao. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LiveAggregation : NSObject
@property (nonatomic, copy)NSString * city;//城市
@property (nonatomic, copy)NSString * name;//名字
@property (nonatomic, copy)NSArray * creator;
@property (nonatomic, assign)NSInteger online_users;//在线人数
@property(nonatomic,copy) NSString * stream_addr;//拉流地址
@property(nonatomic,copy)NSString * nick;//昵称
@property(nonatomic,copy)NSString * portrait;//封面背景
@end




