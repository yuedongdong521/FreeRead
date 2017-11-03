//
//  Ranking_List_Cell.m
//  FreeRead
//
//  Created by lanou3g on 15/4/21.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "Ranking_List_Cell.h"

@implementation Ranking_List_Cell

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
        self.photo = [[UIImageView alloc] init];
      
        [self.contentView addSubview:self.photo];
        
        self.title = [[UILabel alloc] init];
       
        [self.contentView addSubview:self.title];
        
        self.actour = [[UILabel alloc] init];
        self.actour.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.actour];
        
        self.info = [[UILabel alloc] init];
        self.info.numberOfLines = 0;
        self.info.textColor = [UIColor grayColor];
        self.info.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.info];
        
        self.type = [[UILabel alloc] init];
        self.type.textColor = [UIColor redColor];
        self.type.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.type];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.photo.frame = CGRectMake(10, 0, self.contentView.W / 4, self.contentView.H - 10);
    [self.photo setImageWithURLStr:self.data.imageStr Photo:@"backshu(1).png"];
    
    self.title.frame = CGRectMake(self.photo.W + 20, 0, self.contentView.W / 4 * 2, self.contentView.H / 5);
    self.title.text = self.data.title;
    
    self.type.frame = CGRectMake(self.contentView.W / 4 * 3 + 20, 0, self.contentView.W / 4 - 30, self.contentView.H / 5);
    self.type.text = self.data.cat;
    
    self.actour.frame = CGRectMake(self.photo.W + 20, self.contentView.H / 5, self.contentView.W / 2, self.contentView.H / 5);
    self.actour.text = self.data.author;
    
    self.info.frame = CGRectMake(self.photo.W + 20, self.contentView.H / 5 * 2, self.contentView.W / 4 * 3 - 30, self.contentView.H / 5 * 3 - 10);
    self.info.text = [@"      " stringByAppendingString:self.data.shortIntro];
}
@end
