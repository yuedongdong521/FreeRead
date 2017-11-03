//
//  ClassifyCRV.m
//  FreeRead
//
//  Created by lanou3g on 15/4/20.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "ClassifyCRV.h"

@interface ClassifyCRV ()

@end

@implementation ClassifyCRV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        self.backgroundColor = [UIColor clearColor];
        
        self.title = [[UILabel alloc] init];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.title];
        
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.title.frame = CGRectMake(0, 0, layoutAttributes.W / 6, layoutAttributes.H);
   
}

- (void)setText:(NSString *)text
{
    if (_text != text) {
        _text = text;
    }
    self.title.text = text;
}

@end
