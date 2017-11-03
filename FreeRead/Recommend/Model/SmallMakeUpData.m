//
//  SmallMakeUpData.m
//  FreeRead
//
//  Created by lanou3g on 15/4/21.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "SmallMakeUpData.h"

@implementation SmallMakeUpData

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
    if ([key isEqualToString:@"cover"]) {
        self.imageStr = [value stringByReplacingOccurrencesOfString:@"/agent/" withString:@""];
    }
    
    if ([key isEqualToString:@"banned"]) {
        self.banned_num = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([key isEqualToString:@"latelyFollower"]) {
        self.latelyFollower_num = [NSString stringWithFormat:@"%@", value];
    }
    if ([key isEqualToString:@"retentionRatio"] || [value isKindOfClass:[NSNumber class]]) {
        self.retentionRatio_num = [NSString stringWithFormat:@"%@", value];
    } else if ([key isEqualToString:@"retentionRatio"] || [value isKindOfClass:[NSString class]]) {
        self.retentionRatio_num = value;
    }
    
    if ([key isEqualToString:@"wordCount"]) {
        self.wordCount_num = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([key isEqualToString:@"postCount"]) {
        self.postCount_num = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([key isEqualToString:@"followerCount"]) {
        self.followerCount_num = [NSString stringWithFormat:@"%@", value];
    }
    
    if ([key isEqualToString:@"serializeWordCount"]) {
        self.serializeWordCount_num = [NSString stringWithFormat:@"%@", value];
    }
    if ([key isEqualToString:@"tags"]) {
        self.tags_arr = [value componentsJoinedByString:@"  "];
    }
    
   
    
}


@end
