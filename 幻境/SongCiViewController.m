//
//  SongCiViewController.m
//  幻境
//
//  Created by mac on 17/8/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SongCiViewController.h"

@interface SongCiViewController ()

@end

@implementation SongCiViewController
{
    
    NSDictionary *jsonObject;
    UILabel *textLab;
    UITextField *questTF;
    UIButton *sendBtn;
    NSString *questionStr,*urlString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatasourse];
    // Do any additional setup after loading the view.
}

- (void)initUI{
    if (textLab!=nil) {
        textLab.text = jsonObject[@"content"];

        return;
    }
    self.title = @"纸张机器人";
    textLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 44, APPwidth - 40, APPheigh-80)];
    [self.view addSubview:textLab];
    textLab.text = jsonObject[@"content"];
//    textLab.text = @"我曾经跨过山河大海，也曾经穿越人海,曾经跨过山河大海，也曾经穿越人海,曾经跨过山河大海，也曾经穿越人海曾经跨过山河大海，也曾经穿越人海" ;
    textLab.numberOfLines = 0;
    self.view.backgroundColor = [UIColor whiteColor];

    //
    questTF = [[UITextField alloc]initWithFrame:CGRectMake(20,APPheigh-100, APPwidth-60, 40)];
    questTF.placeholder = @"请输入你的问题？";
    questTF.delegate = self;
    questTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:questTF];
    //
    sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(APPwidth-40, APPheigh - 100, 40, 40)];
    sendBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:sendBtn];
    [sendBtn addTarget:self action:@selector(getTextFiled:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)getTextFiled:(UIButton *)btn{
    
//    textLab.text = @"";
    questionStr = questTF.text;
    [self initDatasourse];
    
}
- (void)initDatasourse{

    if (questionStr == nil) {
        questionStr = [[NSString alloc]init];
        questionStr =@"很高兴认识你！";
        
    }
    urlString =[NSString stringWithFormat:@"%@%@",@"http://api.jisuapi.com/iqa/query?appkey=e26389d5cf19ac83&question=",questionStr] ;
  
        [[MyHttPReusest alloc] getHttpRequest:urlString key:@"robot"];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getJsonObjectForNetWork2:) name:@"robot" object:nil];
   

}

- (void)getJsonObjectForNetWork2:(NSNotification *)notification{
//    NSLog(@"%@",notification.userInfo[@"result"]);
    jsonObject = notification.userInfo[@"result"];
    NSLog(@"%@",jsonObject[@"content"]);
    [self initUI];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
