//
//  Chat_ViewController.m
//  幻境
//
//  Created by mac on 17/8/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "Chat_ViewController.h"

@interface Chat_ViewController ()

@end

@implementation Chat_ViewController
{
    UITableView *myTableView;
    NSDictionary *jsonObject;
    UILabel *textLab;
    UITextField *questTF;
    UIButton *sendBtn;
    NSString *questionStr,*urlString;
    NSMutableArray *dataArr,*timeArr;
    CGSize size,AnSize;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSourse];
    

}

- (void)initDataSourse{
    dataArr = [NSMutableArray new];
    timeArr = [NSMutableArray new];
    
    [self initUI];
}

- (void)initUI{
    self.title = @"chat with world";
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPwidth, APPheigh-40) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.tableHeaderView.hidden = YES;
    [self.view addSubview:myTableView];
    ///

//    textLab.text = jsonObject[@"content"];

    //tableBar的高度为 49；
    questTF = [[UITextField alloc]initWithFrame:CGRectMake(20,APPheigh- 89, APPwidth-70, 40)];
    questTF.placeholder = @"请输入你的问题？";
    questTF.delegate = self;
    questTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:questTF];
    //
    sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(APPwidth-40, APPheigh - 89, 40, 40)];
    sendBtn.backgroundColor = [UIColor purpleColor];
    sendBtn.layer.cornerRadius = 20;
    sendBtn.clipsToBounds = YES;
    [self.view addSubview:sendBtn];
    [sendBtn addTarget:self action:@selector(getTextFiled:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)getTextFiled:(UIButton *)btn{
    [dataArr addObject:questTF.text];

    [self NetWorkYouCanDo];

    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    //        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    [timeArr addObject:currentDateString];
    NSLog(@"dataArr.count = %lu",(unsigned long)dataArr.count);
    [myTableView reloadData];

    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row %2 ==0) {
        NSString *ID = @"cell";
        ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[ChatCell new]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            
        }
        cell.headLab.backgroundColor = [UIColor greenColor];
        cell.headLab.text = [NSString stringWithFormat:@"%@",dataArr[indexPath.row]];
        cell.headLab.font=[UIFont systemFontOfSize:17];
        NSInteger aint=cell.headLab.text.length;
        NSLog(@"文字 个数位：%lu ",aint);
        //APPwidth-100, 20, 80, 20
//        cell.headLab.frame = CGRectMake(APPwidth-aint*10, 20, 80 + aint*10, 20+aint*10);

        NSString *str=cell.headLab.text;
        size = [str sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(APPwidth-80, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        cell.headLab.frame=CGRectMake(APPwidth-size.width-20, cell.headLab.frame.origin.y, 10+size.width, 10+size.height);
        cell.headLab.numberOfLines=0; 
        cell.timeLab.text = timeArr[indexPath.row];
        cell.selectionStyle = UITableViewCellStyleDefault;

        return cell;

    }else{
        
        NSString *RobotID = @"robotcell";
        RobotCell *robotCell = [tableView dequeueReusableCellWithIdentifier:RobotID];
        
        if (!robotCell) {
            robotCell = [[RobotCell new]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RobotID];
            
        }
        NSLog(@"%ld",indexPath.row %2);
        robotCell.headLab.backgroundColor = [UIColor orangeColor];
        robotCell.headLab.text = dataArr[indexPath.row];
        NSString *AnStr=robotCell.headLab.text;
        AnSize = [AnStr sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(APPwidth -80, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
  
        robotCell.headLab.frame=CGRectMake(20, robotCell.headLab.frame.origin.y, 10+AnSize.width, 10+AnSize.height);


        robotCell.selectionStyle = UITableViewCellStyleDefault;
        
        return robotCell;
    
    }
    
    
 

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//   NSString * str = [NSString stringWithFormat:@"%@%ld",dataArr[indexPath.row],indexPath.row/2];
//    size = [str sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(APPwidth-80, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    if (indexPath.row %2  == 0) {
        return 60+size.height;

    }else{
        return 60+AnSize.height;
        
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
//      NSLog(@"%f",    -myTableView.contentOffset.y
//          );
}


- (void)NetWorkYouCanDo{
    questionStr = questTF.text;
    if (questionStr == nil) {
        questionStr = [[NSString alloc]init];
        questionStr =@"很高兴认识你！";
        
    }
    urlString =[NSString stringWithFormat:@"%@%@",@"http://api.jisuapi.com/iqa/query?appkey=e26389d5cf19ac83&question=",questionStr] ;
    
    [[MyHttPReusest alloc] getHttpRequest:urlString key:@"robot"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getJsonObjectForNetWork4:) name:@"robot" object:nil];
    
    
}

- (void)getJsonObjectForNetWork4:(NSNotification *)notification{
    //    NSLog(@"%@",notification.userInfo[@"result"]);
    jsonObject = notification.userInfo[@"result"];
    NSLog(@"%@",jsonObject[@"content"]);
    [dataArr addObject:jsonObject[@"content"]];
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    //        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    [timeArr addObject:currentDateString];[myTableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //滚动到tableview的任意一行
    [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:dataArr.count -1 inSection:0]atScrollPosition:UITableViewScrollPositionTop animated:YES];
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
