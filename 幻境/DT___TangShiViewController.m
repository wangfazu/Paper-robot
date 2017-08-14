//
//  DT___TangShiViewController.m
//  幻境
//
//  Created by mac on 17/8/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DT___TangShiViewController.h"

@interface DT___TangShiViewController ()

@end

@implementation DT___TangShiViewController
{
    UILabel *bookNameLab;
    UILabel *authorLab;
    UILabel *detailLab;
    NSString *htmlString;
    NSDictionary *jsonObject;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.bookName;
    self.view.backgroundColor =[UIColor whiteColor ];
    [self initDataSourse];
}


- (void)initUI{
    self.title = @"唐诗";

    //
    bookNameLab = [[UILabel alloc]initWithFrame:CGRectMake(60, 100, APPwidth-120, 30)];
    bookNameLab.text = self.bookName;
    bookNameLab.textAlignment = NSTextAlignmentCenter;
//    bookNameLab.backgroundColor = [UIColor redColor];
    [self.view addSubview:bookNameLab];
    //
    authorLab =[[UILabel alloc]initWithFrame:CGRectMake(APPwidth/2, 130, APPwidth/2, 30)];
    authorLab.textAlignment = NSTextAlignmentCenter;
    authorLab.text= self.author;
//    authorLab.backgroundColor = [UIColor redColor];
    [self.view addSubview:authorLab];
    //
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[jsonObject[@"content"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    [attrStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} range:NSMakeRange(0, attrStr.length)];

    detailLab = [[UILabel alloc]initWithFrame:CGRectMake(60, 160, APPwidth-120, 100)];
    detailLab.backgroundColor=[UIColor redColor];
    detailLab.textAlignment = NSTextAlignmentCenter;
    detailLab.attributedText = attrStr;
    detailLab.numberOfLines = 0;
     [self.view addSubview:detailLab];
    NSLog(@"%@",attrStr);
    //
    
    /*展示网页上面的东西，带有文字标识符号的都可以，直接结果这哥俩转化
    NSString * htmlString = @"<html><body> Some html string \n <font size=\"13\" color=\"red\">This is some text!</font> </body></html>";
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    UILabel * myLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    myLabel.attributedText = attrStr;
    [self.view addSubview:myLabel];
     */
   
    
    
}

- (void)initDataSourse{

    NSString *urlString1 = @"http://api.jisuapi.com/tangshi/detail?appkey=e26389d5cf19ac83&detailid=";
    NSString *urlString = [NSString stringWithFormat:@"%@%@",urlString1,self.detailid];
    NSLog(@"%@",self.detailid);
    /**
     *  对网址转码
     *
     *  @param NSString 。
     *   转换完毕后在发送网络请求
     *  @return 。
     */
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getJsonObjectForNetWork1:) name:@"dierge" object:nil];

    [[MyHttPReusest alloc]getHttpRequest:urlString key:@"dierge"];
    
         }

- (void)getJsonObjectForNetWork1:(NSNotification *)notification{
    NSLog(@"%@",notification.userInfo[@"result"]);
    jsonObject = notification.userInfo[@"result"];
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
