//
//  ClassifyCell.m
//  FreeRead
//
//  Created by lanou3g on 15/4/20.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "ClassifyCell.h"

@implementation ClassifyCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.label = [[UILabel alloc] init];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.label];
        
        self.number = [[UILabel alloc] init];
        self.number.textAlignment = NSTextAlignmentCenter;
        self.number.font = [UIFont systemFontOfSize:14];
        self.number.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.number];
        
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.label.frame = CGRectMake(0, 0, self.contentView.W, self.contentView.H / 2);
    self.number.frame = CGRectMake(0, self.contentView.H / 2, self.contentView.W, self.contentView.H  / 2);
}

- (void)setData:(ClassData *)data
{
    if (_data != data) {
        _data = data;
    }
    self.label.text = self.data.name;
    self.number.text = [self.data.bookCount_num stringByAppendingString:@"本"];
}

@end
