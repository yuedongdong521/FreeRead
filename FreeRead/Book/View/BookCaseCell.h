//
//  BookCaseCell.h
//  FreeRead
//
//  Created by lanou3g on 15/4/18.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmallMakeUpData.h"

@interface BookCaseCell : UICollectionViewCell
@property (nonatomic, retain)UILabel *title;
@property (nonatomic, retain)UIImageView *image;

@property (nonatomic, retain)SmallMakeUpData *small;


@end
