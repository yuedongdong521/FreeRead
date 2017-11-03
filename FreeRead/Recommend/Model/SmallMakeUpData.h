//
//  SmallMakeUpData.h
//  FreeRead
//
//  Created by lanou3g on 15/4/21.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmallMakeUpData : NSObject

// 小说推荐
@property (nonatomic, retain)NSString *_id;
@property (nonatomic, retain)NSString *author;
@property (nonatomic, retain)NSString *imageStr; // cover
@property (nonatomic, retain)NSString *shortIntro;
@property (nonatomic, retain)NSString *banned_num; // NSNumber
@property (nonatomic, retain)NSString *site;

@property (nonatomic, retain)NSString *latelyFollower_num; // number
@property (nonatomic, retain)NSString *title;

@property (nonatomic, retain)NSString *retentionRatio_num; // number || string

// 小说详情
@property (nonatomic, retain)NSString *longIntro;
@property (nonatomic, retain)NSString *creater;
@property (nonatomic, retain)NSString *wordCount_num;
@property (nonatomic, retain)NSString *cat;
@property (nonatomic, retain)NSString *postCount_num;
@property (nonatomic, retain)NSString *followerCount_num;
@property (nonatomic, retain)NSString *serializeWordCount_num;
@property (nonatomic, retain)NSString *updated;
@property (nonatomic, retain)NSString *lastChapter;
@property (nonatomic, retain)NSString *tags_arr;

// 数据库

@property (nonatomic, retain)NSString *dirctStr;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)NSInteger chaper;


@property (nonatomic, assign)BOOL collapse;


- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
