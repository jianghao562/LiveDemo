//
//  ShowViewController.m
//  JHLiveDemo
//
//  Created by JiangHao on 16/11/21.
//  Copyright © 2016年 JiangHao. All rights reserved.
//

#import "showViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface ShowViewController ()
@property(nonatomic,strong)UIImageView * dimIamge;
@property(nonatomic,strong)IJKFFMoviePlayerController *ffvc;
@end

@implementation ShowViewController

//- (void)viewWillAppear:(BOOL)animated {
//    if (![self.player isPlaying]) {
//        //准备播放
//        [self.player prepareToPlay];
//    }
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 //  [self.navigationController setNavigationBarHidden:YES animated:YES];


}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLoadingView];
    
    [self laodLive];
    
    NSLog(@"%@\n%@",_liveUrl,_imageUrl);
    
    
}


//播放直播
-(void)laodLive
{
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
    // 帧速率(fps)（可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    // -vol——设置音量大小，256为标准音量 要设置成两倍音量时则输入512，依此类推
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    
    //创建播放器
    IJKFFMoviePlayerController *ffvc = [[IJKFFMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:_liveUrl] withOptions:options];
    self.ffvc = ffvc;
    ffvc.view.frame=[UIScreen mainScreen].bounds;
    ffvc.scalingMode=IJKMPMovieScalingModeAspectFill;
    [ffvc prepareToPlay];
    [self.view addSubview:ffvc.view];
    [self.view bringSubviewToFront:ffvc.view];
    
}




//背景图片
- (void)setupLoadingView
{
    self.dimIamge = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    
    [_dimIamge sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@", _imageUrl]] placeholderImage:[UIImage imageNamed:@"default_room"]];


    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = _dimIamge.bounds;
    [_dimIamge addSubview:visualEffectView];
    [self.view addSubview:_dimIamge];
    
}

//离开时切断视频
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    
//}


-(void)dealloc
{
 [self.ffvc shutdown];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
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
