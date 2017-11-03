//
//  ClassData.m
//  FreeRead
//
//  Created by lanou3g on 15/4/21.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "ClassData.h"

@implementation ClassData

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"bookCount"]) {
        self.bookCount_num = [NSString stringWithFormat:@"%@", value];
    }
}

@end
