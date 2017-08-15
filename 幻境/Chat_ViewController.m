//
//  Chat_ViewController.m
//  幻境
//
//  Created by mac on 17/8/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "Chat_ViewController.h"

@interface Chat_ViewController ()
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) NSDictionary *jsonObject;
@property (nonatomic,strong) UILabel *textLab;
@property (nonatomic,strong) UITextField *questTF;
@property (nonatomic,strong) UIButton *sendBtn;
@property (nonatomic,strong) NSString *questionStr,*urlString;
@property (nonatomic,strong) NSMutableArray *dataArr,*timeArr;
@property (nonatomic,assign) CGSize size,AnSize;
@end

@implementation Chat_ViewController
{







}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSourse];
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.questTF];
    [self.view addSubview:self.sendBtn];
    
}

- (void)initDataSourse{
    _dataArr = [NSMutableArray new];
    _timeArr = [NSMutableArray new];
    
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPwidth, APPheigh-40) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.tableHeaderView.hidden = YES;
        [self.view addSubview:_myTableView];
    }
    
    return _myTableView;
}

- (UITextField *)questTF{
    if (!_questTF) {
        _questTF = [[UITextField alloc]initWithFrame:CGRectMake(20,APPheigh- 89, APPwidth-70, 40)];
        _questTF.placeholder = @"请输入你的问题？";
        _questTF.delegate = self;
        _questTF.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:_questTF];
    }
    return _questTF;
}

- (UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(APPwidth-40, APPheigh - 89, 40, 40)];
        _sendBtn.backgroundColor = [UIColor purpleColor];
        _sendBtn.layer.cornerRadius = 20;
        _sendBtn.clipsToBounds = YES;
        [self.view addSubview:_sendBtn];
        [_sendBtn addTarget:self action:@selector(getTextFiled:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _sendBtn;
    
}
- (void)getTextFiled:(UIButton *)btn{
    [_dataArr addObject:_questTF.text];

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
    [_timeArr addObject:currentDateString];
    NSLog(@"dataArr.count = %lu",(unsigned long)_dataArr.count);
    [_myTableView reloadData];

    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row %2 ==0) {
        NSString *ID = @"cell";
        ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[ChatCell new]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            
        }
        cell.headLab.backgroundColor = [UIColor greenColor];
        cell.headLab.text = [NSString stringWithFormat:@"%@",_dataArr[indexPath.row]];
        cell.headLab.font=[UIFont systemFontOfSize:17];
        NSInteger aint=cell.headLab.text.length;
        NSLog(@"文字 个数位：%lu ",aint);
        //APPwidth-100, 20, 80, 20
//        cell.headLab.frame = CGRectMake(APPwidth-aint*10, 20, 80 + aint*10, 20+aint*10);

        NSString *str=cell.headLab.text;
        _size = [str sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(APPwidth-80, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        cell.headLab.frame=CGRectMake(APPwidth-_size.width-20, cell.headLab.frame.origin.y, 10+_size.width, 10+_size.height);
        cell.headLab.numberOfLines=0; 
        cell.timeLab.text = _timeArr[indexPath.row];
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
        robotCell.headLab.text = _dataArr[indexPath.row];
        NSString *AnStr=robotCell.headLab.text;
        _AnSize = [AnStr sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(APPwidth -80, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
  
        robotCell.headLab.frame=CGRectMake(20, robotCell.headLab.frame.origin.y, 10+_AnSize.width, 10+_AnSize.height);


        robotCell.selectionStyle = UITableViewCellStyleDefault;
        
        return robotCell;
    
    }
    
    
 

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//   NSString * str = [NSString stringWithFormat:@"%@%ld",dataArr[indexPath.row],indexPath.row/2];
//    size = [str sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(APPwidth-80, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    if (indexPath.row %2  == 0) {
        return 60+_size.height;

    }else{
        return 60+_AnSize.height;
        
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    [myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
//      NSLog(@"%f",    -myTableView.contentOffset.y
//          );
}


- (void)NetWorkYouCanDo{
    _questionStr = _questTF.text;
    if (_questionStr == nil) {
        _questionStr = [[NSString alloc]init];
        _questionStr =@"很高兴认识你！";
        
    }
    _urlString =[NSString stringWithFormat:@"%@%@",@"http://api.jisuapi.com/iqa/query?appkey=e26389d5cf19ac83&question=",_questionStr] ;
    
    [[MyHttPReusest alloc] getHttpRequest:_urlString key:@"robot"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getJsonObjectForNetWork4:) name:@"robot" object:nil];
    
    
}

- (void)getJsonObjectForNetWork4:(NSNotification *)notification{
    //    NSLog(@"%@",notification.userInfo[@"result"]);
    _jsonObject = notification.userInfo[@"result"];
    NSLog(@"%@",_jsonObject[@"content"]);
    [_dataArr addObject:_jsonObject[@"content"]];
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    //        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    [_timeArr addObject:currentDateString];[_myTableView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //滚动到tableview的任意一行
    [_myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_dataArr.count -1 inSection:0]atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)initUI{
    self.title = @"chat with world";
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPwidth, APPheigh-40) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.tableHeaderView.hidden = YES;
    [self.view addSubview:_myTableView];
    ///
    
    //    textLab.text = jsonObject[@"content"];
    
    //tableBar的高度为 49；
    _questTF = [[UITextField alloc]initWithFrame:CGRectMake(20,APPheigh- 89, APPwidth-70, 40)];
    _questTF.placeholder = @"请输入你的问题？";
    _questTF.delegate = self;
    _questTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_questTF];
    //
    _sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(APPwidth-40, APPheigh - 89, 40, 40)];
    _sendBtn.backgroundColor = [UIColor purpleColor];
    _sendBtn.layer.cornerRadius = 20;
    _sendBtn.clipsToBounds = YES;
    [self.view addSubview:_sendBtn];
    [_sendBtn addTarget:self action:@selector(getTextFiled:) forControlEvents:UIControlEventTouchUpInside];
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
