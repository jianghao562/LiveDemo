//
//  LiveStartViewController.m
//  JHLiveDemo
//
//  Created by JiangHao on 16/11/20.
//  Copyright © 2016年 JiangHao. All rights reserved.
//

#import "LiveStartViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <LFLiveKit.h>
@interface LiveStartViewController ()
@property (nonatomic, strong) UIView *preView;
@property (nonatomic, strong) LFLiveSession *session;
@end

@implementation LiveStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupVideoAuth];
    [self  loadLiveView];
    
   
}

//设置视频权限

-(void)setupVideoAuth
{
//视频授予
    AVAuthorizationStatus videoStatus=[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];

    switch (videoStatus) {
        case AVAuthorizationStatusNotDetermined:
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    
                }
            }];
            break;
            //已授权
          case AVAuthorizationStatusAuthorized:
            break;
            
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            //用户明确拒绝授权
            break;
    }
    
    
  //音频授权
     AVAuthorizationStatus audioStatus=[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    
    switch (audioStatus) {
        case AVAuthorizationStatusNotDetermined:{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //  [_self.session setRunning:YES];
                    });
                }
                
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized:{
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            break;
        default:
            break;
    }
//麦克风授权
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                return YES;
            }
            else {
            return NO;
            }
        }];}
    
    
    
    }
//发起会话
-(void)loadLiveView
{
   
    _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
   
          self.preView = [UIView new];
         self.preView.frame = self.view.bounds;
         self.preView.backgroundColor = [UIColor clearColor];
         self.preView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view insertSubview:_preView atIndex:0];
       _session.running=YES;
       _session.preView=_preView;
    
}


//关闭窗口
- (IBAction)colseCurrView:(UIButton *)btn {
    
    if (self.session.state == LFLivePending || self.session.state == LFLiveStart){
        [self.session stopLive];
    }
  [self dismissViewControllerAnimated:YES completion:nil];
   // NSLog(@"关闭");
}

//前后相机切换
- (IBAction)onClickchangImage:(UIButton *)btn{
  
    AVCaptureDevicePosition devicePositon = self.session.captureDevicePosition;
    self.session.captureDevicePosition = (devicePositon == AVCaptureDevicePositionBack) ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
    

}


//美颜按钮
- (IBAction)beautifulFace:(UIButton *)btn {
    
       btn.selected=!btn.selected;
      self.session.beautyFace=!self.session.beautyFace;
    
//    if (btn.selected) {
//       NSLog(@"开启美颜");
//    }
//    else{
//      NSLog(@"关闭美颜");
//    }
//    
    
    
}

//开始直播

-(IBAction)startLive:(UIButton *)buttion
{
    buttion.selected=!buttion.selected;
    
    if (buttion.selected) {
        [buttion setTitle:@"开始直播" forState:UIControlStateNormal];
        
        
        LFLiveStreamInfo *stream=[[LFLiveStreamInfo alloc] init];
        stream.url=@"rtmp://192.168.1.102:1935/rtmplive/roomoo";
        [self.session startLive:stream];
        return;
    }
    [buttion setTitle:@"结束直播" forState:UIControlStateNormal];
    [self.session stopLive];
    
   }

@end
