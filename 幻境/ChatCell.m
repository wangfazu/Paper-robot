//
//  ChatCell.m
//  幻境
//
//  Created by mac on 17/8/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ChatCell.h"

@implementation ChatCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier ]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    UILabel *headLab = [UILabel new];
    headLab.frame = CGRectMake(APPwidth-90, 33, 80, 20);
    [self addSubview:headLab];
    self.headLab = headLab;
    
    headLab.layer.cornerRadius = 8;
    headLab.clipsToBounds = YES;
    UILabel *timeLab = [UILabel new];
    timeLab.frame = CGRectMake(APPwidth/2-50, 10, 100, 20);
    timeLab.textAlignment = NSTextAlignmentCenter;
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
