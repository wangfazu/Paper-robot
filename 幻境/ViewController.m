//
//  ViewController.m
//  幻境
//
//  Created by mac on 17/8/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UIImageView *backGroundImageView;
    UIImageView *topImageView;
    UIButton *tangShiBtn;
    UIButton *songCiBtn;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];

}

- (void)initUI{
    self.title = @"主页";
    //
    backGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0  , APPwidth ,APPheigh )];
    backGroundImageView.image = [UIImage imageNamed:@"back.jpg"];
    [self.view addSubview:backGroundImageView];
    
    //
    topImageView = [[ UIImageView alloc]initWithFrame:CGRectMake(20, 44, APPwidth-40, (APPwidth-40)/1.6)];
    topImageView.image = [UIImage imageNamed:@"background.jpg"];
    [self.view addSubview:topImageView];
    
    //
    tangShiBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, topImageView.bounds.size.height+80, APPwidth/2-30, APPwidth/2-30)];
    tangShiBtn.backgroundColor = [UIColor redColor];
    [tangShiBtn setImage:[UIImage imageNamed:@"tangshi1"] forState:UIControlStateNormal];
    tangShiBtn.layer.cornerRadius = 10;
    tangShiBtn.clipsToBounds = YES;
        [tangShiBtn addTarget:self action:@selector(tangshiClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tangShiBtn];

    
    //
    songCiBtn = [[UIButton alloc ]initWithFrame:CGRectMake(APPwidth/2+10, topImageView.bounds.size.height+80,  APPwidth/2-30,  APPwidth/2-30)];
    [songCiBtn setImage:[UIImage imageNamed:@"songci1"] forState:UIControlStateNormal];
    songCiBtn.layer.cornerRadius = 10;
    songCiBtn.clipsToBounds = YES;
    [songCiBtn addTarget:self action:@selector(songciClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:songCiBtn];
    
}

- (void)tangshiClick{
    [self.navigationController pushViewController:[TangShiViewController new] animated:true];
    
}

- (void)songciClick{
    
    [self.navigationController pushViewController:[SongCiViewController new] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
