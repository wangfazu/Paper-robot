//
//  TangShiViewController.m
//  幻境
//
//  Created by mac on 17/8/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TangShiViewController.h"
#import "DT___TangShiViewController.h"

@interface TangShiViewController ()

@end

@implementation TangShiViewController
{
    
    UITableView *mytableView;
    NSArray *jsonObject;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSourse];


    
    // Do any additional setup after loading the view.
}

- (void)initUI{
    self.title = @"唐诗";
    self.view.backgroundColor = [UIColor whiteColor];
    //tableView
    mytableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -40, APPwidth, APPheigh) style:UITableViewStyleGrouped];
    mytableView.delegate = self;
    mytableView.dataSource = self;
    [self.view addSubview:mytableView];

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 方案三  当页面拉动需要显示新数据的时候，把最后一个cell进行删除 就有可以自定义cell 此方案即可避免重复显示，又重用了cell相对内存管理来说是最好的方案 前两者相对比较消耗内存
   
        // 定义唯一标识
        static NSString *CellIdentifier = @"Cell";
        // 通过唯一标识创建cell实例
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
        {
            while ([cell.contentView.subviews lastObject] != nil) {
                [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        // 对cell 进行简单地数据配置
    
//    cell.textLabel.text =[NSString stringWithFormat:@"%@",@".",@"%@",jsonObject[indexPath.row][@"detailid"],jsonObject[indexPath.row][@"name"]];
    cell.textLabel.text=[NSString stringWithFormat:@"%@ . %@",jsonObject[indexPath.row][@"detailid"],jsonObject[indexPath.row][@"name"]];
    
    cell.detailTextLabel.text = jsonObject[indexPath.row][@"author"];
        cell.imageView.image = [UIImage imageNamed:@"tangshi1"];
          cell.selectionStyle = UITableViewCellStyleSubtitle;
    NSLog(@"------------%@",jsonObject[indexPath.row][@"name"]);
        return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DT___TangShiViewController *vc = [[DT___TangShiViewController alloc]init];
    vc.bookName =  jsonObject[indexPath.row][@"name"];
    vc.author  = jsonObject[indexPath.row][@"author"];
    vc.detailid = jsonObject[indexPath.row][@"detailid"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
//////////////////////////////////////////////////////

- (void)initDataSourse{

    NSString *urlString = @"http://api.jisuapi.com/tangshi/chapter?appkey=e26389d5cf19ac83";
    /**
     *  对网址转码
     *
     *  @param NSString 。
     *   转换完毕后在发送网络请求
     *  @return 。
     */
    [[MyHttPReusest alloc]getHttpRequest:urlString key:@"diyige"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getJsonObjectForNetWork3:) name:@"diyige" object:nil];
    
}

- (void)getJsonObjectForNetWork3:(NSNotification *)notification{
    NSLog(@"%@",notification.userInfo[@"result"]);
    jsonObject = notification.userInfo[@"result"];
    [self initUI];
    [[NSNotificationCenter defaultCenter] removeObserver:self];


//    [mytableView reloadData];

}
/////////////////////////////////////////////////////////////////////////
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
