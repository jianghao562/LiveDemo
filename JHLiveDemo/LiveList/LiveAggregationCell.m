//
//  LiveAggregationCell.m
//  JHLiveDemo
//
//  Created by JiangHao on 16/11/20.
//  Copyright © 2016年 JiangHao. All rights reserved.
//

#import "LiveAggregationCell.h"
#import "LiveAggregation.h"


#import <SDWebImage/UIImageView+WebCache.h>
@interface LiveAggregationCell()
@property (nonatomic, strong) IBOutlet UIImageView * iconImage;// 用户头像

@property (nonatomic, strong) IBOutlet UILabel * nickLabel;// 昵称

@property (nonatomic, strong) IBOutlet UILabel * cityLebel;// 所在城市

@property (nonatomic, strong) IBOutlet UILabel *lookerCountLbel;// 观看人数

@property (weak, nonatomic) IBOutlet UIImageView *portraitView;//封面图


@end

@implementation LiveAggregationCell

-(void)setLiveAggregation:(LiveAggregation *)liveAggregation
{
    _liveAggregation=liveAggregation;
    
 
[self.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",liveAggregation.portrait]] placeholderImage:[UIImage imageNamed:@"default_room"]];
   
    [self clipImageView:self.iconImage];
//    self.iconImage.layer.cornerRadius=self.iconImage.frame.size.width*0.5;
//    self.iconImage.layer.masksToBounds=YES;
    
    
    self.nickLabel.text=liveAggregation.nick;
    
    self.cityLebel.text=[NSString stringWithFormat:@"%@ %@",liveAggregation.city,@">"];
    self.lookerCountLbel.text=[NSString stringWithFormat:@"%tu",liveAggregation.online_users];
    
    [self.portraitView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",liveAggregation.portrait]]];

}

////裁剪imageView
-(void)clipImageView:(UIImageView *)imageView
{
 
  //开始对imageView进行画图
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 0.0);
    //使用贝塞尔曲线画出一个圆形图
    [[UIBezierPath bezierPathWithRoundedRect:imageView.bounds cornerRadius:imageView.frame.size.width] addClip];
    [imageView drawRect:imageView.bounds];
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    //结束画图
    UIGraphicsEndImageContext();
}




//
- (void)awakeFromNib {
    [super awakeFromNib];
    
   
    
}




@end
