//
//  RankingCell.m
//  FreeRead
//
//  Created by lanou3g on 15/4/20.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "RankingCell.h"

@implementation RankingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
    
        self.title = [[UILabel alloc] init];
        self.title.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:self.title];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    

    self.title.frame = self.contentView.bounds;
  
    
 
}




@end
