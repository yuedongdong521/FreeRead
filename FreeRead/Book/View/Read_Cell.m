//
//  Read_Cell.m
//  FreeRead
//
//  Created by lanou3g on 15/4/23.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "Read_Cell.h"

@implementation Read_Cell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
       
        self.body = [[UILabel alloc] init];

        self.body.lineBreakMode =  NSLineBreakByCharWrapping;
        self.body.numberOfLines = 0;

        self.body.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.body];
        
        self.title = [[UILabel alloc] init];
        self.title.font = [UIFont systemFontOfSize:14];
        self.title.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.title];
        
        self.page = [[UILabel alloc] init];
        self.page.backgroundColor = [UIColor clearColor];
        self.page.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.page];
        
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.title.frame = CGRectMake(10, 0, self.contentView.W - 20, 20);
    self.body.frame = CGRectMake(10, self.title.frame.origin.y + self.title.frame.size.height, self.contentView.W - 20, self.contentView.H - 40);
    
    NSLog(@"||||||||-----%f---|||||||||||||||||---%f", self.body.H, self.contentView.H);
    self.page.frame = CGRectMake(10, self.contentView.H - 20, self.contentView.W - 20, 20);
}

- (void)setName:(NSString *)name
{
    if (_name != name) {
        _name = name;
    }
    self.title.text = _name;
}

- (void)setText:(NSString *)text
{
    if (_text != text) {
        _text = text;
    }
    self.body.text = _text;
    
}

- (void)setNum:(NSString *)num
{
    if (_num != num) {
        _num = num;
    }
    self.page.text = _num;
}

- (void)setFontSize:(CGFloat)fontSize
{
    if (_fontSize != fontSize) {
        _fontSize = fontSize;
    }
    self.body.font = [UIFont systemFontOfSize:_fontSize];
    
}

- (void)setBodyHeight:(CGFloat)bodyHeight
{
    if (_bodyHeight != bodyHeight) {
        _bodyHeight = bodyHeight;
    }
    self.body.frame = CGRectMake(10, 20, self.contentView.W - 20, _bodyHeight);
   
    
    
}


@end
