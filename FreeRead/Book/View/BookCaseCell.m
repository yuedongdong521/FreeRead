//
//  BookCaseCell.m
//  FreeRead
//
//  Created by lanou3g on 15/4/18.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "BookCaseCell.h"
#import "UIImageView+WebCache.h"
#import "DataBaseHandler.h"

@interface BookCaseCell ()

@property (nonatomic, assign)NSInteger flage;

@end

@implementation BookCaseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [[UIImageView alloc] init];
     
        [self.contentView addSubview:_image];
        
        self.title = [[UILabel alloc] init];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        self.title.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.title];
        
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.image.frame = CGRectMake(0, 0, self.contentView.W, self.contentView.H / 5 * 4);

    self.title.frame = CGRectMake(0, self.contentView.H / 5 * 4, self.contentView.W, self.contentView.H / 5);
    
}

- (void)setSmall:(SmallMakeUpData *)small
{
    if (_small != small) {
        _small = small;
    }
    [self.image setImageWithURLStr:small.imageStr Photo:@"backshu(1)"];
    self.title.text = small.title;
}






@end
