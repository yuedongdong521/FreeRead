//
//  ReadVC.h
//  FreeRead
//
//  Created by lanou3g on 15/4/23.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadVC : UIViewController

@property (nonatomic, assign)NSInteger urlInt;

@property (nonatomic, retain)NSMutableArray *arr;

@property (nonatomic, retain)NSString *bookUrl;

@property (nonatomic, assign)BOOL book_bool;

@property (nonatomic, retain)NSString *_id;

@property (nonatomic, retain)NSString *book_title;

@property (nonatomic, retain)NSString *imageStr;

@property (nonatomic, assign)NSInteger content;

@property (nonatomic, assign)NSInteger offset;

@end
