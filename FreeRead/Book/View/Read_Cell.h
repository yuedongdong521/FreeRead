//
//  Read_Cell.h
//  FreeRead
//
//  Created by lanou3g on 15/4/23.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Read_Cell : UICollectionViewCell

@property (nonatomic, retain)UILabel *body;
@property (nonatomic, retain)NSString *text;

@property (nonatomic, retain)UILabel *title;
@property (nonatomic, retain)NSString *name;

@property (nonatomic, retain)UILabel *page;
@property (nonatomic, retain)NSString *num;
@property (nonatomic, assign)CGFloat fontSize;

@property (nonatomic, assign)CGFloat bodyHeight;

@end
