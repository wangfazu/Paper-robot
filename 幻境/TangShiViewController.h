//
//  TangShiViewController.h
//  幻境
//
//  Created by mac on 17/8/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TangShiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) NSString *author;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *detailid;
@end
