//
//  Ranking_List_Cell.h
//  FreeRead
//
//  Created by lanou3g on 15/4/21.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmallMakeUpData.h"

@interface Ranking_List_Cell : UITableViewCell

@property (nonatomic, retain)UIImageView *photo;
@property (nonatomic, retain)UILabel *title;
@property (nonatomic, retain)UILabel *actour;
@property (nonatomic, retain)UILabel *type;
@property (nonatomic, retain)UILabel *info;
@property (nonatomic, retain)SmallMakeUpData *data;

@end
