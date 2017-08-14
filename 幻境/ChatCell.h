//
//  ChatCell.h
//  幻境
//
//  Created by mac on 17/8/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCell : UITableViewCell
@property (nonatomic, weak) UILabel *headLab;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic,retain)UILabel *timeLab;
@end
