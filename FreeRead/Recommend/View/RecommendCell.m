//
//  RecommendCell.m
//  FreeRead
//
//  Created by lanou3g on 15/4/18.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "RecommendCell.h"


@implementation RecommendCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc] init];
      
        [self.contentView addSubview:_imageV];
        
        self.title = [[UILabel alloc] init];
        self.title.font = [UIFont systemFontOfSize:12];
        self.title.backgroundColor = [UIColor whiteColor];
        self.title.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_title];
        
        self.actour = [[UILabel alloc] init];
        self.actour.backgroundColor = [UIColor whiteColor];
        self.actour.font = [UIFont systemFontOfSize:12];
        self.actour.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_actour];
        
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.imageV.frame = CGRectMake(0, 0, self.contentView.W, self.contentView.H / 4 * 3);
    
    self.title.frame = CGRectMake(0, self.imageV.H, self.contentView.W, self.contentView.H / 8);
    
    self.actour.frame = CGRectMake(0, self.title.H + self.title.Y, self.contentView.W, self.contentView.H / 8);
    
}

- (void)setData:(SmallMakeUpData *)data
{
    if (_data != data) {
        _data = data;
    }
    
    [self.imageV setImageWithURLStr:self.data.imageStr Photo:@"backshu(1).png"];
    self.title.text = self.data.title;
    self.actour.text = self.data.author;
}

@end
