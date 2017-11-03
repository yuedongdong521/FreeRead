//
//  Read_Data.m
//  FreeRead
//
//  Created by lanou3g on 15/4/23.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "Read_Data.h"

@implementation Read_Data

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
    NSMutableString *str = [NSMutableString stringWithString:value];
  
    if ([key isEqualToString:@"body"]) {
        [str insertString:@"        " atIndex:0];
        for (NSInteger i = 0; i < [str length]; i++) {
            NSRange range = NSMakeRange(i, 1);
            if ([[str substringWithRange:range] isEqualToString:@"\n"]) {
                [str insertString:@"        " atIndex:i + 1];
            }
        }
  
        self.body_str = str;
    }
}

@end
