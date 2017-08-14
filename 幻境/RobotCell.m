//
//  RobotCell.m
//  幻境
//
//  Created by mac on 17/8/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RobotCell.h"

@implementation RobotCell
{
    
    
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    UILabel *headLab = [UILabel new];
    headLab.frame = CGRectMake(20, 33, 80, 20);
    headLab.layer.cornerRadius = 10;
    headLab.clipsToBounds = YES;
    headLab.numberOfLines = 0;
    [self addSubview:headLab];
    self.headLab = headLab;
    UILabel *timeLab = [UILabel new];
    timeLab.frame = CGRectMake(APPwidth/2-50, 10, 100, 20);
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.text = @"23:10:61";
    [self addSubview:timeLab];
    self.timeLab = timeLab;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
