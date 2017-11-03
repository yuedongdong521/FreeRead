//
//  Book_Info_VC.h
//  FreeRead
//
//  Created by lanou3g on 15/4/18.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Book_Info_VC : UIViewController
@property (nonatomic, retain) NSString *book_id;
@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, assign) BOOL makeV_bool;

@end
