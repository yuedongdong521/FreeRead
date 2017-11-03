//
//  DirectoryData.h
//  FreeRead
//
//  Created by lanou3g on 15/4/24.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DirectoryData : NSObject

@property (nonatomic, retain)NSString *title;
@property (nonatomic, retain)NSString *link;
@property (nonatomic, assign)BOOL unreadble;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
