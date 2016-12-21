//
//  LiveListViewController.m
//  JHLiveDemo
//
//  Created by JiangHao on 16/11/20.
//  Copyright © 2016年 JiangHao. All rights reserved.
#import "LiveListViewController.h"
#import "LiveAggregationCell.h"
#import "LiveAggregation.h"
#import <AFNetworking.h>
#import "ShowViewController.h"

@interface LiveListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * dataArr;
//@property(nonatomic ,strong)ShowViewController *shouVC;
@end

@implementation LiveListViewController


//-(void)viewWillAppear:(BOOL)animated
//{
//  [super viewWillAppear:animated];
//    
// 
//
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr=[NSMutableArray array];
    [self customNav];
    [self requestData];
 
[self.tableView registerNib:[UINib nibWithNibName:@"LiveAggregationCell" bundle:nil] forCellReuseIdentifier:@"liveCell"];
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.navigationController.navigationBar) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }

}




-(void)requestData
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
    [manager GET:@"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
    // self.dataArr=[LiveAggregation mj_objectArrayWithKeyValuesArray:responseObject[@"lives"]];

        
        for (NSDictionary *dict in responseObject[@"lives"]) {
            LiveAggregation *liveAggregation=[[LiveAggregation alloc] init];
              liveAggregation.portrait= dict[@"creator"][@"portrait"];
               liveAggregation.nick=dict[@"creator"][@"nick"];
               liveAggregation.city=dict[@"city"];
            liveAggregation.online_users=[dict[@"online_users"] integerValue];
            liveAggregation.stream_addr=dict[@"stream_addr"];
            [self.dataArr addObject:liveAggregation];
        }
        [self.tableView reloadData];
        //NSLog(@"%@",self.dataArr);
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

     //NSLog(@"%@",self.dataArr);
    

}


//定制导航栏
-(void)customNav
{
    self.title=@"热门直播";
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 40, 40);
    backBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:backBtn];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //NSLog(@"11");
    
    if (self.dataArr.count==0) {
        return 0;
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   //NSLog(@"22");
    return self.dataArr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiveAggregationCell *cell=[tableView dequeueReusableCellWithIdentifier:@"liveCell"];
    cell.liveAggregation=self.dataArr[indexPath.row];
    // NSLog(@"33");
    return cell;
}





-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 440;
}





-(void)backView:(UIButton *)btn{
[self.navigationController popViewControllerAnimated:YES];

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ShowViewController * shouVC=[[ShowViewController alloc] init];
    LiveAggregation * agg=self.dataArr[indexPath.row];
    shouVC.liveUrl=agg.stream_addr;
    shouVC.imageUrl=agg.portrait;
  [self.navigationController pushViewController:shouVC animated:YES];
  [self.navigationController setNavigationBarHidden:YES animated:YES];

}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


@end
