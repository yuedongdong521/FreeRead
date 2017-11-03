//
//  RecommendCRV.m
//  FreeRead
//
//  Created by lanou3g on 15/4/18.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "RecommendCRV.h"


@interface RecommendCRV ()

@property (nonatomic, retain)UILabel *label;

@end

@implementation RecommendCRV


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.label = [[UILabel alloc] init];
        [self addSubview:_label];
        
 
    }
    return self;

}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    self.label.frame = CGRectMake(0, 0, layoutAttributes.frame.size.width / 2, layoutAttributes.frame.size.height);
 
}

- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = title;
    }
    self.label.text = _title;
   
}



@end
