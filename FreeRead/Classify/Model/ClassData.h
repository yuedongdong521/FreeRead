//
//  ClassData.h
//  FreeRead
//
//  Created by lanou3g on 15/4/21.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassData : NSObject

@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *bookCount_num;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
