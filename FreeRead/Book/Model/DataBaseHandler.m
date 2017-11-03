//
//  DataBaseHandler.m
//  FreeRead
//
//  Created by lanou3g on 15/4/27.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import "DataBaseHandler.h"

@implementation DataBaseHandler

+ (DataBaseHandler *)shareInstance
{
    static DataBaseHandler *dbHander = nil;
    if (dbHander == nil) {
        dbHander = [[DataBaseHandler alloc] init];
    }
    
    return dbHander;
}

- (void)judgeResult:(int)result type:(NSString *)type
{
    if (result == SQLITE_OK) {
        NSLog(@"%@成功", type);
    } else {
        NSLog(@"%@失败, 失败编号: %d", type, result);
    }
}

- (void)openDB
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"freeRead.db"];
    NSLog(@"   %@", dbPath);
    int result = sqlite3_open([dbPath UTF8String], &dbPoint);
    [self judgeResult:result type:@"打开数据库"];
}

- (void)closeDB
{
    int result = sqlite3_close(dbPoint);
    [self judgeResult:result type:@"关闭数据库"];
}

- (void)createTable
{
    NSString *sqlStr = @"create table smallmakeupdata (title text, imageStr text, dirctStr text, chaper integer, page integer, _id text primary key)";
    int result = sqlite3_exec(dbPoint, [sqlStr UTF8String], NULL, NULL , NULL);
    [self judgeResult:result type:@"创建小说表"];
}

- (void)deleteSmall:(SmallMakeUpData *)small
{
    NSString *sqlStr = [NSString stringWithFormat:@"delete from smallmakeupdata where _id = '%@'", small._id];
    int result = sqlite3_exec(dbPoint, [sqlStr UTF8String], NULL, NULL , NULL);
    [self judgeResult:result type:@"删除小说数据"];
}

- (void)insertSmal:(SmallMakeUpData *)smal
{
    NSString *sqlStr = [NSString stringWithFormat:@"insert into smallmakeupdata values('%@', '%@', '%@', %ld, %ld, '%@')", smal.title, smal.imageStr, smal.dirctStr, smal.chaper, smal.page, smal._id];
    int result = sqlite3_exec(dbPoint, [sqlStr UTF8String], NULL, NULL , NULL);
    [self judgeResult:result type:@"插入小说数据"];
}

- (NSMutableArray *)selectAll
{
    NSString *sqlStr = @"select * from smallmakeupdata";
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare(dbPoint, [sqlStr UTF8String], -1, &stmt, NULL);
    NSMutableArray *smallArr = [NSMutableArray array];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            SmallMakeUpData *small = [[SmallMakeUpData alloc] init];
            const unsigned char *titleChar = sqlite3_column_text(stmt, 0);
            NSString *title = [NSString stringWithUTF8String:(const char *) titleChar];
            small.title = title;
            
            const unsigned char *imageChar = sqlite3_column_text(stmt, 1);
            NSString *image = [NSString stringWithUTF8String:(const char *) imageChar];
            small.imageStr = image;
            
            const unsigned char *dirctChar = sqlite3_column_text(stmt, 2);
            NSString *dirct = [NSString stringWithUTF8String:(const char *) dirctChar];
            small.dirctStr = dirct;
            
            small.chaper = sqlite3_column_int(stmt, 3);
    
            small.page = sqlite3_column_int(stmt, 4);
            
            const unsigned char *_idChar = sqlite3_column_text(stmt, 5);
            
            NSString *_id = [NSString stringWithUTF8String:(const char *) _idChar];
            small._id = _id;
            
            [smallArr addObject:small];
            
        }
    }
    
    sqlite3_finalize(stmt);
    return smallArr;
}

- (BOOL)haveOrNo:(SmallMakeUpData *)small
{
    NSMutableArray *arr = [self selectAll];
    BOOL flage = NO;
    for (SmallMakeUpData *data in arr) {
        if ([data._id isEqualToString:small._id]) {
            flage = YES;
            break;
        } else {
            flage = NO;
        }
    }
    return flage;
}

- (BOOL)sousuoWithID:(NSString *)_id
{
    BOOL flage = NO;
    NSMutableArray *arr = [self selectAll];
    for (SmallMakeUpData *data in arr) {
        if ([data._id isEqualToString:_id]) {
            flage = YES;
            break;
        }
    }
    return flage;
}

- (SmallMakeUpData *)smallWithID:(NSString *)_id
{
    SmallMakeUpData *small = [[SmallMakeUpData alloc] init];
    NSMutableArray *arr = [self selectAll];
    for (SmallMakeUpData *data in arr) {
        if ([data._id isEqualToString:_id]) {
            small = data;
            break;
        }
    }
    return small;
}

- (void)changeWithSmall:(SmallMakeUpData *)small
{
    SmallMakeUpData *tempSmall = [[SmallMakeUpData alloc] init];
    tempSmall = small;
    NSMutableArray *arr = [self selectAll];
    for (SmallMakeUpData *data in arr) {
        if ([data._id isEqualToString:small._id]) {
            [self deleteSmall:small];
            [self insertSmal:tempSmall];
            break;
        }
    }
    
}


@end
