//
//  DataBaseHandler.h
//  FreeRead
//
//  Created by lanou3g on 15/4/27.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "SmallMakeUpData.h"

@interface DataBaseHandler : NSObject
{
    sqlite3 *dbPoint;
}

+ (DataBaseHandler *)shareInstance;

- (void)openDB;

- (void)closeDB;

- (void)createTable;

- (void)insertSmal:(SmallMakeUpData *)smal;

- (NSMutableArray *)selectAll;

- (void)deleteSmall:(SmallMakeUpData *)small;

- (BOOL)haveOrNo:(SmallMakeUpData *)small;

- (BOOL)sousuoWithID:(NSString *)_id;

- (SmallMakeUpData *)smallWithID:(NSString *)_id;

- (void)changeWithSmall:(SmallMakeUpData *)small;
@end
