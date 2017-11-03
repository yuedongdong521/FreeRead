//
//  DirectoryData.m
//  FreeRead
//
//  Created by lanou3g on 15/4/24.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "DirectoryData.h"

@implementation DirectoryData

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
    
}

@end
