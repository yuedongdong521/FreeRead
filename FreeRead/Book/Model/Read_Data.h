//
//  Read_Data.h
//  FreeRead
//
//  Created by lanou3g on 15/4/23.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Read_Data : NSObject

@property (nonatomic, retain)NSString *title;
@property (nonatomic, retain)NSMutableString *body_str;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
