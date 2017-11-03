//
//  CmSQlite.m
//  ISspeex
//
//  Created by Administrator on 13-1-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "CmSQlite.h"
#import "CmDefine.h"
#include "common/sdk/utilities/inc/macros_mobile_common_defines.hpp"

@implementation CmSQlite

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)dealloc {
    
}

- (NSString *)conversionLibraryImagePathOne:(NSString *)imagePath {
    NSString *libraryString = @"Library";
    NSRange range = [imagePath rangeOfString:libraryString];
    if (range.location != NSNotFound) {
        NSUInteger len = range.location+[libraryString length]+1;
        if (len > [imagePath length]) {
            return nil;
        }
        NSString *subString = [imagePath substringFromIndex:len];
        NSArray *libraryPaths = kLibraryPath;
        NSString *libraryPath = [libraryPaths objectAtIndex:0];
        NSString *lbFilePath = [libraryPath stringByAppendingPathComponent:subString];
        return lbFilePath;
    }
    else {
        return nil;
    }
}

- (NSString *)libraryPathSearchPath {
    NSArray *paths = kCachesPath;
	NSString *cachesPath = [paths objectAtIndex:0];
    NSString *fileDirectory = [cachesPath stringByAppendingPathComponent:kApplicationSupportName];
    return fileDirectory;
}
- (NSString *)getPath:(NSString *)libraryPath sqlName:(NSString *)sqlName {
    return [libraryPath stringByAppendingPathComponent:sqlName];
}

-(BOOL)checkTableName:(NSString *)name{
    
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) FROM sqlite_master where type='table' and name='%@';",name];
    const char *sql_stmt = [sql UTF8String];
    
    char *err;
    if(sqlite3_exec(database, sql_stmt, NULL, NULL, &err) == 1){
        return YES;
    }else{
        return NO;
    }
}
/**********************SQLite*********************/
#pragma mark 创建SQL {
//创建UserInfoTable{
//在kUserInfoSqlName里创建表
//1.创建表格，假设有5个字段:（id，ImageUrl，UseName，AccountNumber，PasswordNumber）
//2.id为表格的主键，必须有。
//3.ImageUrl，UseName，AccountNumber，PasswordNumber都是字符串
- (void)createUserInfoTable:(sqlite3 *)db{
    char *sql ="CREATE TABLE UserInfoTable (id integer primary key autoincrement, \
                                           UserId integer, \
                                           UserSId integer, \
                                           UserClientType integer, \
                                           UserSex integer, \
                                           UserNickname text, \
                                           UserSignature text, \
                                           UserSignatureIconIndex integer, \
                                           UserScoreNumber integer, \
                                           UserImagePath text, \
                                           UserIconIndex integer, \
                                           UserAccount text, \
                                           UserPassword text, \
                                           UserState integer, \
                                           UserBirthday text, \
                                           UserProvince int, \
                                           UserCity int, \
                                           UserLocation text)";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK) {
        //NSLog(@"Error:create UserInfoTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:create UserInfoTable");
    }
    //NSLog(@"Create table 'UserInfoTable' successed.");
}
- (void)alterUserInfoTable:(sqlite3 *)db {
    char *sql = "ALTER TABLE UserInfoTable ADD UserThirdpartyAuthkey text";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK) {
        //NSLog(@"Error:create UserInfoTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:alter UserInfoTable");
    }
    //NSLog(@"Alter table 'UserInfoTable' successed.");
}
- (void)alterUserInfoTableTwo:(sqlite3 *)db {
    char *sql = "ALTER TABLE UserInfoTable ADD UserBgImagePath text";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK) {
        //NSLog(@"Error:create UserInfoTable Two failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:alter UserInfoTable Two");
    }
    //NSLog(@"Alter table 'UserInfoTable' Two successed.");
}
- (void)alterUserInfoTableThree:(sqlite3 *)db {
    char *sql = "ALTER TABLE UserInfoTable ADD UserPhotoCount integer";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK) {
        //NSLog(@"Error:create UserInfoTable Three failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:alter UserInfoTable Three");
    }
    //NSLog(@"Alter table 'UserInfoTable' Three successed.");
}
//}
//创建kUserInfoExtensionSqlName{
- (void)createUserInfoExtensionTable:(sqlite3 *)db {
    char *sql = "CREATE TABLE UserInfoExtensionTable (id integer primary key autoincrement, \
                                                     UserId integer, \
                                                     expenditureLevel integer, \
                                                     activeLevel integer, \
                                                     subLevel integer)";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK) {
        //NSLog(@"Error:create UserInfoExtensionTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:create UserInfoExtensionTable");
    }
    //NSLog(@"Create table 'UserInfoExtensionTable' successed.");
}
//}
//创建kCFriendSqlName {
//SymbolFlag:0表示减，1是加
- (void)createRYChatPayTable:(sqlite3 *)db {
    char *sql = "CREATE TABLE RYChatPayTable (id integer primary key autoincrement, \
                                             MyUId integer, \
                                             UserUId integer, \
                                             MsgId integer, \
                                             SymbolFlag integer, \
                                             Amount integer)";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK) {
        //NSLog(@"Error:create UserInfoTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:create RYChatPayTable");
    }
    //NSLog(@"Create table 'RYChatPayTable' successed.");
}
//}
//在kFriendSqlName里创建表 {
//创建FriendTable {
//1.FriendStatus目前表示有-新人,等待同意添加中，同意添加中，已添加，被拒绝添加，已过期
//2.FriendOldStatus目前表示-已是好友
//3.FriendVerifyText目前在好友发送一个添加好友请求，需要验证时可能会有这信息
- (void)createFriendTable:(sqlite3 *)db {
    char *sql = "CREATE TABLE FriendTable (id integer primary key autoincrement, \
                                          FriendId integer, \
                                          FriendSId integer, \
                                          FriendClientType integer, \
                                          FriendForMyId integer, \
                                          FriendRemarksName text, \
                                          FriendAddStatus integer, \
                                          FriendOldStatus integer, \
                                          FriendVerifyText text, \
                                          FriendSequenceNumber text, \
                                          FriendExtendInfo text, \
                                          FriendShieldingMessage integer)";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK) {
        //NSLog(@"Error:create FriendTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:create FriendTable");
    }
    //NSLog(@"Create table 'FriendTable' successed.");
}
- (void)alterFriendTable:(sqlite3 *)db {
    char *sql = "ALTER TABLE FriendTable ADD FriendSessionTime integer";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK) {
        //NSLog(@"Error:create FriendTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:alter FriendTable");
    }
    //NSLog(@"Alter table 'FriendTable' successed.");
}
//}
//在kFriendInfoSqlName里创建表 {
//创建FriendInfoTable {
//1.FriendPhoneName是手机通讯录上的name
//2.FriendIShowName是iShow用户的name
//3.FriendRemarksName是备注名
//没有第三条的name就显示第一条的name，也么有时，显示第二条的name
- (void)createFriendInfoTable:(sqlite3 *)db {
    char *sql = "CREATE TABLE FriendInfoTable (id integer primary key autoincrement, \
                                              FriendId integer, \
                                              FriendSId integer, \
                                              FriendClientType integer, \
                                              FriendPhoneName text, \
                                              FriendIShowName text, \
                                              FriendSex integer, \
                                              FriendSignature text, \
                                              FriendScore integet, \
                                              FriendIconPath text, \
                                              FriendBirthday text, \
                                              FriendProvince integer, \
                                              FriendCity integer, \
                                              FriendLocation text, \
                                              FriendPhone integer, \
                                              FriendSource text, \
                                              FriendPhoneRecordId integer, \
                                              FriendIconIndex integer)";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK) {
        //NSLog(@"Error:create FriendInfoTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:create FriendInfoTable");
    }
    //NSLog(@"Create table 'FriendInfoTable' successed.");
}
- (void)alterFriendInfoTable:(sqlite3 *)db {
    char *sql = "ALTER TABLE FriendInfoTable ADD FriendBgImagePath text";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK) {
        //NSLog(@"Error:create FriendInfoTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:alter FriendInfoTable");
    }
    //NSLog(@"Alter table 'FriendInfoTable' successed.");
}
- (void)alterFriendInfoTableTwo:(sqlite3 *)db {
    char *sql = "ALTER TABLE FriendInfoTable ADD FriendPhotoCount integer";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK) {
        //NSLog(@"Error:create FriendInfoTable Two failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:alter FriendInfoTable Two");
    }
    //NSLog(@"Alter table 'FriendInfoTable' Two successed.");
}
//}
//创建SessionTable {
//这里的FriendId与FriendClientType是与上下表联系的
- (void)createSessionTable:(sqlite3 *)db{
    char *sql = "CREATE TABLE SessionTable (id integer primary key autoincrement, \
                                             FriendId integer, \
                                             FriendClientType integer, \
                                             FriendForMyId integer, \
                                             SessionTime integer)";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK) {
        //NSLog(@"Error:create SessionTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:create SessionTable");
    }
    //NSLog(@"Create table 'SessionTable' successed.");
}
-(void)alterSessionTable:(sqlite3*)db
{
    char*sql="ALTER TABLE SessionTable ADD ChatDraft text";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK)
    {
        //NSLog(@"Error:create SessionTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:alter SessionTable");
    }
    //NSLog(@"Alter table 'SessionTable' successed.");
}
-(void)alterSessionTableTwo:(sqlite3*)db
{
    char*sql="ALTER TABLE SessionTable ADD ChatFlg integer";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK)
    {
        //NSLog(@"Error:create SessionTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:alter SessionTable");
    }
    //NSLog(@"Alter table 'SessionTable' successed.");
}
-(void)alterSessionTableThree:(sqlite3*)db
{
    char*sql="ALTER TABLE SessionTable ADD fireFlg integer";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK)
    {
        //NSLog(@"Error:create SessionTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:alter SessionTable");
    }
    //NSLog(@"Alter table 'SessionTable' successed.");
}
//}
//创建ChatRecordTable {
//FriendId:好友id(type_base_id_int类型)，也可以作用于一些sql表的关联
//FriendClientType:好友客户端类型(int类型)，如：2标识用iphone在登录
//FriendForMyId:自己该帐号的id，也可以作用于其它消息
//ChatContent:聊天内容，有可能是一个图片地址，接收到的消息包含图片，download成功时会替换里面的地址为本地的
//ChatImagePath:图片下载完之后的地址
//ChatDatetimeSring:聊天时间,也可以作用于这条消息的更新
//ChatIsSelfTag:判断，这条消息是自己发送的还是接收于好友的，界面上聊天展示用
//ChatFlg:其它情况，如图片下载失败还是成功，上传成功还是失败，默认是0，无情况
//chatSendFlg:消息发送失败还是成功,还是发送中
//ChatUnread:接收到的消息，是未读还是已读
//ChatImageCount:一位好友聊天总共发送的图片数量
//ChatType:消息的类型
- (void)createChatRecordTable:(sqlite3 *)db {
    char *sql = "CREATE TABLE ChatRecordTable (id integer primary key autoincrement, \
                                              FriendId integer, \
                                              FriendClientType integer, \
                                              ChatContent text, \
                                              ChatDatetimeSring text, \
                                              ChatIsSelfTag integer, \
                                              FriendForMyId integer, \
                                              ChatFlg integer, \
                                              ChatUnread integer, \
                                              ChatSendFlg integer, \
                                              ChatImageCount integer, \
                                              ChatType integer, \
                                              ChatImagePath text, \
                                              ChatThumbnailImagePath text)";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK) {
        //NSLog(@"Error:create ChatRecordTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:create ChatRecordTable");
    }
    //NSLog(@"Create table 'ChatRecordTable' successed.");
}
-(void)alterChatRecordTable:(sqlite3*)db
{
    char*sql="ALTER TABLE ChatRecordTable ADD AudioMessageisUnRead integer";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK)
    {
        //NSLog(@"Error:create ChatRecordTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:alter ChatRecordTable");
    }
    //NSLog(@"Alter table 'ChatRecordTable' successed.");
}
-(void)alterChatRecordTableTwo:(sqlite3*)db
{
    char*sql="ALTER TABLE ChatRecordTable ADD GuIdString text";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK)
    {
        //NSLog(@"Error:create ChatRecordTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:alter ChatRecordTable");
    }
    //NSLog(@"Alter table 'ChatRecordTable' successed.");
}
-(void)alterChatRecordTableThree:(sqlite3*)db
{
    char*sql="ALTER TABLE ChatRecordTable ADD ChatMessageId integer";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK)
    {
        //NSLog(@"Error:create ChatRecordTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:alter ChatRecordTable");
    }
    //NSLog(@"Alter table 'ChatRecordTable' successed.");
}
-(void)alterChatRecordTableFour:(sqlite3*)db
{
    char*sql="ALTER TABLE ChatRecordTable ADD GuIdOriginal text";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK)
    {
        //NSLog(@"Error:create ChatRecordTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:alter ChatRecordTable");
    }
    //NSLog(@"Alter table 'ChatRecordTable' successed.");
}
//}
//创建ChatRecordImageIndexTable {
- (void)createChatRecordImageIndexTable:(sqlite3 *)db {
    char *sql = "CREATE TABLE ChatRecordImageIndexTable (id integer primary key autoincrement, \
                                                        FriendId integer, \
                                                        FriendForMyId integer, \
                                                        ImageIndex integer)";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK) {
        //NSLog(@"Error:create RecordImageIndexTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:create RecordImageIndexTable");
    }
    //NSLog(@"Create table 'RecordImageIndexTable' successed.");
}
//}
//创建ShowGroupTable {
- (void)createShowGroupTable:(sqlite3 *)db {
    char *sql = "CREATE TABLE ShowGroupTable (id integer primary key autoincrement, \
                                              ShowGroupId integer, \
                                              ShowGroupIconPath text, \
                                              ShowGroupContent text, \
                                              ShowGroupDetailSring text, \
                                              showGroupVerification integer)";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK) {
        //NSLog(@"Error:create ShowGroupTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:create ShowGroupTable");
    }
    //NSLog(@"Create table 'ShowGroupTable' successed.");
}
//}
//创建Shield {
- (void)createShieldTable:(sqlite3 *)db {
    char *sql = "CREATE TABLE ShieldTable (id integer primary key autoincrement, \
                                          UserId integer, \
                                          MyId integer,\
                                          ShieldFlg integer)";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK) {
        //NSLog(@"Error:create ShieldTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:create ShieldTable");
    }
    //NSLog(@"Create table 'ShieldTable' successed.");
}
//}
//TransactionMessageTable
- (void)createTransactionMessageTable:(sqlite3 *)db {
    char * sql = "CREATE TABLE TransactionMessageTable (id integer primary key autoincrement, \
                                                       UId text,\
                                                       Transaction_Receipt text,\
                                                       Product_Identifier text,\
                                                       TransactionIdentifier text)";
    sqlite3_stmt * statement;
    if(sqlite3_prepare_v2(db, sql, -1, &statement, nil) != SQLITE_OK) {
        //NSLog(@"Error:create TransactionMessageTable failed");
    }
    int success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    if (success != SQLITE_DONE) {
        //NSLog(@"Error: failed to dehydrate:create TransactionMessageTable");
    }
    //NSLog(@"Create table 'TransactionMessageTable' successed.");
}
//创建表 {
- (void)createSqlite:(NSString *)sqlName sqlTableCategory:(int)sqlTableCategory {
    // Override point for customization after application launch.
    //在library文件夹下创建Application Support文件夹，并在其下创建数据库
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fileString = [self libraryPathSearchPath];
    BOOL success = [fileManager fileExistsAtPath:fileString];
    if (!success) {
        [fileManager createDirectoryAtPath:fileString withIntermediateDirectories:NO attributes:nil error:nil];
    }
    else {
        //NSLog(@"createSqlite-Application Support目录已存在");
    }
    NSString *dbPath = [self getPath:fileString sqlName:sqlName];
    success = [fileManager fileExistsAtPath:dbPath];
    if (!success) {
        if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
            if (sqlTableCategory == 0) {
                //[self copyDatabase:fileSql sqlName:sqlName];//将sql复制到Library下
            }
            else if (sqlTableCategory == 1) {
                [self createUserInfoTable:database];
            }
            else if (sqlTableCategory == 2) {
                [self createFriendTable:database];
                [self createFriendInfoTable:database];
                [self createSessionTable:database];
                [self createChatRecordTable:database];
                [self createChatRecordImageIndexTable:database];
                //[self createShowGroupTable:database];
            }
            else if (sqlTableCategory == 3) {
                
            }
            else if (sqlTableCategory == 4) {
                [self createShieldTable:database];
            }
            else if(sqlTableCategory == 5) {
                
            }
            else if(sqlTableCategory == 6) {
                [self createTransactionMessageTable:database];
            }
            else if(sqlTableCategory == 7) {
                
            }
            else if(sqlTableCategory == 8) {
                [self createUserInfoExtensionTable:database];
            }
            else if (sqlTableCategory == 9) {
                [self createRYChatPayTable:database];
            }
            sqlite3_close(database);
        }
    }
    else {
//        NSDictionary * sdsda = [fileManager attributesOfItemAtPath:dbPath error:nil];
//        NSString *kString = [sdsda objectForKey:NSFileProtectionKey];
//        if (![kString isEqualToString:NSFileProtectionNone]) {
//            NSDictionary *attributes = [NSDictionary dictionaryWithObject:NSFileProtectionNone
//                                                                   forKey:NSFileProtectionKey];
//            [[NSFileManager defaultManager] setAttributes:attributes
//                                             ofItemAtPath:dbPath
//                                                    error:nil];
//        }
        //NSLog(@"%@已存在",sqlName);
    }
}
//}
//表里添加列 {
- (void)addRowToSqlite:(NSString *)sqlName sqlTableCategory:(int)sqlTableCategory {
    NSString *fileString = [self libraryPathSearchPath];
    NSString *dbPath = [self getPath:fileString sqlName:sqlName];
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        if (sqlTableCategory == SQL_IF_TYPE_FIRST) {
            [self alterUserInfoTable:database];
        }
        else if (sqlTableCategory == SQL_IF_TYPE_SECOND) {
            [self alterFriendTable:database];
        }
        else if (sqlTableCategory==SQL_IF_TYPE_THIRD)
        {
            [self alterFriendInfoTable:database];
            [self alterFriendInfoTableTwo:database];
        }
        else if (sqlTableCategory==SQL_IF_TYPE_FOUR)
        {
            [self alterUserInfoTableTwo:database];
            [self alterUserInfoTableThree:database];
        }
        else if (sqlTableCategory==SQL_IF_TYPE_FIVE) {
            [self alterChatRecordTable:database];
        }
        else if (sqlTableCategory==SQL_IF_TYPE_SIX) {
            [self alterChatRecordTableTwo:database];
        }
        else if (sqlTableCategory==SQL_IF_TYPE_SEVEN) {
            [self alterSessionTable:database];
        }
        else if (sqlTableCategory==SQL_IF_TYPE_EIGHT) {
            [self alterChatRecordTableThree:database];
        }
        else if (sqlTableCategory==SQL_IF_TYPE_NINE){
            [self alterSessionTableTwo:database];
        }
        else if (sqlTableCategory==SQL_IF_TYPE_TEN)
        {
            
        }
        else if (sqlTableCategory==SQL_IF_TYPE_ELEVEN)
        {
//            [self alterSessionTableThree:database];  //fireFlag不需要  zzy 08-17
            [self alterChatRecordTableFour:database];
        }
        else if (sqlTableCategory == SQL_IF_TYPE_TWELVE)
        {
            
        }
        
        sqlite3_close(database);
    }
}
//}
#pragma mark }
#pragma mark 使用SQL {
/***打开sql***/
- (BOOL)openSqllite:(NSString *)sqlPath {
    if (sqlite3_open([sqlPath UTF8String], &database) != SQLITE_OK) {//SQLITE_OPEN_NOMUTEX
        //NSLog(@"openSqllite:%d",sqlite3_open([sqlPath UTF8String], &database));
		sqlite3_close(database);
		return NO;
	}
    return YES;
}
- (BOOL)openSqlliteTwo:(NSString *)sqlPath {
	if (sqlite3_open_v2([sqlPath UTF8String], &database, SQLITE_OPEN_NOMUTEX, NULL) != SQLITE_OK) {//SQLITE_OPEN_NOMUTEX
		sqlite3_close(database);
		return NO;
	}
    return YES;
}
- (BOOL)openSqlliteForUserInfoSql {
    NSString *libraryPath = [self libraryPathSearchPath];
    NSString *dbPath = [self getPath:libraryPath sqlName:kUserInfoSqlName];
    BOOL isOpen = [self openSqllite:dbPath];
    return isOpen;
}
- (BOOL)openSqlliteForUserInfoExtensionSql {
    NSString *libraryPath = [self libraryPathSearchPath];
    NSString *dbPath = [self getPath:libraryPath sqlName:kUserInfoExtensionSqlName];
    BOOL isOpen = [self openSqllite:dbPath];
    return isOpen;
}
- (BOOL)openSqlliteForFriendInfoSql {
    NSString *libraryPath = [self libraryPathSearchPath];
    NSString *dbPath = [self getPath:libraryPath sqlName:kFriendInfoSqlName];
    BOOL isOpen = [self openSqllite:dbPath];
    return isOpen;
}
- (BOOL)openSqlliteForShieldSql {
    NSString *libraryPath = [self libraryPathSearchPath];
    NSString *dbPath = [self getPath:libraryPath sqlName:kShieldSqlName];
    BOOL isOpen = [self openSqllite:dbPath];
    return isOpen;
}
- (BOOL)openTransactionMessageSql{
    NSString *libraryPath = [self libraryPathSearchPath];
    NSString *dbPath = [self getPath:libraryPath sqlName:kTransactionMessage];
    BOOL isOpen = [self openSqllite:dbPath];
    return isOpen;
}
- (BOOL)openSqlliteForCFriendSql {
    NSString *libraryPath = [self libraryPathSearchPath];
    NSString *dbPath = [self getPath:libraryPath sqlName:kCFriendSqlName];
    BOOL isOpen = [self openSqllite:dbPath];
    return isOpen;
}
- (void)closeSqllite {
    sqlite3_close(database);
}
#pragma mark User sql table {
/*
 参数:stateFlg 登录现状，多帐号管理
     useId    用户内部id
     type     执行的条件类别
*/
- (NSMutableArray *)sqlSelectfromUserInformationTbaleForState:(int)stateFlg useId:(type_base_id_int)useId type:(int)type {
    NSMutableArray *mtbArray = [[NSMutableArray alloc] init];
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"SELECT * FROM UserInfoTable";
    }
    else if (type == SQL_IF_TYPE_SECOND) {
        queryString = @"SELECT * FROM UserInfoTable WHERE UserState = ?";
    }
    else {
        queryString = @"SELECT * FROM UserInfoTable WHERE UserId = ?";
    }
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            
        }
        else if (type == SQL_IF_TYPE_SECOND) {
            sqlite3_bind_int(statement, 1, stateFlg);
        }
        else {
            sqlite3_bind_int(statement, 1, useId);
        }
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //①
            type_base_id_int userId = sqlite3_column_int(statement, 1);
            type_base_id_int userSId = sqlite3_column_int(statement, 2);
            int userClientType = sqlite3_column_int(statement, 3);
            int userSex = sqlite3_column_int(statement, 4);
            char *userNickname = (char *)sqlite3_column_text(statement, 5);
            char *userSignature = (char *)sqlite3_column_text(statement, 6);
            int userSignatureIconIndex = sqlite3_column_int(statement, 7);
            type_base_id_int userScoreNumber = sqlite3_column_int(statement, 8);
            char *userImagePath = (char *)sqlite3_column_text(statement, 9);
            int userIconIndex = sqlite3_column_int(statement, 10);
            char *userAccount = (char *)sqlite3_column_text(statement, 11);
            char *userPassword = (char *)sqlite3_column_text(statement, 12);
            int userState = sqlite3_column_int(statement, 13);
            char *userBirthday = (char *)sqlite3_column_text(statement, 14);
            int userProvince = sqlite3_column_int(statement, 15);
            int userCity = sqlite3_column_int(statement, 16);
            char *userLocation = (char *)sqlite3_column_text(statement, 17);
            char *userThirdpartyAuthkey = (char *)sqlite3_column_text(statement, 18);
            char *userBgImagePath = (char *)sqlite3_column_text(statement, 19);
            int userPhotoCount = sqlite3_column_int(statement, 20);
            //②
            AppDelegatePlatformUserStructure *appDelegatePlatformUserStructure = [[AppDelegatePlatformUserStructure alloc] init];
            appDelegatePlatformUserStructure.platformUserId = userId;
            appDelegatePlatformUserStructure.platformViewId = userSId;
            appDelegatePlatformUserStructure.platformUserClientType = userClientType;
            appDelegatePlatformUserStructure.platformUserSexFlg = userSex;
            NSString *string1 = [NSString stringWithUTF8String:userNickname];
            if (![string1 isEqualToString:kSqlForFieldEmpty]) {
                appDelegatePlatformUserStructure.platformUserNicknameString = string1;
            }
            NSString *string2 = [NSString stringWithUTF8String:userSignature];
            if (![string2 isEqualToString:kSqlForFieldEmpty]) {
                appDelegatePlatformUserStructure.platformUserSignatureString = string2;
            }
            appDelegatePlatformUserStructure.platformUserSignatureIconIndex = userSignatureIconIndex;
            appDelegatePlatformUserStructure.platformUserScoreNumber = userScoreNumber;
            NSString *string3 = [NSString stringWithUTF8String:userImagePath];
            if (![string3 isEqualToString:kSqlForFieldEmpty]) {
                NSString *lbImageFilePath = [self conversionLibraryImagePathOne:string3];
                if (lbImageFilePath == nil) {
                    lbImageFilePath = string3;
                }
                appDelegatePlatformUserStructure.selfIconPathString = lbImageFilePath;
            }
            appDelegatePlatformUserStructure.selfIconIndex = userIconIndex;
            NSString *string4 = [NSString stringWithUTF8String:userAccount];
            if (![string4 isEqualToString:kSqlForFieldEmpty]) {
                appDelegatePlatformUserStructure.selfAccountString = string4;
            }
            NSString *string5 = [NSString stringWithUTF8String:userPassword];
            if (![string5 isEqualToString:kSqlForFieldEmpty]) {
                appDelegatePlatformUserStructure.selfPasswordString = string5;
            }
            appDelegatePlatformUserStructure.selfState = userState;
            NSString *string6 = [NSString stringWithUTF8String:userBirthday];
            if (![string6 isEqualToString:kSqlForFieldEmpty]) {
                appDelegatePlatformUserStructure.platformBirthdayString = string6;
            }
            appDelegatePlatformUserStructure.selfProvinceType = userProvince;
            appDelegatePlatformUserStructure.selfCityType = userCity;
            NSString *string7 = [NSString stringWithUTF8String:userLocation];
            if (![string7 isEqualToString:kSqlForFieldEmpty]) {
                appDelegatePlatformUserStructure.platformUserLocationString = string7;
            }
            NSString *string8 = [NSString stringWithUTF8String:userThirdpartyAuthkey];
            if (![string8 isEqualToString:kSqlForFieldEmpty]) {
                appDelegatePlatformUserStructure.selfAuthkeyString = string8;
            }
            NSString *string9 = [NSString stringWithUTF8String:userBgImagePath];
            if ([string9 length] > 0) {
                NSString *lbImageFilePath = [self conversionLibraryImagePathOne:string9];
                if (lbImageFilePath == nil) {
                    lbImageFilePath = string9;
                }
                appDelegatePlatformUserStructure.selfBgImagePathString = lbImageFilePath;
            }
            appDelegatePlatformUserStructure.selfPhotoCount = userPhotoCount;
            [mtbArray addObject:appDelegatePlatformUserStructure];
        }
    }
    sqlite3_finalize(statement);
    return mtbArray;
}
/*
 参数:appDelegatePlatformUserStructure 用户信息结构
     type     执行的条件类别
*/
- (void)updateFromUserInfoTableForStructure:(AppDelegatePlatformUserStructure *)appDelegatePlatformUserStructure type:(int)type {
    //1.
    NSString *string1 = kSqlForFieldEmpty;
    if ([appDelegatePlatformUserStructure.selfIconPathString length] > 0) {
        string1 = appDelegatePlatformUserStructure.selfIconPathString;
    }
    NSString *string2 = kSqlForFieldEmpty;
    if ([appDelegatePlatformUserStructure.platformUserNicknameString length] > 0) {
        string2 = appDelegatePlatformUserStructure.platformUserNicknameString;
    }
    NSString *string3 = kSqlForFieldEmpty;
    if ([appDelegatePlatformUserStructure.platformUserSignatureString length] > 0) {
        string3 = appDelegatePlatformUserStructure.platformUserSignatureString;
    }
    NSString *string4 = kSqlForFieldEmpty;
    if ([appDelegatePlatformUserStructure.platformUserLocationString length] > 0) {
        string4 = appDelegatePlatformUserStructure.platformUserLocationString;
    }
    NSString *string5 = kSqlForFieldEmpty;
    if ([appDelegatePlatformUserStructure.platformBirthdayString length] > 0) {
        string5 = appDelegatePlatformUserStructure.platformBirthdayString;
    }
    NSString *string6 = kSqlForFieldEmpty;
    if ([appDelegatePlatformUserStructure.selfPasswordString length] > 0) {
        string6 = appDelegatePlatformUserStructure.selfPasswordString;
    }
    NSString *string7 = kSqlForFieldEmpty;
    if ([appDelegatePlatformUserStructure.selfAccountString length] > 0) {
        string7 = appDelegatePlatformUserStructure.selfAccountString;
    }
    NSString *string8 = kSqlForFieldEmpty;
    if ([appDelegatePlatformUserStructure.selfAuthkeyString length] > 0) {
        string8 = appDelegatePlatformUserStructure.selfAuthkeyString;
    }
    NSString *string9 = kSqlForFieldEmpty;
    if ([appDelegatePlatformUserStructure.selfBgImagePathString length] > 0) {
        string9 = appDelegatePlatformUserStructure.selfBgImagePathString;
    }
    //2.
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"UPDATE UserInfoTable SET UserImagePath=?,UserIconIndex = ? WHERE UserId = ?";
    }
    else if (type == SQL_IF_TYPE_SECOND) {
        queryString = @"UPDATE UserInfoTable SET UserNickname=?,UserSignature=?,UserSex=?,UserBirthday=?,UserProvince=?,UserCity=?,UserLocation=? WHERE UserId = ?";
    }
    else if (type == SQL_IF_TYPE_THIRD) {
        queryString = @"UPDATE UserInfoTable SET UserNickname=?,UserSignature=?,UserSex=? WHERE UserId = ?";
    }
    else if (type == SQL_IF_TYPE_FOUR) {
        queryString = @"UPDATE UserInfoTable SET UserProvince=?,UserCity=?,UserLocation=? WHERE UserId = ?";
    }
    else if (type == SQL_IF_TYPE_FIVE) {
        queryString = @"UPDATE UserInfoTable SET UserBirthday=? WHERE UserId = ?";
    }
    else if (type == SQL_IF_TYPE_SIX){
        queryString = @"UPDATE UserInfoTable SET UserState=? WHERE UserId = ?";
    }else if (type == SQL_IF_TYPE_SEVEN)
    {
        queryString = @"UPDATE UserInfoTable SET UserPassword=? WHERE UserAccount = ?";
    }else if (type == SQL_IF_TYPE_EIGHT) {
        queryString = @"UPDATE UserInfoTable SET UserSex = ?,UserNickname = ?,UserSignature = ?,UserSignatureIconIndex = ?,UserScoreNumber = ? ,UserIconIndex = ?,UserAccount = ?,UserPassword = ?,UserState = ?,UserThirdpartyAuthkey = ? WHERE UserId = ?";
    }
    else if (type == SQL_IF_TYPE_NINE) {//一开始给所有的用户初始一个默认值
        queryString = @"UPDATE UserInfoTable SET UserThirdpartyAuthkey = ?";
    }
    else if (type == SQL_IF_TYPE_TEN) {//一开始给所有的用户初始一个默认值
        queryString = @"UPDATE UserInfoTable SET UserBgImagePath = ?";
    }
    else if (type ==SQL_IF_TYPE_ELEVEN) {
        queryString = @"UPDATE UserInfoTable SET UserPhotoCount = ? WHERE UserId = ?";
    }
    else {
        queryString = @"UPDATE UserInfoTable SET UserBgImagePath = ? WHERE UserId = ?";
    }
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_text(stmt, 1, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, appDelegatePlatformUserStructure.selfIconIndex);
            sqlite3_bind_int(stmt, 3, appDelegatePlatformUserStructure.platformUserId);
        }
        else if (type == SQL_IF_TYPE_SECOND) {
            sqlite3_bind_text(stmt, 1, [string2 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 2, [string3 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 3, appDelegatePlatformUserStructure.platformUserSexFlg);
            sqlite3_bind_text(stmt, 4, [string5 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 5, appDelegatePlatformUserStructure.selfProvinceType);
            sqlite3_bind_int(stmt, 6, appDelegatePlatformUserStructure.selfCityType);
            sqlite3_bind_text(stmt, 7, [string4 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 8, appDelegatePlatformUserStructure.platformUserId);
        }
        else if (type == SQL_IF_TYPE_THIRD) {
            sqlite3_bind_text(stmt, 1, [string2 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 2, [string3 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 3, appDelegatePlatformUserStructure.platformUserSexFlg);
            sqlite3_bind_int(stmt, 4, appDelegatePlatformUserStructure.platformUserId);
        }
        else if (type == SQL_IF_TYPE_FOUR) {
            sqlite3_bind_int(stmt, 1, appDelegatePlatformUserStructure.selfProvinceType);
            sqlite3_bind_int(stmt, 2, appDelegatePlatformUserStructure.selfCityType);
            sqlite3_bind_text(stmt, 3, [string4 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 4, appDelegatePlatformUserStructure.platformUserId);
        }
        else if (type == SQL_IF_TYPE_FIVE) {
            sqlite3_bind_text(stmt, 1, [string5 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, appDelegatePlatformUserStructure.platformUserId);
        }
        else if (type == SQL_IF_TYPE_SIX){
            sqlite3_bind_int(stmt, 1, appDelegatePlatformUserStructure.selfState);
            sqlite3_bind_int(stmt, 2, appDelegatePlatformUserStructure.platformUserId);
        }else if (type == SQL_IF_TYPE_SEVEN){
            sqlite3_bind_text(stmt, 1, [string6 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 2, [string7 UTF8String], -1, SQLITE_TRANSIENT);
            
        }else if (type == SQL_IF_TYPE_EIGHT) {
            sqlite3_bind_int(stmt, 1, appDelegatePlatformUserStructure.platformUserSexFlg);
            sqlite3_bind_text(stmt, 2, [string2 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 3, [string3 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 4, appDelegatePlatformUserStructure.platformUserSignatureIconIndex);
            sqlite3_bind_int64(stmt, 5, appDelegatePlatformUserStructure.platformUserScoreNumber);
            sqlite3_bind_int(stmt, 6, appDelegatePlatformUserStructure.selfIconIndex);
            sqlite3_bind_text(stmt, 7, [string7 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 8, [string6 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 9, appDelegatePlatformUserStructure.selfState);
            sqlite3_bind_text(stmt, 10, [string8 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 11, appDelegatePlatformUserStructure.platformUserId);
        }
        else if (type == SQL_IF_TYPE_NINE) {
            sqlite3_bind_text(stmt, 1, [string8 UTF8String], -1, SQLITE_TRANSIENT);
        }
        else if (type == SQL_IF_TYPE_TEN) {
            sqlite3_bind_text(stmt, 1, [string9 UTF8String], -1, SQLITE_TRANSIENT);
        }
        else if (type ==SQL_IF_TYPE_ELEVEN)  {
            sqlite3_bind_int(stmt, 1, appDelegatePlatformUserStructure.selfPhotoCount);
            sqlite3_bind_int(stmt, 2, appDelegatePlatformUserStructure.platformUserId);
        }
        else {
            sqlite3_bind_text(stmt, 1, [string9 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, appDelegatePlatformUserStructure.platformUserId);
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updateFromUserInfoTableForStructure '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromUserInfoTableForStructure '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}
/*
 参数:selfLoginState 登录现状
     type     执行的条件类别
*/
- (void)updateFromUserInfoTableForState:(int)selfLoginState type:(int)type {
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"UPDATE UserInfoTable SET UserState=?";
    }
    else {
        queryString = @"UPDATE UserInfoTable SET UserState=?";
    }
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_int(stmt, 1, selfLoginState);
        }
        else {
            sqlite3_bind_int(stmt, 1, selfLoginState);
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updateFromUserInfoTableForState '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromUserInfoTableForState '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}
/*
 参数:appDelegatePlatformUserStructure 用户信息结构
*/
- (void)sqlInsertfromUserInformationTbale:(AppDelegatePlatformUserStructure *)appDelegatePlatformUserStructure {
    //1.
    NSString *string1 = kSqlForFieldEmpty;
    if ([appDelegatePlatformUserStructure.platformUserNicknameString length] > 0) {
        string1 = appDelegatePlatformUserStructure.platformUserNicknameString;
    }
    NSString *string2 = kSqlForFieldEmpty;
    if ([appDelegatePlatformUserStructure.platformUserSignatureString length] > 0) {
        string2 = appDelegatePlatformUserStructure.platformUserSignatureString;
    }
    NSString *string3 = kSqlForFieldEmpty;
    if ([appDelegatePlatformUserStructure.selfIconPathString length] > 0) {
        string3 = appDelegatePlatformUserStructure.selfIconPathString;
    }
    NSString *string4 = kSqlForFieldEmpty;
    if ([appDelegatePlatformUserStructure.selfAccountString length] > 0) {
        string4 = appDelegatePlatformUserStructure.selfAccountString;
    }
    NSString *string5 = kSqlForFieldEmpty;
    if ([appDelegatePlatformUserStructure.selfPasswordString length] > 0) {
        string5 = appDelegatePlatformUserStructure.selfPasswordString;
    }
    NSString *string6 = kSqlForFieldEmpty;
    if ([appDelegatePlatformUserStructure.platformUserLocationString length] > 0) {
        string6 = appDelegatePlatformUserStructure.platformUserLocationString;
    }
    NSString *string7 = kSqlForFieldEmpty;
    if ([appDelegatePlatformUserStructure.platformBirthdayString length] > 0) {
        string7 = appDelegatePlatformUserStructure.platformBirthdayString;
    }
    NSString *string8 = kSqlForFieldEmpty;
    if ([appDelegatePlatformUserStructure.selfAuthkeyString length] > 0) {
        string8 = appDelegatePlatformUserStructure.selfAuthkeyString;
    }
    NSString *string9 = kSqlForFieldEmpty;
    if ([appDelegatePlatformUserStructure.selfBgImagePathString length] > 0) {
        string9 = appDelegatePlatformUserStructure.selfBgImagePathString;
    }
    //2.
    char *insertDataChar = "INSERT OR REPLACE INTO UserInfoTable (UserId,UserSId,UserClientType,UserSex,UserNickname,UserSignature,UserSignatureIconIndex,UserScoreNumber,UserImagePath,UserIconIndex,UserAccount,UserPassword,UserState,UserBirthday,UserProvince,UserCity,UserLocation,UserThirdpartyAuthkey,UserBgImagePath,UserPhotoCount) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, insertDataChar , -1, &stmt, NULL) == SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, appDelegatePlatformUserStructure.platformUserId);
        sqlite3_bind_int(stmt, 2, appDelegatePlatformUserStructure.platformViewId);
        sqlite3_bind_int(stmt, 3, appDelegatePlatformUserStructure.platformUserClientType);
        sqlite3_bind_int(stmt, 4, appDelegatePlatformUserStructure.platformUserSexFlg);
        sqlite3_bind_text(stmt, 5, [string1 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 6, [string2 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(stmt, 7, appDelegatePlatformUserStructure.platformUserSignatureIconIndex);
        sqlite3_bind_int64(stmt, 8, appDelegatePlatformUserStructure.platformUserScoreNumber);
        sqlite3_bind_text(stmt, 9, [string3 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(stmt, 10, appDelegatePlatformUserStructure.selfIconIndex);
        sqlite3_bind_text(stmt, 11, [string4 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 12, [string5 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(stmt, 13, appDelegatePlatformUserStructure.selfState);
        sqlite3_bind_text(stmt, 14, [string7 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(stmt, 15, appDelegatePlatformUserStructure.selfProvinceType);
        sqlite3_bind_int(stmt, 16, appDelegatePlatformUserStructure.selfCityType);
        sqlite3_bind_text(stmt, 17, [string6 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 18, [string8 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(stmt, 19, [string9 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(stmt, 20, appDelegatePlatformUserStructure.selfPhotoCount);
        if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of sqlInsertfromUserInformationTbale '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of sqlInsertfromUserInformationTbale '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}
- (void)sqlDeletefromUserInformationTbale:(AppDelegatePlatformUserStructure *)appDelegatePlatformUserStructure {
    char *sql = "DELETE FROM UserInfoTable WHERE UserId = ?";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, appDelegatePlatformUserStructure.platformUserId);
        if (sqlite3_step(statement) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of sqlDeletefromUserInformationTbale '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of sqlDeletefromUserInformationTbale '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(statement);
}
#pragma mark }
#pragma mark UserInfoExtension sql table {
- (NSMutableArray *)sqlSelectfromUserInfoExtensionTbaleForUseId:(type_base_id_int)useId type:(int)type {
    NSMutableArray *mtbArray = [[NSMutableArray alloc] init];
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"SELECT * FROM UserInfoExtensionTable";
    }
    else if (type == SQL_IF_TYPE_SECOND) {
        queryString = @"SELECT * FROM UserInfoExtensionTable WHERE UserId = ?";
    }
    else {
        queryString = @"SELECT * FROM UserInfoExtensionTable WHERE UserId = ?";
    }
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            
        }
        else if (type == SQL_IF_TYPE_SECOND) {
            sqlite3_bind_int(statement, 1, useId);
        }
        else {
            sqlite3_bind_int(statement, 1, useId);
        }
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //①
            type_base_id_int userId = sqlite3_column_int(statement, 1);
            int expenditureLevel = sqlite3_column_int(statement, 2);
            int activeLevel = sqlite3_column_int(statement, 3);
            int subLevel = sqlite3_column_int(statement, 4);
            //②
            AppDelegatePlatformUserStructure *appDelegatePlatformUserStructure = [[AppDelegatePlatformUserStructure alloc] init];
            appDelegatePlatformUserStructure.platformUserId = userId;
            appDelegatePlatformUserStructure.expenditureLevel = expenditureLevel;
            appDelegatePlatformUserStructure.activeLevel = activeLevel;
            appDelegatePlatformUserStructure.subLevel = subLevel;
            [mtbArray addObject:appDelegatePlatformUserStructure];
        }
    }
    sqlite3_finalize(statement);
    return mtbArray;
}
- (void)sqlInsertfromUserInfoExtensionTbale:(AppDelegatePlatformUserStructure *)appDelegatePlatformUserStructure {
    //1.
//    NSString *string1 = kSqlForFieldEmpty;
//    if ([appDelegatePlatformUserStructure.expenditureVerifyCode length] > 0) {
//        string1 = appDelegatePlatformUserStructure.expenditureVerifyCode;
//    }
    //2.
    char *insertDataChar = "INSERT OR REPLACE INTO UserInfoExtensionTable (UserId,expenditureLevel,activeLevel,subLevel) VALUES (?,?,?,?)";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, insertDataChar , -1, &stmt, NULL) == SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, appDelegatePlatformUserStructure.platformUserId);
        sqlite3_bind_int(stmt, 2, appDelegatePlatformUserStructure.expenditureLevel);
        sqlite3_bind_int(stmt, 3, appDelegatePlatformUserStructure.activeLevel);
        sqlite3_bind_int(stmt, 4, appDelegatePlatformUserStructure.subLevel);
        
        if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of sqlInsertfromUserInfoExtensionTbale '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of sqlInsertfromUserInfoExtensionTbale '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}
- (void)updateFromUserInfoExtensionTableTable:(AppDelegatePlatformUserStructure *)appDelegatePlatformUserStructure type:(int)type {
//    NSString *string1 = kSqlForFieldEmpty;
//    if ([appDelegatePlatformUserStructure.expenditureVerifyCode length] > 0) {
//        string1 = appDelegatePlatformUserStructure.expenditureVerifyCode;
//    }
    //
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"UPDATE UserInfoExtensionTable SET expenditureLevel=?,activeLevel=?,subLevel=? WHERE UserId=?";
    }
    else {
        queryString = @"UPDATE UserInfoExtensionTable SET expenditureLevel=?,activeLevel=?,subLevel=? WHERE UserId=?";
    }
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_int(stmt, 1, appDelegatePlatformUserStructure.expenditureLevel);
            sqlite3_bind_int(stmt, 2, appDelegatePlatformUserStructure.activeLevel);
            sqlite3_bind_int(stmt, 3, appDelegatePlatformUserStructure.subLevel);
            sqlite3_bind_int(stmt, 4, appDelegatePlatformUserStructure.platformUserId);
        }
        else {
            sqlite3_bind_int(stmt, 1, appDelegatePlatformUserStructure.expenditureLevel);
            sqlite3_bind_int(stmt, 2, appDelegatePlatformUserStructure.activeLevel);
            sqlite3_bind_int(stmt, 3, appDelegatePlatformUserStructure.subLevel);
            sqlite3_bind_int(stmt, 4, appDelegatePlatformUserStructure.platformUserId);
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updateFromUserInfoExtensionTableTable '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromUserInfoExtensionTableTable '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}
#pragma mark }
#pragma mark RYChatPay sql table {
- (NSMutableArray *)sqlSelectfromRYChatPayForMyUId:(type_base_id_int)myUId UseUId:(type_base_id_int)useUId forMsgId:(unsigned long)msgId forSymbolFlag:(int)symbolFlag type:(int)type {
    NSMutableArray *mtbArray = [[NSMutableArray alloc] init];
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"SELECT * FROM RYChatPayTable WHERE MyUId = ? And UserUId = ?";
    }
    else if (type == SQL_IF_TYPE_SECOND) {
        queryString = @"SELECT * FROM RYChatPayTable WHERE MyUId = ? And UserUId = ? And MsgId = ?";
    }
    else {
        queryString = @"SELECT * FROM RYChatPayTable WHERE MyUId = ? And UserUId = ? And MsgId = ? And SymbolFlag = ?";
    }
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_int(statement, 1, myUId);
            sqlite3_bind_int(statement, 2, useUId);
        }
        else if (type == SQL_IF_TYPE_SECOND) {
            sqlite3_bind_int(statement, 1, myUId);
            sqlite3_bind_int(statement, 2, useUId);
            sqlite3_bind_int64(statement, 3, msgId);
        }
        else {
            sqlite3_bind_int(statement, 1, myUId);
            sqlite3_bind_int(statement, 2, useUId);
            sqlite3_bind_int64(statement, 3, msgId);
            sqlite3_bind_int(statement, 4, symbolFlag);
        }
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //①
            type_base_id_int MyUId = sqlite3_column_int(statement, 1);
            type_base_id_int UserUId = sqlite3_column_int(statement, 2);
            unsigned long MsgId = sqlite3_column_int64(statement, 3);
            int SymbolFlag = sqlite3_column_int(statement, 4);
            int Amount = sqlite3_column_int(statement, 5);
            //②
            NSString *myUidStr = [NSString stringWithFormat:@"%d", MyUId];
            NSString *toUidStr = [NSString stringWithFormat:@"%d", UserUId];
            NSString *msgIdStr = [NSString stringWithFormat:@"%lu", MsgId];
            NSString *symbol = [NSString stringWithFormat:@"%d", SymbolFlag];
            NSString *amout = [NSString stringWithFormat:@"%d", Amount];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:myUidStr,@"myuid",toUidStr,@"touid",msgIdStr,@"msgid",symbol, @"symbol",amout, @"amout", nil];
            [mtbArray addObject:dict];
        }
    }
    sqlite3_finalize(statement);
    return mtbArray;
}
- (void)sqlInsertfromRYChatPayTableForMyUId:(type_base_id_int)myUId UseUId:(type_base_id_int)useUId forMsgId:(unsigned long)msgId forSymbolFlag:(int)symbolFlag forAmount:(int)amount {
    //1.
    
    //2.
    char *insertDataChar = "INSERT OR REPLACE INTO RYChatPayTable (MyUId,UserUId,MsgId,SymbolFlag,Amount) VALUES (?,?,?,?,?)";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, insertDataChar , -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, myUId);
        sqlite3_bind_int(statement, 2, useUId);
        sqlite3_bind_int64(statement, 3, msgId);
        sqlite3_bind_int(statement, 4, symbolFlag);
        sqlite3_bind_int(statement, 5, amount);
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of sqlInsertfromRYChatPayTableForMyUId '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of sqlInsertfromRYChatPayTableForMyUId '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(statement);
}
- (void)updateFromRYChatPayTableForMyUId:(type_base_id_int)myUId UseUId:(type_base_id_int)useUId forMsgId:(unsigned long)msgId forSymbolFlag:(int)symbolFlag forAmount:(int)amount type:(int)type {
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"UPDATE RYChatPayTable SET SymbolFlag=?,Amount=? WHERE MyUId = ? And UserUId = ? And MsgId = ?";
    }
    else {
        queryString = @"UPDATE RYChatPayTable SET SymbolFlag=?,Amount=? WHERE MyUId = ? And UserUId = ? And MsgId = ?";
    }
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &statement, NULL) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_int(statement, 1, symbolFlag);
            sqlite3_bind_int(statement, 2, amount);
            sqlite3_bind_int(statement, 3, myUId);
            sqlite3_bind_int(statement, 4, useUId);
            sqlite3_bind_int64(statement, 5, msgId);
        }
        else {
            sqlite3_bind_int(statement, 1, symbolFlag);
            sqlite3_bind_int(statement, 2, amount);
            sqlite3_bind_int(statement, 3, myUId);
            sqlite3_bind_int(statement, 4, useUId);
            sqlite3_bind_int64(statement, 5, msgId);
        }
        if (sqlite3_step(statement) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updateFromRYChatPayTableForMyUId '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromRYChatPayTableForMyUId '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(statement);
}
#pragma mark }

#pragma mark Friend sql table {
//参数_friendId可以是FriendId，也可以是FriendSId
//参数friendForStatus可以是FriendAddStatus，也可以是FriendOldStatus
- (NSMutableArray *)selectFromFriendTableTableForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId friendForStatus:(int)friendForStatus type:(int)type {
    NSMutableArray *mtbArray = [[NSMutableArray alloc] init];
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"SELECT * FROM FriendTable WHERE FriendForMyId = ? and FriendAddStatus = ?";
    }
    else if (type == SQL_IF_TYPE_SECOND) {
        queryString = @"SELECT * FROM FriendTable WHERE FriendForMyId = ? and FriendOldStatus = ?";
    }
    else if (type == SQL_IF_TYPE_THIRD) {
        queryString = @"SELECT * FROM FriendTable WHERE FriendId = ? and FriendForMyId = ? and FriendAddStatus = ?";
    }
    else if (type == SQL_IF_TYPE_FOUR) {
        queryString = @"SELECT * FROM FriendTable WHERE FriendId = ? and FriendForMyId = ? and FriendOldStatus = ?";
    }
    else if (type == SQL_IF_TYPE_FIVE) {
        queryString = @"SELECT * FROM FriendTable WHERE FriendSId = ? and FriendForMyId = ? and FriendAddStatus = ?";
    }
    else if (type == SQL_IF_TYPE_SIX) {
        queryString = @"SELECT * FROM FriendTable WHERE FriendSId = ? and FriendForMyId = ? and FriendOldStatus = ?";
    }
    else if (type == SQL_IF_TYPE_SEVEN) {
        queryString = @"SELECT * FROM FriendTable WHERE FriendId = ? and FriendForMyId = ?";
    }
    else  if (type == SQL_IF_TYPE_EIGHT){
        queryString = @"SELECT * FROM FriendTable WHERE FriendSId = ? and FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_NINE) {
        queryString = @"SELECT * FROM FriendTable WHERE FriendForMyId = ? and FriendAddStatus = ? order by FriendSessionTime desc";
    }
    else {
        queryString = @"SELECT * FROM FriendTable";
    }
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST || type == SQL_IF_TYPE_SECOND || type == SQL_IF_TYPE_NINE) {
            sqlite3_bind_int(statement, 1, _myId);
            sqlite3_bind_int(statement, 2, friendForStatus);
        }
        else if (type == SQL_IF_TYPE_THIRD || type == SQL_IF_TYPE_FOUR || type == SQL_IF_TYPE_FIVE || type == SQL_IF_TYPE_SIX) {
            sqlite3_bind_int(statement, 1, _friendId);
            sqlite3_bind_int(statement, 2, _myId);
            sqlite3_bind_int(statement, 3, friendForStatus);
        }
        else if (type == SQL_IF_TYPE_SEVEN || type == SQL_IF_TYPE_EIGHT) {
            sqlite3_bind_int(statement, 1, _friendId);
            sqlite3_bind_int(statement, 2, _myId);
        }
        else {
            
        }
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //1.
            type_base_id_int friendId = sqlite3_column_int(statement, 1);
            type_base_id_int friendSId = sqlite3_column_int(statement, 2);
            int friendClientType = sqlite3_column_int(statement, 3);
            type_base_id_int friendForMyId = sqlite3_column_int(statement, 4);
            char *friendRemarksName = (char *)sqlite3_column_text(statement, 5);
            int friendStatus = sqlite3_column_int(statement,6);
            int friendOldStatus = sqlite3_column_int(statement,7);
            char *friendVerifyText = (char *)sqlite3_column_text(statement, 8);
            char *friendSequenceNumber = (char *)sqlite3_column_text(statement, 9);
            char *friendExtendInfo = (char *)sqlite3_column_text(statement, 10);
            int friendShieldingMessage = sqlite3_column_int(statement,11);
            unsigned int friendSessionTime = sqlite3_column_int(statement,12);
            //2.
            FriendInfoStructure *friendInfoStructure = [[FriendInfoStructure alloc] init];
            friendInfoStructure.friendForMyId = friendForMyId;
            friendInfoStructure.friendSId = friendSId;
            friendInfoStructure.friendId = friendId;
            friendInfoStructure.friendClientType = friendClientType;
            NSString *string1 = [NSString stringWithUTF8String:friendRemarksName];
            if (![string1 isEqualToString:kSqlForFieldEmpty]) {
                friendInfoStructure.friendRemarksNameString = string1;
            }
            friendInfoStructure.friendStatus = friendStatus;
            friendInfoStructure.friendOldStatus = friendOldStatus;
            NSString *string2 = [NSString stringWithUTF8String:friendVerifyText];
            if (![string2 isEqualToString:kSqlForFieldEmpty]) {
                friendInfoStructure.friendVerifyText = string2;
            }
            NSString *string3 = [NSString stringWithUTF8String:friendSequenceNumber];
            if (![string3 isEqualToString:kSqlForFieldEmpty]) {
                friendInfoStructure.friendSequenceNumberString = string3;
            }
            NSString *string4 = [NSString stringWithUTF8String:friendExtendInfo];
            if (![string4 isEqualToString:kSqlForFieldEmpty]) {
                friendInfoStructure.friendExtendInfoString = string4;
            }
            friendInfoStructure.friendShieldingMessage = friendShieldingMessage;
            friendInfoStructure.friendSessionTime = friendSessionTime;
            [mtbArray addObject:friendInfoStructure];
        }
    }
    sqlite3_finalize(statement);
    return mtbArray;
}
- (NSMutableDictionary *)selectTwoFromFriendTableTableForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId friendForStatus:(int)friendForStatus type:(int)type {
    NSMutableDictionary *mtbDictionary = [[NSMutableDictionary alloc] init];
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"SELECT * FROM FriendTable WHERE FriendId = ? and FriendForMyId = ?";
    }
    else {
        queryString = @"SELECT * FROM FriendTable WHERE FriendForMyId = ? and FriendOldStatus = ?";
    }
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST || type == SQL_IF_TYPE_SECOND) {
            sqlite3_bind_int(statement, 1, _myId);
            sqlite3_bind_int(statement, 2, friendForStatus);
        }
        else {
            sqlite3_bind_int(statement, 1, _myId);
            sqlite3_bind_int(statement, 2, friendForStatus);
        }
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //1.
            type_base_id_int friendId = sqlite3_column_int(statement, 1);
            type_base_id_int friendSId = sqlite3_column_int(statement, 2);
            int friendClientType = sqlite3_column_int(statement, 3);
            type_base_id_int friendForMyId = sqlite3_column_int(statement, 4);
            char *friendRemarksName = (char *)sqlite3_column_text(statement, 5);
            int friendStatus = sqlite3_column_int(statement,6);
            int friendOldStatus = sqlite3_column_int(statement,7);
            char *friendVerifyText = (char *)sqlite3_column_text(statement, 8);
            char *friendSequenceNumber = (char *)sqlite3_column_text(statement, 9);
            char *friendExtendInfo = (char *)sqlite3_column_text(statement, 10);
            int friendShieldingMessage = sqlite3_column_int(statement,11);
            unsigned int friendSessionTime = sqlite3_column_int(statement,12);
            
            //2.
            FriendInfoStructure *friendInfoStructure = [[FriendInfoStructure alloc] init];
            friendInfoStructure.friendForMyId = friendForMyId;
            friendInfoStructure.friendSId = friendSId;
            friendInfoStructure.friendId = friendId;
            friendInfoStructure.friendClientType = friendClientType;
            NSString *string1 = [NSString stringWithUTF8String:friendRemarksName];
            if (![string1 isEqualToString:kSqlForFieldEmpty]) {
                friendInfoStructure.friendRemarksNameString = string1;
            }
            friendInfoStructure.friendStatus = friendStatus;
            friendInfoStructure.friendOldStatus = friendOldStatus;
            NSString *string2 = [NSString stringWithUTF8String:friendVerifyText];
            if (![string2 isEqualToString:kSqlForFieldEmpty]) {
                friendInfoStructure.friendVerifyText = string2;
            }
            NSString *string3 = [NSString stringWithUTF8String:friendSequenceNumber];
            if (![string3 isEqualToString:kSqlForFieldEmpty]) {
                friendInfoStructure.friendSequenceNumberString = string3;
            }
            NSString *string4 = [NSString stringWithUTF8String:friendExtendInfo];
            if (![string4 isEqualToString:kSqlForFieldEmpty]) {
                friendInfoStructure.friendExtendInfoString = string4;
            }
            friendInfoStructure.friendShieldingMessage = friendShieldingMessage;
            friendInfoStructure.friendSessionTime = friendSessionTime;
            NSNumber *idNumber = [[NSNumber alloc] initWithInt:friendId];
            [mtbDictionary setObject:friendInfoStructure forKey:idNumber];
        }
    }
    sqlite3_finalize(statement);
    return mtbDictionary;
}
- (void)insertFromFriendTableForStructure:(FriendInfoStructure *)friendInfoStructure {
    //1.
    NSString *string1 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendRemarksNameString length] > 0) {
        string1 = friendInfoStructure.friendRemarksNameString;
    }
    NSString *string2 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendVerifyText length] > 0) {
        string2 = friendInfoStructure.friendVerifyText;
    }
    NSString *string3 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendSequenceNumberString length] > 0) {
        string3 = friendInfoStructure.friendSequenceNumberString;
    }
    NSString *string4 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendExtendInfoString length] > 0) {
        string4 = friendInfoStructure.friendExtendInfoString;
    }
    //2.
    char *insertDataChar = "INSERT OR REPLACE INTO FriendTable (FriendId,FriendSId,FriendClientType,FriendForMyId,FriendRemarksName,FriendAddStatus,FriendOldStatus,FriendVerifyText,FriendSequenceNumber,FriendExtendInfo,FriendShieldingMessage,FriendSessionTime) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, insertDataChar , -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, friendInfoStructure.friendId);
        sqlite3_bind_int(statement, 2, friendInfoStructure.friendSId);
        sqlite3_bind_int(statement, 3, friendInfoStructure.friendClientType);
        sqlite3_bind_int(statement, 4, friendInfoStructure.friendForMyId);
        sqlite3_bind_text(statement, 5, [string1 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 6 ,friendInfoStructure.friendStatus);
        sqlite3_bind_int(statement, 7, friendInfoStructure.friendOldStatus);
        sqlite3_bind_text(statement, 8, [string2 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 9, [string3 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 10, [string4 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 11, friendInfoStructure.friendShieldingMessage);
        sqlite3_bind_int(statement, 12, friendInfoStructure.friendSessionTime);
        if (sqlite3_step(statement) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of insertFromFriendTableForStructure '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of insertFromFriendTableForStructure '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(statement);
}
- (void)updateFromFriendTableForStructure:(FriendInfoStructure *)friendInfoStructure type:(int)type {
    //1.
    NSString *string1 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendRemarksNameString length] > 0) {
        string1 = friendInfoStructure.friendRemarksNameString;
    }
    NSString *string2 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendVerifyText length] > 0) {
        string2 = friendInfoStructure.friendVerifyText;
    }
    NSString *string3 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendSequenceNumberString length] > 0) {
        string3 = friendInfoStructure.friendSequenceNumberString;
    }
    //2.
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"UPDATE FriendTable SET FriendRemarksName=? WHERE FriendId = ? And FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_SECOND) {
        queryString = @"UPDATE FriendTable SET FriendAddStatus=? WHERE FriendId = ? And FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_THIRD) {
        queryString = @"UPDATE FriendTable SET FriendOldStatus=? WHERE FriendId = ? And FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_FOUR) {
        queryString = @"UPDATE FriendTable SET FriendAddStatus=?,FriendOldStatus=? WHERE FriendId = ? And FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_FIVE) {
        queryString = @"UPDATE FriendTable SET FriendRemarksName=? WHERE FriendSId = ? And FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_SIX) {
        queryString = @"UPDATE FriendTable SET FriendAddStatus=? WHERE FriendSId = ? And FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_SEVEN) {
        queryString = @"UPDATE FriendTable SET FriendOldStatus=? WHERE FriendSId = ? And FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_EIGHT) {
        queryString = @"UPDATE FriendTable SET FriendAddStatus=?,FriendOldStatus=? WHERE FriendSId = ? And FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_NINE) {
        queryString = @"UPDATE FriendTable SET FriendVerifyText=? WHERE FriendId = ? And FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_TEN) {
        queryString = @"UPDATE FriendTable SET FriendSId=? WHERE FriendId = ? And FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_ELEVEN) {
        queryString = @"UPDATE FriendTable SET FriendShieldingMessage=? WHERE FriendId = ? And FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_TWELVE){
        queryString = @"UPDATE FriendTable SET FriendVerifyText=?,FriendSequenceNumber=? WHERE FriendId =? And FriendForMyId =?";
    }
    else{
        queryString = @"UPDATE FriendTable SET FriendVerifyText=?,FriendSequenceNumber=?,FriendSessionTime=? WHERE FriendId =? And FriendForMyId =?";
    }
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_text(stmt, 1, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, friendInfoStructure.friendId);
            sqlite3_bind_int(stmt, 3, friendInfoStructure.friendForMyId);
        }
        else if (type == SQL_IF_TYPE_SECOND) {
            sqlite3_bind_int(stmt, 1, friendInfoStructure.friendStatus);
            sqlite3_bind_int(stmt, 2, friendInfoStructure.friendId);
            sqlite3_bind_int(stmt, 3, friendInfoStructure.friendForMyId);
        }
        else if (type == SQL_IF_TYPE_THIRD) {
            sqlite3_bind_int(stmt, 1, friendInfoStructure.friendOldStatus);
            sqlite3_bind_int(stmt, 2, friendInfoStructure.friendId);
            sqlite3_bind_int(stmt, 3, friendInfoStructure.friendForMyId);
        }
        else if (type == SQL_IF_TYPE_FOUR) {
            sqlite3_bind_int(stmt, 1, friendInfoStructure.friendStatus);
            sqlite3_bind_int(stmt, 2, friendInfoStructure.friendOldStatus);
            sqlite3_bind_int(stmt, 3, friendInfoStructure.friendId);
            sqlite3_bind_int(stmt, 4, friendInfoStructure.friendForMyId);
        }
        else if (type == SQL_IF_TYPE_FIVE) {
            sqlite3_bind_text(stmt, 1, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, friendInfoStructure.friendSId);
            sqlite3_bind_int(stmt, 3, friendInfoStructure.friendForMyId);
        }
        else if (type == SQL_IF_TYPE_SIX) {
            sqlite3_bind_int(stmt, 1, friendInfoStructure.friendStatus);
            sqlite3_bind_int(stmt, 2, friendInfoStructure.friendSId);
            sqlite3_bind_int(stmt, 3, friendInfoStructure.friendForMyId);
        }
        else if (type == SQL_IF_TYPE_SEVEN) {
            sqlite3_bind_int(stmt, 1, friendInfoStructure.friendOldStatus);
            sqlite3_bind_int(stmt, 2, friendInfoStructure.friendSId);
            sqlite3_bind_int(stmt, 3, friendInfoStructure.friendForMyId);
        }
        else if (type == SQL_IF_TYPE_EIGHT) {
            sqlite3_bind_int(stmt, 1, friendInfoStructure.friendStatus);
            sqlite3_bind_int(stmt, 2, friendInfoStructure.friendOldStatus);
            sqlite3_bind_int(stmt, 3, friendInfoStructure.friendSId);
            sqlite3_bind_int(stmt, 4, friendInfoStructure.friendForMyId);
        }
        else if (type == SQL_IF_TYPE_NINE) {
            sqlite3_bind_text(stmt, 1, [string2 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, friendInfoStructure.friendId);
            sqlite3_bind_int(stmt, 3, friendInfoStructure.friendForMyId);
        }
        else if (type == SQL_IF_TYPE_TEN) {
            sqlite3_bind_int(stmt, 1, friendInfoStructure.friendSId);
            sqlite3_bind_int(stmt, 2, friendInfoStructure.friendId);
            sqlite3_bind_int(stmt, 3, friendInfoStructure.friendForMyId);
        }
        else if (type == SQL_IF_TYPE_ELEVEN) {
            sqlite3_bind_int(stmt, 1, friendInfoStructure.friendShieldingMessage);
            sqlite3_bind_int(stmt, 2, friendInfoStructure.friendId);
            sqlite3_bind_int(stmt, 3, friendInfoStructure.friendForMyId);
        }
        else if (type == SQL_IF_TYPE_EIGHT) {
            sqlite3_bind_text(stmt, 1, [string2 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 2, [string3 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 3, friendInfoStructure.friendId);
            sqlite3_bind_int(stmt, 4, friendInfoStructure.friendForMyId);
        }
        else{
            sqlite3_bind_text(stmt, 1, [string2 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 2, [string3 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 3, friendInfoStructure.friendId);
            sqlite3_bind_int(stmt, 4, friendInfoStructure.friendForMyId);
            sqlite3_bind_int(stmt, 5, friendInfoStructure.friendSessionTime);
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updateFromFriendTableForStructure '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromFriendTableForStructure '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}
//参数：friendId可以是FriendId，也可以是FriendSId
- (void)deleteAllDataFromFriendTable:(type_base_id_int)friendId myId:(type_base_id_int)_myId ForFriendAddStatus:(int)addStatus ForFriendOldStatus:(int)oldStatus type:(int)type {
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"DELETE FROM FriendTable WHERE FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_SECOND) {
        queryString = @"DELETE FROM FriendTable WHERE FriendId = ? And FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_THIRD) {
        queryString = @"DELETE FROM FriendTable WHERE FriendSId = ? And FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_FOUR) {
        queryString = @"DELETE FROM FriendTable WHERE FriendForMyId = ? And FriendAddStatus=?";
    }
    else if (type == SQL_IF_TYPE_FIVE) {
        queryString = @"DELETE FROM FriendTable WHERE FriendForMyId = ? And FriendOldStatus=?";
    }
    else if (type == SQL_IF_TYPE_SIX) {
        queryString = @"DELETE FROM FriendTable WHERE FriendId = ? And FriendForMyId = ? And FriendOldStatus=?";
    }
    else {
        queryString = @"DELETE FROM FriendTable WHERE FriendSId = ? And FriendForMyId = ? And FriendOldStatus=?";
    }
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_int(statement, 1, _myId);
        }
        else if (type == SQL_IF_TYPE_SECOND) {
            sqlite3_bind_int(statement, 1, friendId);
            sqlite3_bind_int(statement, 2, _myId);
        }
        else if (type == SQL_IF_TYPE_THIRD) {
            sqlite3_bind_int(statement, 1, friendId);
            sqlite3_bind_int(statement, 2, _myId);
        }
        else if (type == SQL_IF_TYPE_FOUR) {
            sqlite3_bind_int(statement, 1, _myId);
            sqlite3_bind_int(statement, 2, addStatus);
        }
        else if (type == SQL_IF_TYPE_FIVE) {
            sqlite3_bind_int(statement, 1, _myId);
            sqlite3_bind_int(statement, 2, oldStatus);
        }
        else if (type == SQL_IF_TYPE_SIX) {
            sqlite3_bind_int(statement, 1, friendId);
            sqlite3_bind_int(statement, 2, _myId);
            sqlite3_bind_int(statement, 3, oldStatus);
        }
        else {
            sqlite3_bind_int(statement, 1, friendId);
            sqlite3_bind_int(statement, 2, _myId);
            sqlite3_bind_int(statement, 3, oldStatus);
        }
        if (sqlite3_step(statement) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of deleteAllDataFromFriendTable '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of deleteAllDataFromFriendTable '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(statement);
}
#pragma mark }
#pragma mark Friend info sql table {
//FriendInfoTable
//{
/*
  参数:_friendId 可以是FriendId，也可以是FriendSId
*/
- (NSMutableArray *)selectFromFriendInfoTableForFriendId:(type_base_id_int)_friendId type:(int)type {
    NSMutableArray *mtbArray = [[NSMutableArray alloc] init];
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"SELECT * FROM FriendInfoTable WHERE FriendId = ?";
    }
    else if (type == SQL_IF_TYPE_SECOND) {
        queryString = @"SELECT * FROM FriendInfoTable WHERE FriendSId = ?";
    }
    else {
        queryString = @"SELECT * FROM FriendInfoTable";
    }
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        if (type == SQL_IF_TYPE_FIRST || type == SQL_IF_TYPE_SECOND) {
            sqlite3_bind_int(statement, 1, _friendId);
        }
        else {
            sqlite3_bind_int(statement, 1, _friendId);
        }
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //1.
            type_base_id_int friendId = sqlite3_column_int(statement, 1);
            type_base_id_int friendSId = sqlite3_column_int(statement, 2);
            int friendClientType = sqlite3_column_int(statement, 3);
            char *friendPhoneName = (char *)sqlite3_column_text(statement, 4);
            char *friendIShowName = (char *)sqlite3_column_text(statement, 5);
            int friendSex = sqlite3_column_int(statement, 6);
            char *friendSignature = (char *)sqlite3_column_text(statement, 7);
            type_base_id_int friendScore = sqlite3_column_int(statement, 8);
            char *friendIconPath = (char *)sqlite3_column_text(statement, 9);
            char *friendBirthday = (char *)sqlite3_column_text(statement, 10);
            int friendProvince = sqlite3_column_int(statement, 11);
            int friendCity = sqlite3_column_int(statement, 12);
            char *friendLocation = (char *)sqlite3_column_text(statement, 13);
            type_base_id_int friendPhone = sqlite3_column_int(statement, 14);
            char *friendSource = (char *)sqlite3_column_text(statement, 15);
            int friendPhoneRecordId = sqlite3_column_int(statement, 16);
            int friendIconIndex = sqlite3_column_int(statement, 17);
            char *friendBgImagePath = (char *)sqlite3_column_text(statement, 18);
            int friendPhotoCount = sqlite3_column_int(statement, 19);
            //2.
            FriendInfoStructure *friendInfoStructure = [[FriendInfoStructure alloc] init];
            friendInfoStructure.friendId = friendId;
            friendInfoStructure.friendSId = friendSId;
            friendInfoStructure.friendClientType = friendClientType;
            NSString *string1 = [NSString stringWithUTF8String:friendPhoneName];
            if (![string1 isEqualToString:kSqlForFieldEmpty]) {
                friendInfoStructure.friendPhoneNameString = string1;
            }
            NSString *string2 = [NSString stringWithUTF8String:friendIShowName];
            if (![string2 isEqualToString:kSqlForFieldEmpty]) {
                friendInfoStructure.friendIShowNameString = string2;
            }
            friendInfoStructure.friendSex = friendSex;
            NSString *string4 = [NSString stringWithUTF8String:friendSignature];
            if (![string4 isEqualToString:kSqlForFieldEmpty]) {
                friendInfoStructure.friendSignatureString = string4;
            }
            friendInfoStructure.friendScoreLLong = friendScore;
            NSString *string5 = [NSString stringWithUTF8String:friendIconPath];
            if (![string5 isEqualToString:kSqlForFieldEmpty]) {
                NSString *lbImageFilePath = [self conversionLibraryImagePathOne:string5];
                if (lbImageFilePath == nil) {
                    lbImageFilePath = string5;
                }
                friendInfoStructure.friendHeadImagePath = lbImageFilePath;
            }
            friendInfoStructure.friendProvinceIndex = friendProvince;
            friendInfoStructure.friendCityIndex = friendCity;
            NSString *string6 = [NSString stringWithUTF8String:friendLocation];
            if (![string6 isEqualToString:kSqlForFieldEmpty]) {
                friendInfoStructure.friendLocationString = string6;
            }
            friendInfoStructure.friendPhoneLLong = friendPhone;
            NSString *string7 = [NSString stringWithUTF8String:friendSource];
            if (![string7 isEqualToString:kSqlForFieldEmpty]) {
                friendInfoStructure.friendSourceString = string7;
            }
            NSString *string8 = [NSString stringWithUTF8String:friendBirthday];
            if (![string8 isEqualToString:kSqlForFieldEmpty]) {
                friendInfoStructure.friendBirthdayString = string8;
            }
            friendInfoStructure.friendPhoneRecordId = friendPhoneRecordId;
            friendInfoStructure.friendIconIndex = friendIconIndex;
            NSString *string9 = [NSString stringWithUTF8String:friendBgImagePath];
            if (![string9 isEqualToString:kSqlForFieldEmpty]) {
                NSString *lbImageFilePath = [self conversionLibraryImagePathOne:string9];
                if (lbImageFilePath == nil) {
                    lbImageFilePath = string9;
                }
                friendInfoStructure.friendBgImagePath = lbImageFilePath;
            }
            friendInfoStructure.friendPhotoCount = friendPhotoCount;
            [mtbArray addObject:friendInfoStructure];
        }
    }
    sqlite3_finalize(statement);
    return mtbArray;
}
/*
 参数:friendInfoStructure 好友的info
*/
- (void)insertFromFriendInfoTableForStructure:(FriendInfoStructure *)friendInfoStructure {
    //1.
    NSString *string1 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendPhoneNameString length] > 0) {
        string1 = friendInfoStructure.friendPhoneNameString;
    }
    NSString *string2 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendIShowNameString length] > 0) {
        string2 = friendInfoStructure.friendIShowNameString;
    }
    NSString *string4= kSqlForFieldEmpty;
    if ([friendInfoStructure.friendSignatureString length] > 0) {
        string4 = friendInfoStructure.friendSignatureString;
    }
    NSString *string5 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendHeadImagePath length] > 0) {
        string5 = friendInfoStructure.friendHeadImagePath;
    }
    NSString *string6 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendBirthdayString length] > 0) {
        string6 = friendInfoStructure.friendBirthdayString;
    }
    NSString *string7 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendLocationString length] > 0) {
        string7 = friendInfoStructure.friendLocationString;
    }
    NSString *string8 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendSourceString length] > 0) {
        string8 = friendInfoStructure.friendSourceString;
    }
    NSString *string9 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendBgImagePath length] > 0) {
        string9 = friendInfoStructure.friendBgImagePath;
    }
    //2.
    char *insertDataChar = "INSERT OR REPLACE INTO FriendInfoTable (FriendId,FriendSId,FriendClientType,FriendPhoneName,FriendIShowName,FriendSex,FriendSignature,FriendScore,FriendIconPath,FriendBirthday,FriendProvince,FriendCity,friendLocation,FriendPhone,FriendSource,FriendPhoneRecordId,FriendIconIndex,FriendBgImagePath,FriendPhotoCount) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, insertDataChar , -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, friendInfoStructure.friendId);
        sqlite3_bind_int(statement, 2, friendInfoStructure.friendSId);
        sqlite3_bind_int(statement, 3, friendInfoStructure.friendClientType);
        sqlite3_bind_text(statement, 4, [string1 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [string2 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 6, friendInfoStructure.friendSex);
        sqlite3_bind_text(statement, 7, [string4 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int64(statement, 8, friendInfoStructure.friendScoreLLong);
        sqlite3_bind_text(statement, 9, [string5 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 10, [string6 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 11, friendInfoStructure.friendProvinceIndex);
        sqlite3_bind_int(statement, 12, friendInfoStructure.friendCityIndex);
        sqlite3_bind_text(statement, 13, [string7 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int64(statement, 14, friendInfoStructure.friendPhoneLLong);
        sqlite3_bind_text(statement, 15, [string8 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 16, friendInfoStructure.friendPhoneRecordId);
        sqlite3_bind_int(statement, 17, friendInfoStructure.friendIconIndex);
        sqlite3_bind_text(statement, 18, [string9 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 19, friendInfoStructure.friendPhotoCount);
        if (sqlite3_step(statement) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of insertFromFriendInfoTableForStructure '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of insertFromFriendInfoTableForStructure '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(statement);
}
/*
 参数:friendInfoStructure 好友的info
     type 执行的条件类别
*/
- (void)updateFromFriendInfoTableForStructure:(FriendInfoStructure *)friendInfoStructure type:(int)type {
    //1.
    NSString *string1 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendIShowNameString length] > 0) {
        string1 = friendInfoStructure.friendIShowNameString;
    }
    NSString *string2 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendSignatureString length] > 0) {
        string2 = friendInfoStructure.friendSignatureString;
    }
    NSString *string3 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendLocationString length] > 0) {
        string3 = friendInfoStructure.friendLocationString;
    }
    NSString *string4 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendHeadImagePath length] > 0) {
        string4 = friendInfoStructure.friendHeadImagePath;
    }
    NSString *string5 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendBirthdayString length] > 0) {
        string5 = friendInfoStructure.friendBirthdayString;
    }
    NSString *string6 = kSqlForFieldEmpty;
    if ([friendInfoStructure.friendBgImagePath length] > 0) {
        string6 = friendInfoStructure.friendBgImagePath;
    }
    //2.
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"UPDATE FriendInfoTable SET FriendIconPath=? WHERE FriendId = ?";
    }
    else if (type == SQL_IF_TYPE_SECOND) {//更新基本以及扩展-1
        queryString = @"UPDATE FriendInfoTable SET FriendIShowName=?,FriendSex=?,FriendSignature=?,FriendScore=?,FriendBirthday=?,FriendProvince=?,FriendCity=?,FriendLocation=?,FriendIconIndex=? WHERE FriendId = ?";
    }
    else if (type == SQL_IF_TYPE_FIVE) {//更新扩展-1
        queryString = @"UPDATE FriendInfoTable SET FriendBirthday=?,FriendProvince=?,FriendCity=?,FriendLocation=? WHERE FriendId = ?";
    }
    else if (type ==SQL_IF_TYPE_ELEVEN) {//更新基本-1
        queryString = @"UPDATE FriendInfoTable SET FriendSId=?,FriendIShowName=?,FriendSex=?,FriendSignature=?,FriendScore=?,FriendIconIndex=? WHERE FriendId = ?";
    }
    else if (type ==SQL_IF_TYPE_TWELVE) {
        queryString = @"UPDATE FriendInfoTable SET FriendBgImagePath = ? WHERE FriendId = ?";
    }
    else if (type ==SQL_IF_TYPE_FOURTEEN) {//更新名字 irisg_m
        queryString = @"UPDATE FriendInfoTable SET FriendIShowName=? WHERE FriendId = ?";
    }
    else {
        queryString = @"UPDATE FriendInfoTable SET FriendPhotoCount = ? WHERE FriendId = ?";
    }
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_text(stmt, 1, [string4 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, friendInfoStructure.friendId);
        }
        else if (type == SQL_IF_TYPE_SECOND) {
            sqlite3_bind_text(stmt, 1, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, friendInfoStructure.friendSex);
            sqlite3_bind_text(stmt, 3, [string2 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int64(stmt, 4, friendInfoStructure.friendScoreLLong);
            sqlite3_bind_text(stmt, 5, [string5 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 6, friendInfoStructure.friendProvinceIndex);
            sqlite3_bind_int(stmt, 7, friendInfoStructure.friendCityIndex);
            sqlite3_bind_text(stmt, 8, [string3 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 9, friendInfoStructure.friendIconIndex);
            sqlite3_bind_int(stmt, 10, friendInfoStructure.friendId);
        }
        else if (type == SQL_IF_TYPE_FIVE) {
            sqlite3_bind_text(stmt, 1, [string5 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, friendInfoStructure.friendProvinceIndex);
            sqlite3_bind_int(stmt, 3, friendInfoStructure.friendCityIndex);
            sqlite3_bind_text(stmt, 4, [string3 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 5, friendInfoStructure.friendId);
        }
        else if (type ==SQL_IF_TYPE_ELEVEN) {
            sqlite3_bind_int(stmt, 1, friendInfoStructure.friendSId);
            sqlite3_bind_text(stmt, 2, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 3, friendInfoStructure.friendSex);
            sqlite3_bind_text(stmt, 4, [string2 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int64(stmt, 5, friendInfoStructure.friendScoreLLong);
            sqlite3_bind_int(stmt, 6, friendInfoStructure.friendIconIndex);
            sqlite3_bind_int(stmt, 7, friendInfoStructure.friendId);
        }
        else if (type == SQL_IF_TYPE_TWELVE) {
            sqlite3_bind_text(stmt, 1, [string6 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, friendInfoStructure.friendId);
        }
        else if (type ==SQL_IF_TYPE_FOURTEEN) {
            sqlite3_bind_text(stmt, 1, [string1 UTF8String], -1, SQLITE_TRANSIENT);
        }
        else {
            sqlite3_bind_int(stmt, 1, friendInfoStructure.friendPhotoCount);
            sqlite3_bind_int(stmt, 2, friendInfoStructure.friendId);
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updateFromFriendInfoTableForStructure '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromFriendInfoTableForStructure '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}
- (void)updateFromFriendInfoTableForString:(NSString *)string ForFriendId:(type_base_id_int)friendId type:(int)type {
    NSString *string1 = kSqlForFieldEmpty;
    if ([string length] > 0) {
        string1 = string;
    }
    //2.
    NSString *libraryPath = [self libraryPathSearchPath];
    NSString *dbPath = [self getPath:libraryPath sqlName:kFriendInfoSqlName];
    BOOL isOpen = [self openSqllite:dbPath];
    if (isOpen == YES) {
        NSString *queryString = nil;
        if (type == SQL_IF_TYPE_FIRST) {//一开始给所有的用户初始一个默认值
            queryString = @"UPDATE FriendInfoTable SET FriendBgImagePath = ?";
        }
        else {
            queryString = @"UPDATE FriendInfoTable SET FriendIconPath = ? WHERE FriendId = ?";
        }
        sqlite3_stmt *stmt;
        if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
            if (type == SQL_IF_TYPE_FIRST) {
                sqlite3_bind_text(stmt, 1, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            }
            else {
                sqlite3_bind_text(stmt, 1, [string1 UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_int(stmt, 2, friendId);
            }
            if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
                NSAssert1(0, @"Error: failed to updating method of updateFromFriendInfoTableForString '%s'.", sqlite3_errmsg(database));
#else
                //NSLog(@"Error: failed to updating method of updateFromFriendInfoTableForString '%s'.",sqlite3_errmsg(database));
#endif
            }
        }
        sqlite3_finalize(stmt);
        sqlite3_close(database);
    }
}

- (void)updateFromFriendInfoTableForIconIndex:(int)index ForFriendId:(type_base_id_int)friendId{

    NSString *queryString = nil;
    
    queryString = @"UPDATE FriendInfoTable SET FriendIconIndex = ? WHERE FriendId = ?";
    
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
        
        sqlite3_bind_int(stmt, 1, index);
        
        if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updateFromFriendInfoTableForString '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromFriendInfoTableForString '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}

//参数：friendId可以是FriendId，也可以是FriendSId
- (void)deleteAllDataFromFriendInfoTable:(type_base_id_int)friendId type:(int)type {
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"DELETE FROM FriendInfoTable WHERE FriendId = ?";
    }
    else {
        queryString = @"DELETE FROM FriendInfoTable WHERE FriendSId = ?";
    }
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, friendId);
        if (sqlite3_step(statement) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of deleteAllDataFromFriendInfoTable '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of deleteAllDataFromFriendInfoTable '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(statement);
}
//}
//SessionTable
//{
- (NSMutableArray *)selectFromSessionTable:(type_base_id_int)friendForMyId friendId:(type_base_id_int)friendId type:(int)type {
    NSMutableArray *mtbArray = [[NSMutableArray alloc] init];
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"SELECT * FROM SessionTable WHERE FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_SECOND) {
        //queryString = @"SELECT * FROM SessionTable WHERE FriendForMyId = ? order by SessionTime desc";asc
        queryString = @"SELECT * FROM SessionTable WHERE FriendForMyId = ? order by SessionTime desc";
    }
    else if (type == SQL_IF_TYPE_THIRD) {
        queryString = @"SELECT * FROM SessionTable WHERE FriendForMyId = ? And FriendId = ?";
    }
    else if (type == SQL_IF_TYPE_FIVE) {
//        queryString = @"SELECT * FROM SessionTable WHERE FriendForMyId = ? And FriendId = ? And fireFlg = 0";  //阅后即焚参数使用chatFlg  zzy
        queryString = @"SELECT * FROM SessionTable WHERE FriendForMyId = ? And FriendId = ? And ChatFlg = 0";
    }
    else if (type == SQL_IF_TYPE_SIX) {
//        queryString = @"SELECT * FROM SessionTable WHERE FriendForMyId = ? And FriendId = ? And fireFlg = 8";  //阅后即焚参数使用chatFlg  zzy
        queryString = @"SELECT * FROM SessionTable WHERE FriendForMyId = ? And FriendId = ? And ChatFlg = 8";
    }
    else if (type == SQL_IF_TYPE_SEVEN) { //群消息
        queryString = @"SELECT * FROM SessionTable WHERE FriendForMyId = ? And FriendId = ? And ChatFlg = 1";
    }
    else if (type == SQL_IF_TYPE_EIGHT) { //群通知
        queryString = @"SELECT * FROM SessionTable WHERE FriendForMyId = ? And ChatFlg = 2";
    }
    else {
         queryString = @"SELECT * FROM SessionTable";
    }
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST || type == SQL_IF_TYPE_SECOND || type == SQL_IF_TYPE_EIGHT) {
            sqlite3_bind_int(statement, 1, friendForMyId);
        }
        else if (type == SQL_IF_TYPE_THIRD || type == SQL_IF_TYPE_FIVE || type == SQL_IF_TYPE_SIX || type == SQL_IF_TYPE_SEVEN) {
            sqlite3_bind_int(statement, 1, friendForMyId);
            sqlite3_bind_int(statement, 2, friendId);
        }
        else {
            
        }
        while (sqlite3_step(statement) == SQLITE_ROW) {
            type_base_id_int friendId = sqlite3_column_int(statement, 1);
            int friendClientType = sqlite3_column_int(statement, 2);
            type_base_id_int newFriendForMyId = sqlite3_column_int(statement, 3);
            unsigned int sessionTime = sqlite3_column_int(statement, 4);
            char *chatDraftString = (char *)sqlite3_column_text(statement, 5);
            int chatFlg = sqlite3_column_int(statement, 6);
//            int ChatType = sqlite3_column_int(statement, 6);
//            int fireFlg = sqlite3_column_int(statement, 7);   //去掉fireFlg
            
            SessionChatStructure *sessionChatStructure = [[SessionChatStructure alloc] init];
            sessionChatStructure.friendForMyId = newFriendForMyId;
            sessionChatStructure.friendId = friendId;
            sessionChatStructure.friendClientType = friendClientType;
            sessionChatStructure.chatLongLongTime = sessionTime;
            NSString *string1 = [NSString stringWithUTF8String:chatDraftString];
            if (![string1 isEqualToString:kSqlForFieldEmpty]) {
                NSString *lbImageFilePath = [self conversionLibraryImagePathOne:string1];
                if (lbImageFilePath == nil) {
                    lbImageFilePath = string1;
                }
                sessionChatStructure.chatDraftString = lbImageFilePath;
            }
            //sessionChatStructure.chatGroupFlg = ChatType;//是不是写错啦，用chatGroupFlg表示chatFlag？ zzy
            sessionChatStructure.chatFlg = chatFlg;
//            sessionChatStructure.chatFlg = ChatType;
//            sessionChatStructure.fireFlg = fireFlg;    //去掉fireFlg  zzy
            [mtbArray addObject:sessionChatStructure];
        }
    }
    sqlite3_finalize(statement);
    return mtbArray;
}
- (void)insertFromSessionTableForStructure:(SessionChatStructure *)sessionChatStructure {
    NSString *string1 = kSqlForFieldEmpty;
    if ([sessionChatStructure.chatDraftString length] > 0) {
        string1 = sessionChatStructure.chatDraftString;
    }
//    char *insertDataChar = "INSERT OR REPLACE INTO SessionTable (FriendId,FriendClientType,FriendForMyId,SessionTime,ChatDraft,ChatFlg,fireFlg) VALUES (?,?,?,?,?,?,?)";//,fireFlg,?
    char *insertDataChar = "INSERT OR REPLACE INTO SessionTable (FriendId,FriendClientType,FriendForMyId,SessionTime,ChatDraft,ChatFlg) VALUES (?,?,?,?,?,?)";//去掉fireFlg,?  zzy
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, insertDataChar , -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, sessionChatStructure.friendId);
        sqlite3_bind_int(statement, 2, sessionChatStructure.friendClientType);
        sqlite3_bind_int(statement, 3, sessionChatStructure.friendForMyId);
        sqlite3_bind_int(statement, 4, sessionChatStructure.chatLongLongTime);
        sqlite3_bind_text(statement, 5, [string1 UTF8String], -1, SQLITE_TRANSIENT);
        //sqlite3_bind_int(statement, 6, sessionChatStructure.chatGroupFlg); //是不是写错了》？
        sqlite3_bind_int(statement, 6, sessionChatStructure.chatFlg);
//        sqlite3_bind_int(statement, 7, sessionChatStructure.fireFlg);   //去掉fireFlg zzy
        if (sqlite3_step(statement) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of insertFromSessionTableForStructure '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of insertFromSessionTableForStructure '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(statement);
}
- (void)updateFromSessionTableForStructure:(SessionChatStructure *)sessionChatStructure type:(int)type {
    //
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"UPDATE SessionTable SET FriendClientType=?,FriendForMyId=?,SessionTime=? WHERE FriendId = ?";
    }
    else if (type == SQL_IF_TYPE_SECOND){
        queryString = @"UPDATE SessionTable SET SessionTime=? WHERE FriendId = ? And FriendForMyId=?";
    }
    else if (type == SQL_IF_TYPE_FOUR){
//        queryString = @"UPDATE SessionTable SET SessionTime=? WHERE FriendId = ? And FriendForMyId=? And fireFlg = 0";  //阅后即焚参数使用chatFlg  zzy
        queryString = @"UPDATE SessionTable SET SessionTime=? WHERE FriendId = ? And FriendForMyId=? And ChatFlg = 0";
    }
    else if (type == SQL_IF_TYPE_FIVE){
//        queryString = @"UPDATE SessionTable SET SessionTime=? WHERE FriendId = ? And FriendForMyId=? And fireFlg = 8";  //阅后即焚参数使用chatFlg  zzy
        queryString = @"UPDATE SessionTable SET SessionTime=? WHERE FriendId = ? And FriendForMyId=? And ChatFlg = 8";
    }
    else if (type == SQL_IF_TYPE_SIX){
//        queryString = @"UPDATE SessionTable SET ChatDraft=? WHERE FriendId = ? And FriendForMyId=? And fireFlg = 0";    //阅后即焚参数使用chatFlg  zzy
        queryString = @"UPDATE SessionTable SET SessionTime=?, ChatDraft=? WHERE FriendId = ? And FriendForMyId=? And ChatFlg = 0";
    }
    else if (type == SQL_IF_TYPE_SEVEN){
//        queryString = @"UPDATE SessionTable SET ChatDraft=? WHERE FriendId = ? And FriendForMyId=? And fireFlg = 8";    //阅后即焚参数使用chatFlg  zzy
        queryString = @"UPDATE SessionTable SET SessionTime=?, ChatDraft=? WHERE FriendId = ? And FriendForMyId=? And ChatFlg = 8";
    }
    else if (type == SQL_IF_TYPE_NINE){
        queryString = @"UPDATE SessionTable SET SessionTime=? WHERE FriendId = ? And FriendForMyId=? And ChatFlg = 1";
    }
    else if (type == SQL_IF_TYPE_TEN){
        queryString = @"UPDATE SessionTable SET SessionTime=? WHERE FriendForMyId=? And ChatFlg = 2";
    }
    else if (type == SQL_IF_TYPE_ELEVEN) {  //add by zzy
        queryString = @"UPDATE SessionTable SET SessionTime=?, ChatDraft=? WHERE FriendId = ? And FriendForMyId=? And ChatFlg = 1";
    }
    else {
//        queryString = @"UPDATE SessionTable SET fireFlg=? WHERE FriendId = ? And FriendForMyId=?";                      //阅后即焚参数使用chatFlg  zzy
        queryString = @"UPDATE SessionTable SET ChatFlg=? WHERE FriendId = ? And FriendForMyId=?";
    }
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_int(stmt, 1, sessionChatStructure.friendClientType);
            sqlite3_bind_int(stmt, 2, sessionChatStructure.friendForMyId);
            sqlite3_bind_int(stmt, 3, sessionChatStructure.chatLongLongTime);
        }
        else if ((type == SQL_IF_TYPE_SECOND) || (type == SQL_IF_TYPE_FOUR) || (type == SQL_IF_TYPE_FIVE) || (type == SQL_IF_TYPE_NINE)) {
            sqlite3_bind_int(stmt, 1, sessionChatStructure.chatLongLongTime);
            sqlite3_bind_int(stmt, 2, sessionChatStructure.friendId);
            sqlite3_bind_int(stmt, 3, sessionChatStructure.friendForMyId);
        }
        else if ((type == SQL_IF_TYPE_SIX) || (type == SQL_IF_TYPE_SEVEN) || (type == SQL_IF_TYPE_ELEVEN)) {
            NSString *string1 = kSqlForFieldEmpty;
            if ([sessionChatStructure.chatDraftString length] > 0) {
                string1 = sessionChatStructure.chatDraftString;
            }
            sqlite3_bind_int(stmt,1, sessionChatStructure.chatLongLongTime);
            sqlite3_bind_text(stmt,2, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 3, sessionChatStructure.friendId);
            sqlite3_bind_int(stmt, 4, sessionChatStructure.friendForMyId);
        }
        else if (type == SQL_IF_TYPE_TEN){
            sqlite3_bind_int(stmt, 1, sessionChatStructure.chatLongLongTime);
            sqlite3_bind_int(stmt, 2, sessionChatStructure.friendForMyId);
        }
        else {
//            sqlite3_bind_int(stmt, 1, sessionChatStructure.fireFlg);                 //阅后即焚参数使用chatFlg  zzy
            sqlite3_bind_int(stmt, 1, sessionChatStructure.chatFlg);
            sqlite3_bind_int(stmt, 2, sessionChatStructure.friendId);
            sqlite3_bind_int(stmt, 3, sessionChatStructure.friendForMyId);
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updateFromSessionTableForStructure '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromSessionTableForStructure '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}
-(void)updateFromSessionTableForChatDraft:(NSString *)chatDraftString {
    NSString *string1 = kSqlForFieldEmpty;
    if ([chatDraftString length] > 0) {
        string1 = chatDraftString;
    }
    NSString *libraryPath = [self libraryPathSearchPath];
    NSString *dbPath = [self getPath:libraryPath sqlName:kFriendInfoSqlName];
    BOOL isOpen = [self openSqllite:dbPath];
    if (isOpen == YES) {
        NSString*qurryString=@"UPDATE SessionTable SET ChatDraft=?";
        sqlite3_stmt *stmt;
        if (sqlite3_prepare_v2(database, [qurryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
            sqlite3_bind_text(stmt, 1, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
                NSAssert1(0, @"Error: failed to updating method of updateFromSessionTableForChatDraft '%s'.", sqlite3_errmsg(database));
#else
                //NSLog(@"Error: failed to updating method of updateFromSessionTableForChatDraft '%s'.",sqlite3_errmsg(database));
#endif
            }
        }
        sqlite3_finalize(stmt);
        sqlite3_close(database);
    }
}
- (void)deleteFromSessionTableForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId type:(int)type {
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"DELETE FROM SessionTable WHERE FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_SECOND) {
        queryString = @"DELETE FROM SessionTable WHERE FriendId = ? and FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_THIRD){
//        queryString = @"DELETE FROM SessionTable WHERE FriendId = ? And FriendForMyId = ? And fireFlg = 8";     //阅后即焚参数使用chatFlg  zzy
        queryString = @"DELETE FROM SessionTable WHERE FriendId = ? And FriendForMyId = ? And ChatFlg = 8";
    }
    else if (type == SQL_IF_TYPE_FIVE) {
        queryString = @"DELETE FROM SessionTable WHERE FriendId = ? And FriendForMyId = ? And ChatFlg = 1";
    }
    else {
//        queryString = @"DELETE FROM SessionTable WHERE FriendId = ? And FriendForMyId = ? And fireFlg = 0";     //阅后即焚参数使用chatFlg  zzy
        queryString = @"DELETE FROM SessionTable WHERE FriendId = ? And FriendForMyId = ? And ChatFlg = 0";
    }
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_int(statement, 1, _myId);
        }
        else if (type == SQL_IF_TYPE_SECOND || type == SQL_IF_TYPE_THIRD || type == SQL_IF_TYPE_FIVE) {
            sqlite3_bind_int(statement, 1, _friendId);
            sqlite3_bind_int(statement, 2, _myId);
        }
        else {
            sqlite3_bind_int(statement, 1, _friendId);
            sqlite3_bind_int(statement, 2, _myId);
        }
        if (sqlite3_step(statement) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of deleteFromSessionTableForFriendId '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of deleteFromSessionTableForFriendId '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(statement);
}
//}
//ChatRecordTable
//① selete * from testtable limit 2,1;从数据库中第三条开始查询，取一条数据，即第三条数据
//② selete * from testtable limit 2 offset 1;从数据库中的第二条数据开始查询两条数据，即第二条和第三条。
//type==SQL_IF_TYPE_SECOND会暂时使用limitCountCount
//type==SQL_IF_TYPE_FIVE会暂时使用limitCountCount与offsetCount
//{
- (NSMutableArray *)selectFromChatRecordTableForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId limitCount:(int)limitCountCount offsetCount:(int)offsetCount isSingle:(BOOL)isSingle type:(int)type {
    NSMutableArray *mtbArray = [[NSMutableArray alloc] init];
    NSString *queryString = nil;
    if (isSingle) {
        queryString = @"SELECT * FROM ChatRecordTable WHERE FriendId = ?";
    }
    else {//时间是用NSString类来放的，时间会有相同的，所以用ChatDatetimeSring与GuIdString来做同时降序,暂不用sql id
        if (type == SQL_IF_TYPE_FIRST) {
            queryString = @"SELECT * FROM ChatRecordTable WHERE FriendId = ? And FriendForMyId = ?";
        }
        else if (type == SQL_IF_TYPE_SECOND)  {
            queryString = @"SELECT * FROM ChatRecordTable WHERE FriendId = ? And FriendForMyId = ? And ChatUnread = ?";
        }
        else if (type == SQL_IF_TYPE_THIRD) {//desc//asc
            queryString = [NSString stringWithFormat:@"SELECT * FROM ChatRecordTable WHERE FriendId = ? And FriendForMyId = ? And ChatFlg = 0 order by ChatDatetimeSring desc,id desc limit %d,%d",limitCountCount,offsetCount];//GuIdString desc
        }
        else if (type == SQL_IF_TYPE_EIGHT) {//desc//asc
            queryString = [NSString stringWithFormat:@"SELECT * FROM ChatRecordTable WHERE FriendId = ? And FriendForMyId = ? And ChatFlg = 8 order by ChatDatetimeSring desc,id desc limit %d,%d",limitCountCount,offsetCount];//GuIdString desc
        }
        else if (type == SQL_IF_TYPE_FOUR) {
            queryString = [NSString stringWithFormat:@"SELECT * FROM ChatRecordTable WHERE FriendId = ? And FriendForMyId = ? order by ChatDatetimeSring desc,id desc limit %d offset %d",limitCountCount,offsetCount];//GuIdString desc
        }
        else if (type ==SQL_IF_TYPE_FIVE) {
            queryString = @"SELECT * FROM ChatRecordTable WHERE FriendId = ? And FriendForMyId = ? And ChatType=? And ChatFlg = ? or FriendId = ? And FriendForMyId = ? And ChatType=? And ChatFlg = ? order by ChatDatetimeSring asc,id asc";//GuIdString asc
        }
        else if (type == SQL_IF_TYPE_SIX) {
            queryString = [NSString stringWithFormat:@"SELECT * FROM ChatRecordTable order by ChatDatetimeSring desc,id desc limit %d,%d",limitCountCount,offsetCount];//GuIdString desc
        }
        else if (type == SQL_IF_TYPE_SEVEN){
            queryString = @"SELECT * FROM ChatRecordTable WHERE FriendId = ? And FriendForMyId = ? And ChatSendFlg > ?";
        }
        else if (type == SQL_IF_TYPE_NINE) {
            queryString = [NSString stringWithFormat:@"SELECT * FROM ChatRecordTable WHERE FriendId = ? And FriendForMyId = ? And ChatFlg = 0 order by ChatDatetimeSring desc,id desc limit %d offset %d",limitCountCount,offsetCount];//GuIdString desc
        }
        else if (type == SQL_IF_TYPE_TEN) {
            queryString = [NSString stringWithFormat:@"SELECT * FROM ChatRecordTable WHERE FriendId = ? And FriendForMyId = ? And ChatFlg = 8 order by ChatDatetimeSring desc,id desc limit %d offset %d",limitCountCount,offsetCount];//GuIdString desc
        }
        else if (type == SQL_IF_TYPE_TWELVE)  {
            queryString = @"SELECT * FROM ChatRecordTable WHERE FriendForMyId = ? And ChatUnread = ? And ChatFlg = 8";
        }
        else if (type == SQL_IF_TYPE_THIRTEEN)  {
            queryString = @"SELECT * FROM ChatRecordTable WHERE FriendId = ? And FriendForMyId = ? And ChatUnread = ? And ChatFlg = 8";
        }
        else if (type == SQL_IF_TYPE_FOURTEEN)  {
            queryString = @"SELECT * FROM ChatRecordTable WHERE FriendId = ? And FriendForMyId = ? And ChatUnread = ? And ChatFlg = 0";
        }
        else if (type == SQL_IF_TYPE_FIFTEEN)  {
            queryString = @"SELECT * FROM ChatRecordTable WHERE FriendForMyId = ? And ChatUnread = ? And ChatFlg = 0";
        }
        else {
            queryString = @"SELECT * FROM ChatRecordTable";
        }
    }
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (isSingle) {
            sqlite3_bind_int(statement, 1, _friendId);
        }
        else if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_int(statement, 1, _friendId);
            sqlite3_bind_int(statement, 2, _myId);
        }
        else if (type == SQL_IF_TYPE_SECOND || type == SQL_IF_TYPE_THIRTEEN || type == SQL_IF_TYPE_FOURTEEN) {
            sqlite3_bind_int(statement, 1, _friendId);
            sqlite3_bind_int(statement, 2, _myId);
            sqlite3_bind_int(statement, 3, limitCountCount);
        }
        else if (type == SQL_IF_TYPE_THIRD || type == SQL_IF_TYPE_FOUR || type == SQL_IF_TYPE_EIGHT || type == SQL_IF_TYPE_NINE || type == SQL_IF_TYPE_TEN) {
            sqlite3_bind_int(statement, 1, _friendId);
            sqlite3_bind_int(statement, 2, _myId);
        }
        else if (type ==SQL_IF_TYPE_FIVE) {//目前图片里在借用了limitCountCount
            sqlite3_bind_int(statement, 1, _friendId);
            sqlite3_bind_int(statement, 2, _myId);
            sqlite3_bind_int(statement, 3, limitCountCount);
            sqlite3_bind_int(statement, 4, 0);
            sqlite3_bind_int(statement, 5, _friendId);
            sqlite3_bind_int(statement, 6, _myId);
            sqlite3_bind_int(statement, 7, offsetCount);
            sqlite3_bind_int(statement, 8, 0);
        }
        else if (type ==SQL_IF_TYPE_SIX) {
            
        }
        else if (type == SQL_IF_TYPE_SEVEN) {
            sqlite3_bind_int(statement, 1, _friendId);
            sqlite3_bind_int(statement, 2, _myId);
            sqlite3_bind_int(statement, 3, limitCountCount);
        }
        else if (type == SQL_IF_TYPE_TWELVE || type == SQL_IF_TYPE_FIFTEEN) {
            sqlite3_bind_int(statement, 1, _myId);
            sqlite3_bind_int(statement, 2, limitCountCount);
        }
        else {
            
        }
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int _id = sqlite3_column_int(statement, 0);
            type_base_id_int friendId = sqlite3_column_int(statement, 1);
            int friendClientType = sqlite3_column_int(statement, 2);
            char *chatContent = (char *)sqlite3_column_text(statement, 3);
            char *chatDatetime =  (char *)sqlite3_column_text(statement, 4);
            int chatIsSelfTag = sqlite3_column_int(statement, 5);
            type_base_id_int friendForMyid = sqlite3_column_int(statement, 6);
            int chatFlg = sqlite3_column_int(statement, 7);
            int chatUnread = sqlite3_column_int(statement, 8);
            int ChatSendFlg = sqlite3_column_int(statement, 9);
            int ChatImageCount = sqlite3_column_int(statement, 10);
            int ChatType = sqlite3_column_int(statement, 11);
            char *chatImagePath = (char *)sqlite3_column_text(statement, 12);
            char *ChatThumbnailImagePath = (char *)sqlite3_column_text(statement, 13);
            int audioMessageisUnRead = sqlite3_column_int(statement, 14);
            char *guIdString =  (char *)sqlite3_column_text(statement, 15);
            int messageId = sqlite3_column_int(statement, 16);
            //char *GuIdOriginal =  (char *)sqlite3_column_text(statement, 17);
            
            SessionChatStructure *sessionChatStructure = [[SessionChatStructure alloc] init];
        //{
            sessionChatStructure.chatSqlId = _id;
            sessionChatStructure.friendId = friendId;
            sessionChatStructure.friendClientType = friendClientType;
            sessionChatStructure.friendForMyId = friendForMyid;
            NSString *string1 = [NSString stringWithUTF8String:chatContent];
            if (![string1 isEqualToString:kSqlForFieldEmpty]) {
                sessionChatStructure.chatContentString = string1;
            }
            NSString *string2 = [NSString stringWithUTF8String:chatDatetime];
            if (![string2 isEqualToString:kSqlForFieldEmpty]) {
                sessionChatStructure.chatDatetimeSring = string2;
            }
            if (chatIsSelfTag == CHAT_IS_SELF_TAG_Init || chatIsSelfTag == CHAT_IS_SELF_TAG_Surplus) {
                sessionChatStructure.chatIsSelfTag = CHAT_IS_SELF_TAG_FRIEND;
            }
            else {
                sessionChatStructure.chatIsSelfTag = chatIsSelfTag;
            }
            sessionChatStructure.chatFlg = chatFlg;
            sessionChatStructure.chatUnread = chatUnread;
            sessionChatStructure.chatSendFlg = ChatSendFlg;
            sessionChatStructure.chatFireTime = ChatImageCount;
            sessionChatStructure.chatType = ChatType;
            NSString *string3 = [NSString stringWithUTF8String:chatImagePath];
            if (![string3 isEqualToString:kSqlForFieldEmpty]) {
                NSString *lbImageFilePath = [self conversionLibraryImagePathOne:string3];
                if (lbImageFilePath == nil) {
                    lbImageFilePath = string3;
                }
                sessionChatStructure.imagePathString = lbImageFilePath;
            }
            NSString *string4 = [NSString stringWithUTF8String:ChatThumbnailImagePath];
            if (![string4 isEqualToString:kSqlForFieldEmpty]) {
                NSString *lbImageFilePath = [self conversionLibraryImagePathOne:string4];
                if (lbImageFilePath == nil) {
                    lbImageFilePath = string4;
                }
                sessionChatStructure.thumbnailImagePath = lbImageFilePath;
            }
            sessionChatStructure.AudioMessageisUnRead = audioMessageisUnRead;
            NSString *string5 = [NSString stringWithUTF8String:guIdString];
            if (![string5 isEqualToString:kSqlForFieldEmpty]) {
                sessionChatStructure.chatGuIdString = string5;
            }
            sessionChatStructure.chatMessageId = messageId;
        //}
            [mtbArray addObject:sessionChatStructure];
        }
    }
    sqlite3_finalize(statement);
    return mtbArray;
}
- (NSMutableArray *)selectFromChatRecordTableForSqlId:(int)sqlId {
    NSMutableArray *mtbArray = [[NSMutableArray alloc] init];
    NSString *queryString = @"SELECT * FROM ChatRecordTable WHERE id = ?";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, nil) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, sqlId);
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int _id = sqlite3_column_int(statement, 0);
            type_base_id_int friendId = sqlite3_column_int(statement, 1);
            int friendClientType = sqlite3_column_int(statement, 2);
            char *chatContent = (char *)sqlite3_column_text(statement, 3);
            char *chatDatetime =  (char *)sqlite3_column_text(statement, 4);
            int chatIsSelfTag = sqlite3_column_int(statement, 5);
            type_base_id_int friendForMyid = sqlite3_column_int(statement, 6);
            int chatFlg = sqlite3_column_int(statement, 7);
            int chatUnread = sqlite3_column_int(statement, 8);
            int ChatSendFlg = sqlite3_column_int(statement, 9);
            int ChatImageCount = sqlite3_column_int(statement, 10);
            int ChatType = sqlite3_column_int(statement, 11);
            char *chatImagePath = (char *)sqlite3_column_text(statement, 12);
            char *ChatThumbnailImagePath = (char *)sqlite3_column_text(statement, 13);
            int audioMessageisUnRead = sqlite3_column_int(statement, 14);
            char *guIdString =  (char *)sqlite3_column_text(statement, 15);
            int messageId = sqlite3_column_int(statement, 16);
            //char *GuIdOriginal =  (char *)sqlite3_column_text(statement, 17);
            
            SessionChatStructure *sessionChatStructure = [[SessionChatStructure alloc] init];
        //{
            sessionChatStructure.chatSqlId = _id;
            sessionChatStructure.friendId = friendId;
            sessionChatStructure.friendClientType = friendClientType;
            sessionChatStructure.friendForMyId = friendForMyid;
            NSString *string1 = [NSString stringWithUTF8String:chatContent];
            if (![string1 isEqualToString:kSqlForFieldEmpty]) {
                sessionChatStructure.chatContentString = string1;
            }
            NSString *string2 = [NSString stringWithUTF8String:chatDatetime];
            if (![string2 isEqualToString:kSqlForFieldEmpty]) {
                sessionChatStructure.chatDatetimeSring = string2;
            }
            if (chatIsSelfTag == CHAT_IS_SELF_TAG_Init || chatIsSelfTag == CHAT_IS_SELF_TAG_Surplus) {
                sessionChatStructure.chatIsSelfTag = CHAT_IS_SELF_TAG_FRIEND;
            }
            else {
                sessionChatStructure.chatIsSelfTag = chatIsSelfTag;
            }
            sessionChatStructure.chatFlg = chatFlg;
            sessionChatStructure.chatUnread = chatUnread;
            sessionChatStructure.chatSendFlg = ChatSendFlg;
            sessionChatStructure.chatFireTime = ChatImageCount;
            sessionChatStructure.chatType = ChatType;
            NSString *string3 = [NSString stringWithUTF8String:chatImagePath];
            if (![string3 isEqualToString:kSqlForFieldEmpty]) {
                NSString *lbImageFilePath = [self conversionLibraryImagePathOne:string3];
                if (lbImageFilePath == nil) {
                    lbImageFilePath = string3;
                }
                sessionChatStructure.imagePathString = lbImageFilePath;
            }
            NSString *string4 = [NSString stringWithUTF8String:ChatThumbnailImagePath];
            if (![string4 isEqualToString:kSqlForFieldEmpty]) {
                NSString *lbImageFilePath = [self conversionLibraryImagePathOne:string4];
                if (lbImageFilePath == nil) {
                    lbImageFilePath = string4;
                }
                sessionChatStructure.thumbnailImagePath = lbImageFilePath;
            }
            sessionChatStructure.AudioMessageisUnRead = audioMessageisUnRead;
            NSString *string5 = [NSString stringWithUTF8String:guIdString];
            if (![string5 isEqualToString:kSqlForFieldEmpty]) {
                sessionChatStructure.chatGuIdString = string5;
            }
            sessionChatStructure.chatMessageId = messageId;
        //}
            [mtbArray addObject:sessionChatStructure];
        }
    }
    sqlite3_finalize(statement);
    return mtbArray;
}
- (NSMutableArray *)selectFromChatRecordTableForString:(NSString *)cString ForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId type:(int)type {
    NSString *string1 = kSqlForFieldEmpty;
    if ([cString length] > 0) {
        string1 = cString;
    }
    //
    NSMutableArray *mtbArray = [[NSMutableArray alloc] init];
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"SELECT * FROM ChatRecordTable WHERE FriendId = ? And FriendForMyId = ? And ChatDatetimeSring = ?";
    }
    else {
        queryString = @"SELECT * FROM ChatRecordTable WHERE FriendId = ? And FriendForMyId = ? And GuIdString = ?";
    }
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_int(statement, 1, _friendId);
            sqlite3_bind_int(statement, 2, _myId);
            sqlite3_bind_text(statement, 3, [string1 UTF8String], -1, SQLITE_TRANSIENT);
        }
        else {
            sqlite3_bind_int(statement, 1, _friendId);
            sqlite3_bind_int(statement, 2, _myId);
            sqlite3_bind_text(statement, 3, [string1 UTF8String], -1, SQLITE_TRANSIENT);
        }
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int _id = sqlite3_column_int(statement, 0);
            type_base_id_int friendId = sqlite3_column_int(statement, 1);
            int friendClientType = sqlite3_column_int(statement, 2);
            char *chatContent = (char *)sqlite3_column_text(statement, 3);
            char *chatDatetime =  (char *)sqlite3_column_text(statement, 4);
            int chatIsSelfTag = sqlite3_column_int(statement, 5);
            type_base_id_int friendForMyid = sqlite3_column_int(statement, 6);
            int chatFlg = sqlite3_column_int(statement, 7);
            int chatUnread = sqlite3_column_int(statement, 8);
            int ChatSendFlg = sqlite3_column_int(statement, 9);
            int ChatImageCount = sqlite3_column_int(statement, 10);
            int ChatType = sqlite3_column_int(statement, 11);
            char *chatImagePath = (char *)sqlite3_column_text(statement, 12);
            char *ChatThumbnailImagePath = (char *)sqlite3_column_text(statement, 13);
            int audioMessageisUnRead = sqlite3_column_int(statement, 14);
            char *guIdString =  (char *)sqlite3_column_text(statement, 15);
            int messageId = sqlite3_column_int(statement, 16);
            //char *GuIdOriginal =  (char *)sqlite3_column_text(statement, 17);
            
            SessionChatStructure *sessionChatStructure = [[SessionChatStructure alloc] init];
            //{
            sessionChatStructure.chatSqlId = _id;
            sessionChatStructure.friendId = friendId;
            sessionChatStructure.friendClientType = friendClientType;
            sessionChatStructure.friendForMyId = friendForMyid;
            NSString *string1 = [NSString stringWithUTF8String:chatContent];
            if (![string1 isEqualToString:kSqlForFieldEmpty]) {
                sessionChatStructure.chatContentString = string1;
            }
            NSString *string2 = [NSString stringWithUTF8String:chatDatetime];
            if (![string2 isEqualToString:kSqlForFieldEmpty]) {
                sessionChatStructure.chatDatetimeSring = string2;
            }
            if (chatIsSelfTag == CHAT_IS_SELF_TAG_Init || chatIsSelfTag == CHAT_IS_SELF_TAG_Surplus) {
                sessionChatStructure.chatIsSelfTag = CHAT_IS_SELF_TAG_FRIEND;
            }
            else {
                sessionChatStructure.chatIsSelfTag = chatIsSelfTag;
            }
            sessionChatStructure.chatFlg = chatFlg;
            sessionChatStructure.chatUnread = chatUnread;
            sessionChatStructure.chatSendFlg = ChatSendFlg;
            sessionChatStructure.chatFireTime = ChatImageCount;
            sessionChatStructure.chatType = ChatType;
            NSString *string3 = [NSString stringWithUTF8String:chatImagePath];
            if (![string3 isEqualToString:kSqlForFieldEmpty]) {
                NSString *lbImageFilePath = [self conversionLibraryImagePathOne:string3];
                if (lbImageFilePath == nil) {
                    lbImageFilePath = string3;
                }
                sessionChatStructure.imagePathString = lbImageFilePath;
            }
            NSString *string4 = [NSString stringWithUTF8String:ChatThumbnailImagePath];
            if (![string4 isEqualToString:kSqlForFieldEmpty]) {
                NSString *lbImageFilePath = [self conversionLibraryImagePathOne:string4];
                if (lbImageFilePath == nil) {
                    lbImageFilePath = string4;
                }
                sessionChatStructure.thumbnailImagePath = lbImageFilePath;
            }
            sessionChatStructure.AudioMessageisUnRead = audioMessageisUnRead;
            NSString *string5 = [NSString stringWithUTF8String:guIdString];
            if (![string5 isEqualToString:kSqlForFieldEmpty]) {
                sessionChatStructure.chatGuIdString = string5;
            }
            sessionChatStructure.chatMessageId = messageId;
            //}
            [mtbArray addObject:sessionChatStructure];
        }
    }
    sqlite3_finalize(statement);
    return mtbArray;
}
- (NSMutableArray *)selectFromChatRecordTableForStringOne:(NSString *)cString1 ForStringTwo:(NSString *)cString2 ForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId type:(int)type {
    //
    NSMutableArray *mtbArray = [[NSMutableArray alloc] init];
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"SELECT * FROM ChatRecordTable";
    }
    else {
        queryString = @"SELECT * FROM ChatRecordTable WHERE FriendId = ? And FriendForMyId = ? And ChatDatetimeSring = ? And ChatContent = ? order by id desc limit 0,1";
    }
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            
        }
        else {
            NSString *string1 = kSqlForFieldEmpty;
            if ([cString1 length] > 0) {
                string1 = cString1;
            }
            NSString *string2 = kSqlForFieldEmpty;
            if ([cString2 length] > 0) {
                string2 = cString2;
            }
            //
            sqlite3_bind_int(statement, 1, _friendId);
            sqlite3_bind_int(statement, 2, _myId);
            sqlite3_bind_text(statement, 3, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4, [string2 UTF8String], -1, SQLITE_TRANSIENT);
        }
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int _id = sqlite3_column_int(statement, 0);
            type_base_id_int friendId = sqlite3_column_int(statement, 1);
            int friendClientType = sqlite3_column_int(statement, 2);
            char *chatContent = (char *)sqlite3_column_text(statement, 3);
            char *chatDatetime =  (char *)sqlite3_column_text(statement, 4);
            int chatIsSelfTag = sqlite3_column_int(statement, 5);
            type_base_id_int friendForMyid = sqlite3_column_int(statement, 6);
            int chatFlg = sqlite3_column_int(statement, 7);
            int chatUnread = sqlite3_column_int(statement, 8);
            int ChatSendFlg = sqlite3_column_int(statement, 9);
            int ChatImageCount = sqlite3_column_int(statement, 10);
            int ChatType = sqlite3_column_int(statement, 11);
            char *chatImagePath = (char *)sqlite3_column_text(statement, 12);
            char *ChatThumbnailImagePath = (char *)sqlite3_column_text(statement, 13);
            int audioMessageisUnRead = sqlite3_column_int(statement, 14);
            char *guIdString =  (char *)sqlite3_column_text(statement, 15);
            int messageId = sqlite3_column_int(statement, 16);
            //char *GuIdOriginal =  (char *)sqlite3_column_text(statement, 17);
            
            SessionChatStructure *sessionChatStructure = [[SessionChatStructure alloc] init];
            //{
            sessionChatStructure.chatSqlId = _id;
            sessionChatStructure.friendId = friendId;
            sessionChatStructure.friendClientType = friendClientType;
            sessionChatStructure.friendForMyId = friendForMyid;
            NSString *string1 = [NSString stringWithUTF8String:chatContent];
            if (![string1 isEqualToString:kSqlForFieldEmpty]) {
                sessionChatStructure.chatContentString = string1;
            }
            NSString *string2 = [NSString stringWithUTF8String:chatDatetime];
            if (![string2 isEqualToString:kSqlForFieldEmpty]) {
                sessionChatStructure.chatDatetimeSring = string2;
            }
            if (chatIsSelfTag == CHAT_IS_SELF_TAG_Init || chatIsSelfTag == CHAT_IS_SELF_TAG_Surplus) {
                sessionChatStructure.chatIsSelfTag = CHAT_IS_SELF_TAG_FRIEND;
            }
            else {
                sessionChatStructure.chatIsSelfTag = chatIsSelfTag;
            }
            sessionChatStructure.chatFlg = chatFlg;
            sessionChatStructure.chatUnread = chatUnread;
            sessionChatStructure.chatSendFlg = ChatSendFlg;
            sessionChatStructure.chatFireTime = ChatImageCount;
            sessionChatStructure.chatType = ChatType;
            NSString *string3 = [NSString stringWithUTF8String:chatImagePath];
            if (![string3 isEqualToString:kSqlForFieldEmpty]) {
                NSString *lbImageFilePath = [self conversionLibraryImagePathOne:string3];
                if (lbImageFilePath == nil) {
                    lbImageFilePath = string3;
                }
                sessionChatStructure.imagePathString = lbImageFilePath;
            }
            NSString *string4 = [NSString stringWithUTF8String:ChatThumbnailImagePath];
            if (![string4 isEqualToString:kSqlForFieldEmpty]) {
                NSString *lbImageFilePath = [self conversionLibraryImagePathOne:string4];
                if (lbImageFilePath == nil) {
                    lbImageFilePath = string4;
                }
                sessionChatStructure.thumbnailImagePath = lbImageFilePath;
            }
            sessionChatStructure.AudioMessageisUnRead = audioMessageisUnRead;
            NSString *string5 = [NSString stringWithUTF8String:guIdString];
            if (![string5 isEqualToString:kSqlForFieldEmpty]) {
                sessionChatStructure.chatGuIdString = string5;
            }
            sessionChatStructure.chatMessageId = messageId;
            //}
            [mtbArray addObject:sessionChatStructure];
        }
    }
    sqlite3_finalize(statement);
    return mtbArray;
}

- (NSMutableArray *)selectFromChatRecordTableForChatMessageid:(int)_messageid ForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId type:(int)type {
    //
    NSMutableArray *mtbArray = [[NSMutableArray alloc] init];
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"SELECT * FROM ChatRecordTable WHERE FriendId = ? And FriendForMyId = ? And ChatMessageId = ?";
    }
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_int(statement, 1, _friendId);
            sqlite3_bind_int(statement, 2, _myId);
            sqlite3_bind_int(statement, 3, _messageid);
        }
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int _id = sqlite3_column_int(statement, 0);
            type_base_id_int friendId = sqlite3_column_int(statement, 1);
            int friendClientType = sqlite3_column_int(statement, 2);
            char *chatContent = (char *)sqlite3_column_text(statement, 3);
            char *chatDatetime =  (char *)sqlite3_column_text(statement, 4);
            int chatIsSelfTag = sqlite3_column_int(statement, 5);
            type_base_id_int friendForMyid = sqlite3_column_int(statement, 6);
            int chatFlg = sqlite3_column_int(statement, 7);
            int chatUnread = sqlite3_column_int(statement, 8);
            int ChatSendFlg = sqlite3_column_int(statement, 9);
            int ChatImageCount = sqlite3_column_int(statement, 10);
            int ChatType = sqlite3_column_int(statement, 11);
            char *chatImagePath = (char *)sqlite3_column_text(statement, 12);
            char *ChatThumbnailImagePath = (char *)sqlite3_column_text(statement, 13);
            int audioMessageisUnRead = sqlite3_column_int(statement, 14);
            char *guIdString =  (char *)sqlite3_column_text(statement, 15);
            int messageId = sqlite3_column_int(statement, 16);
            //char *GuIdOriginal =  (char *)sqlite3_column_text(statement, 17);
            
            SessionChatStructure *sessionChatStructure = [[SessionChatStructure alloc] init];
            //{
            sessionChatStructure.chatSqlId = _id;
            sessionChatStructure.friendId = friendId;
            sessionChatStructure.friendClientType = friendClientType;
            sessionChatStructure.friendForMyId = friendForMyid;
            NSString *string1 = [NSString stringWithUTF8String:chatContent];
            if (![string1 isEqualToString:kSqlForFieldEmpty]) {
                sessionChatStructure.chatContentString = string1;
            }
            NSString *string2 = [NSString stringWithUTF8String:chatDatetime];
            if (![string2 isEqualToString:kSqlForFieldEmpty]) {
                sessionChatStructure.chatDatetimeSring = string2;
            }
            if (chatIsSelfTag == CHAT_IS_SELF_TAG_Init || chatIsSelfTag == CHAT_IS_SELF_TAG_Surplus) {
                sessionChatStructure.chatIsSelfTag = CHAT_IS_SELF_TAG_FRIEND;
            }
            else {
                sessionChatStructure.chatIsSelfTag = chatIsSelfTag;
            }
            sessionChatStructure.chatFlg = chatFlg;
            sessionChatStructure.chatUnread = chatUnread;
            sessionChatStructure.chatSendFlg = ChatSendFlg;
            sessionChatStructure.chatFireTime = ChatImageCount;
            sessionChatStructure.chatType = ChatType;
            NSString *string3 = [NSString stringWithUTF8String:chatImagePath];
            if (![string3 isEqualToString:kSqlForFieldEmpty]) {
                NSString *lbImageFilePath = [self conversionLibraryImagePathOne:string3];
                if (lbImageFilePath == nil) {
                    lbImageFilePath = string3;
                }
                sessionChatStructure.imagePathString = lbImageFilePath;
            }
            NSString *string4 = [NSString stringWithUTF8String:ChatThumbnailImagePath];
            if (![string4 isEqualToString:kSqlForFieldEmpty]) {
                NSString *lbImageFilePath = [self conversionLibraryImagePathOne:string4];
                if (lbImageFilePath == nil) {
                    lbImageFilePath = string4;
                }
                sessionChatStructure.thumbnailImagePath = lbImageFilePath;
            }
            sessionChatStructure.AudioMessageisUnRead = audioMessageisUnRead;
            NSString *string5 = [NSString stringWithUTF8String:guIdString];
            if (![string5 isEqualToString:kSqlForFieldEmpty]) {
                sessionChatStructure.chatGuIdString = string5;
            }
            sessionChatStructure.chatMessageId = messageId;
            //}
            [mtbArray addObject:sessionChatStructure];
        }
    }
    sqlite3_finalize(statement);
    return mtbArray;
}


- (void)insertFromChatRecordTableForStructure:(SessionChatStructure *)sessionChatStructure {
    //1.
    NSString *string1 = kSqlForFieldEmpty;
    if ([sessionChatStructure.chatContentString length] > 0) {
        string1 = sessionChatStructure.chatContentString;
    }
    NSString *string2 = kSqlForFieldEmpty;
    if ([sessionChatStructure.chatDatetimeSring length] > 0) {
        string2 = sessionChatStructure.chatDatetimeSring;
    }
    NSString *string3 = kSqlForFieldEmpty;
    if ([sessionChatStructure.imagePathString length] > 0) {
        string3 = sessionChatStructure.imagePathString;
    }
    NSString *string4 = kSqlForFieldEmpty;
    if ([sessionChatStructure.thumbnailImagePath length] > 0) {
        string4 = sessionChatStructure.thumbnailImagePath;
    }
    NSString *string5 = kSqlForFieldEmpty;
    if ([sessionChatStructure.chatGuIdString length] > 0) {
        string5 = sessionChatStructure.chatGuIdString;
    }
    //2.
    char *insertDataChar = "INSERT OR REPLACE INTO ChatRecordTable (FriendId,FriendClientType,ChatContent,ChatDatetimeSring,ChatIsSelfTag,FriendForMyId,ChatFlg,ChatUnread,ChatSendFlg,ChatImageCount,ChatType,ChatImagePath,ChatThumbnailImagePath,AudioMessageisUnRead,GuIdString,ChatMessageId) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";//char *GuIdOriginal =  (char *)sqlite3_column_text(statement, 17);
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, insertDataChar , -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, sessionChatStructure.friendId);
        sqlite3_bind_int(statement, 2, sessionChatStructure.friendClientType);
        sqlite3_bind_text(statement, 3, [string1 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [string2 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 5, sessionChatStructure.chatIsSelfTag);
        sqlite3_bind_int(statement, 6, sessionChatStructure.friendForMyId);
        sqlite3_bind_int(statement, 7, sessionChatStructure.chatFlg);
        sqlite3_bind_int(statement, 8, sessionChatStructure.chatUnread);
        sqlite3_bind_int(statement, 9, sessionChatStructure.chatSendFlg);
        sqlite3_bind_int(statement, 10, sessionChatStructure.chatFireTime);
        sqlite3_bind_int(statement, 11, sessionChatStructure.chatType);
        sqlite3_bind_text(statement, 12, [string3 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 13, [string4 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 14, sessionChatStructure.AudioMessageisUnRead);
        sqlite3_bind_text(statement, 15, [string5 UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 16, sessionChatStructure.chatMessageId);
        if (sqlite3_step(statement) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of insertFromChatRecordTableForStructure '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of insertFromChatRecordTableForStructure '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(statement);
}
- (void)updateFromChatRecordTableForStructure:(SessionChatStructure *)sessionChatStructure type:(int)type {
    //
    NSString *string1 = kSqlForFieldEmpty;
    if ([sessionChatStructure.chatContentString length] > 0) {
        string1 = sessionChatStructure.chatContentString;
    }
    NSString *string2 = kSqlForFieldEmpty;
    if ([sessionChatStructure.chatDatetimeSring length] > 0) {
        string2 = sessionChatStructure.chatDatetimeSring;
    }
    NSString *string3 = kSqlForFieldEmpty;
    if ([sessionChatStructure.imagePathString length] > 0) {
        string3 = sessionChatStructure.imagePathString;
    }
    NSString *string4 = kSqlForFieldEmpty;
    if ([sessionChatStructure.thumbnailImagePath length] > 0) {
        string4 = sessionChatStructure.thumbnailImagePath;
    }
    NSString *string5 = kSqlForFieldEmpty;
    if ([sessionChatStructure.chatGuIdString length] > 0) {
        string5 = sessionChatStructure.chatGuIdString;
    }
    //
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"UPDATE ChatRecordTable SET ChatUnread=? WHERE id = ?";
    }
    else if (type == SQL_IF_TYPE_SECOND) {
        queryString = @"UPDATE ChatRecordTable SET ChatUnread=? WHERE FriendId = ? And FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_THIRD){
        queryString = @"UPDATE ChatRecordTable SET ChatContent=? WHERE id = ? And FriendId = ? And FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_FOUR) {
        queryString = @"UPDATE ChatRecordTable SET ChatSendFlg=? WHERE id = ? And FriendId = ? And FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_SIX) {
        queryString = @"UPDATE ChatRecordTable SET ChatContent=?,ChatType=?,ChatImagePath=?,ChatThumbnailImagePath=? WHERE id = ? And FriendId = ? And FriendForMyId = ?";
    }
    else {
        queryString = @"UPDATE ChatRecordTable SET FriendClientType=?,ChatContent=?,ChatDatetimeSring=?,ChatIsSelfTag=?,ChatFlg=?,ChatUnread=?,ChatSendFlg=?,ChatImageCount=?,ChatType=?,ChatImagePath=?,ChatThumbnailImagePath=?,AudioMessageisUnRead=? WHERE FriendId = ? And FriendForMyId = ? And GuIdString = ?";
    }
    //char *GuIdOriginal =  (char *)sqlite3_column_text(statement, 17);
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_int(stmt, 1, sessionChatStructure.chatUnread);
            sqlite3_bind_int(stmt, 2, sessionChatStructure.chatSqlId);
        }
        else if (type == SQL_IF_TYPE_SECOND) {
            sqlite3_bind_int(stmt, 1, sessionChatStructure.chatUnread);
            sqlite3_bind_int(stmt, 2, sessionChatStructure.friendId);
            sqlite3_bind_int(stmt, 3, sessionChatStructure.friendForMyId);
        }
        else if (type == SQL_IF_TYPE_THIRD) {
            sqlite3_bind_text(stmt, 1, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, sessionChatStructure.chatSqlId);
            sqlite3_bind_int(stmt, 3, sessionChatStructure.friendId);
            sqlite3_bind_int(stmt, 4, sessionChatStructure.friendForMyId);
        }
        else if (type == SQL_IF_TYPE_FOUR) {
            sqlite3_bind_int(stmt, 1, sessionChatStructure.chatSendFlg);
            sqlite3_bind_int(stmt, 2, sessionChatStructure.chatSqlId);
            sqlite3_bind_int(stmt, 3, sessionChatStructure.friendId);
            sqlite3_bind_int(stmt, 4, sessionChatStructure.friendForMyId);
        }
        else if (type == SQL_IF_TYPE_FIVE) {
            sqlite3_bind_text(stmt, 1, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, sessionChatStructure.chatIsSelfTag);
            sqlite3_bind_int(stmt, 3, sessionChatStructure.chatSqlId);
            sqlite3_bind_int(stmt, 4, sessionChatStructure.friendId);
            sqlite3_bind_int(stmt, 5, sessionChatStructure.friendForMyId);
        }
        else if (type == SQL_IF_TYPE_SIX) {
            sqlite3_bind_text(stmt, 1, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, sessionChatStructure.chatType);
            sqlite3_bind_text(stmt, 3, [string3 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 4, [string4 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 5, sessionChatStructure.chatSqlId);
            sqlite3_bind_int(stmt, 6, sessionChatStructure.friendId);
            sqlite3_bind_int(stmt, 7, sessionChatStructure.friendForMyId);
        }
        else {
            sqlite3_bind_int(stmt, 1, sessionChatStructure.friendClientType);
            sqlite3_bind_text(stmt, 2, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 3, [string2 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 4, sessionChatStructure.chatIsSelfTag);
            sqlite3_bind_int(stmt, 5, sessionChatStructure.chatFlg);
            sqlite3_bind_int(stmt, 6, sessionChatStructure.chatUnread);
            sqlite3_bind_int(stmt, 7, sessionChatStructure.chatSendFlg);
            sqlite3_bind_int(stmt, 8, sessionChatStructure.chatFireTime);
            sqlite3_bind_int(stmt, 9, sessionChatStructure.chatType);
            sqlite3_bind_text(stmt, 10, [string3 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(stmt, 11, [string4 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 12, sessionChatStructure.AudioMessageisUnRead);
            sqlite3_bind_int(stmt, 13, sessionChatStructure.friendId);
            sqlite3_bind_int(stmt, 14, sessionChatStructure.friendForMyId);
            sqlite3_bind_text(stmt, 15, [string5 UTF8String], -1, SQLITE_TRANSIENT);
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updateFromChatRecordTableForStructure '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromChatRecordTableForStructure '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}
- (void)updateFromChatRecordTableForChatUnread:(int)chatUnread ForFriendId:(type_base_id_int)friendId ForFriendForMyId:(type_base_id_int)friendForMyId ForChatSqlId:(int)sqlId type:(int)type {
    //
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"UPDATE ChatRecordTable SET ChatUnread=? WHERE id = ?";
    }
    else {
        queryString = @"UPDATE ChatRecordTable SET ChatUnread=? WHERE FriendId = ? And FriendForMyId = ?";
    }
    //char *GuIdOriginal =  (char *)sqlite3_column_text(statement, 17);
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_int(stmt, 1, chatUnread);
            sqlite3_bind_int(stmt, 2, sqlId);
        }
        else {
            sqlite3_bind_int(stmt, 1, chatUnread);
            sqlite3_bind_int(stmt, 2, friendId);
            sqlite3_bind_int(stmt, 3, friendForMyId);
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updateFromChatRecordTableForChatUnread '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromChatRecordTableForChatUnread '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}
- (void)updateFromChatRecordTableForFriendId:(type_base_id_int)friendId ForFriendForMyId:(type_base_id_int)friendForMyId ForChatSqlId:(int)sqlId ForChatSendFlg:(int)sendFlg type:(int)type {
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"UPDATE ChatRecordTable SET ChatSendFlg=? WHERE id = ? And FriendId = ? And FriendForMyId = ?";
    }
    else {
        queryString = @"UPDATE ChatRecordTable SET ChatSendFlg=? WHERE FriendId = ? And FriendForMyId = ? And ChatSendFlg > ?";
    }
    //char *GuIdOriginal =  (char *)sqlite3_column_text(statement, 17);
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_int(stmt, 1, sendFlg);
            sqlite3_bind_int(stmt, 2, sqlId);
            sqlite3_bind_int(stmt, 3, friendId);
            sqlite3_bind_int(stmt, 4, friendForMyId);
        }
        else {
            sqlite3_bind_int(stmt, 1, sendFlg);
            sqlite3_bind_int(stmt, 2, friendId);
            sqlite3_bind_int(stmt, 3, friendForMyId);
            sqlite3_bind_int(stmt, 4, sqlId);
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updateFromChatRecordTableForFriendId '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromChatRecordTableForFriendId '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}

//更改数据库中的发送状态为失败
- (void)updateFromChatRecordTableToSendFailed{
    NSString *queryString = @"UPDATE ChatRecordTable SET ChatSendFlg=3 WHERE ChatSendFlg=1";
    
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
        int success = sqlite3_step(stmt);
        if ( success != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updataFromeGroupChatRecordTebleSendFailed '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromChatRecordTableForFriendId '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}
- (void)updataFromeGroupChatRecordTebleSendFailed{
    NSString *queryString = @"UPDATE GroupChatListTable SET ChatSendFlg=3 WHERE ChatSendFlg=1";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
        int success = sqlite3_step(stmt);
        if ( success != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updataFromeGroupChatRecordTebleSendFailed '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromChatRecordTableForFriendId '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}
- (void)updateFromChatRecordTableForMsgid:(int)msgid ForFriendId:(type_base_id_int)friendId ForFriendForMyId:(type_base_id_int)friendForMyId ForChatSqlId:(int)sqlId ForChatSendFlg:(int)sendFlg type:(int)type {
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"UPDATE ChatRecordTable SET ChatSendFlg=?,ChatMessageId = ? WHERE id = ? And FriendId = ? And FriendForMyId = ?";
    }
    else {
        queryString = @"UPDATE ChatRecordTable SET ChatSendFlg=?,ChatMessageId = ? WHERE FriendId = ? And FriendForMyId = ? And ChatSendFlg > ?";
    }
    //char *GuIdOriginal =  (char *)sqlite3_column_text(statement, 17);
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_int(stmt, 1, sendFlg);
            sqlite3_bind_int(stmt, 2, msgid);
            sqlite3_bind_int(stmt, 3, sqlId);
            sqlite3_bind_int(stmt, 4, friendId);
            sqlite3_bind_int(stmt, 5, friendForMyId);
        }
        else {
            sqlite3_bind_int(stmt, 1, sendFlg);
            sqlite3_bind_int(stmt, 2, msgid);
            sqlite3_bind_int(stmt, 3, friendId);
            sqlite3_bind_int(stmt, 4, friendForMyId);
            sqlite3_bind_int(stmt, 5, sqlId);
         
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updateFromChatRecordTableForFriendId '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromChatRecordTableForFriendId '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}


- (void)updateFromChatRecordTableForFriendIdTwo:(type_base_id_int)friendId ForFriendForMyId:(type_base_id_int)friendForMyId ForChatSqlId:(int)sqlId forTimeString:(NSString *)TimeString type:(int)type {
    NSString *string1 = kSqlForFieldEmpty;
    if ([TimeString length] > 0) {
        string1 = TimeString;
    }
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"UPDATE ChatRecordTable SET ChatDatetimeSring=? WHERE id = ? And FriendId = ? And FriendForMyId = ?";
    }
    else {
        queryString = @"UPDATE ChatRecordTable SET ChatDatetimeSring=? WHERE id = ? And FriendId = ? And FriendForMyId = ?";
    }
    //char *GuIdOriginal =  (char *)sqlite3_column_text(statement, 17);
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_text(stmt, 1, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, sqlId);
            sqlite3_bind_int(stmt, 3, friendId);
            sqlite3_bind_int(stmt, 4, friendForMyId);
        }
        else {
            sqlite3_bind_text(stmt, 1, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, sqlId);
            sqlite3_bind_int(stmt, 3, friendId);
            sqlite3_bind_int(stmt, 4, friendForMyId);
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updateFromChatRecordTableForFriendId '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromChatRecordTableForFriendId '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}
-(void)updateFromChatRecordTableForChatSqlId:(int)sqlId ForAudioMessageisUnReadflg:(int)AudioMessageisUnRead
{
    NSString*qurryString=@"UPDATE ChatRecordTable SET AudioMessageisUnRead=? WHERE id=? ";
    //char *GuIdOriginal =  (char *)sqlite3_column_text(statement, 17);
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [qurryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, AudioMessageisUnRead);
        sqlite3_bind_int(stmt, 2, sqlId);
        if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updateFromChatRecordTableForChatSqlId '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromChatRecordTableForChatSqlId '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}
-(void)updateFromChatRecordTableForGuIdString:(NSString *)guIdString type:(int)type
{
    NSString *string1 = kSqlForFieldEmpty;
    if ([guIdString length] > 0) {
        string1 = guIdString;
    }
    NSString *libraryPath = [self libraryPathSearchPath];
    NSString *dbPath = [self getPath:libraryPath sqlName:kFriendInfoSqlName];
    BOOL isOpen = [self openSqllite:dbPath];
    if (isOpen == YES) {
        NSString *qurryString = @"";
        if (type == SQL_IF_TYPE_FIRST) {
            qurryString = @"UPDATE ChatRecordTable SET GuIdString = ? ";
        }
        else {
            qurryString = @"UPDATE ChatRecordTable SET GuIdOriginal = ? ";
        }
        sqlite3_stmt *stmt;
        if (sqlite3_prepare_v2(database, [qurryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
            sqlite3_bind_text(stmt, 1, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
                NSAssert1(0, @"Error: failed to updating method of updateFromChatRecordTableForGuIdString '%s'.", sqlite3_errmsg(database));
#else
                //NSLog(@"Error: failed to updating method of updateFromChatRecordTableForGuIdString '%s'.",sqlite3_errmsg(database));
#endif
            }
        }
        sqlite3_finalize(stmt);
        sqlite3_close(database);
    }
}
-(void)updateFromChatRecordTableForGuIdStringTwo:(NSString *)guIdString ForFriendId:(type_base_id_int)friendId ForFriendForMyId:(type_base_id_int)friendForMyId ForChatSqlId:(int)sqlId type:(int)type {
    NSString *string1 = kSqlForFieldEmpty;
    if ([guIdString length] > 0) {
        string1 = guIdString;
    }
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"UPDATE ChatRecordTable SET GuIdString=? WHERE id = ? And FriendId = ? And FriendForMyId = ?";
    }
    else {
        queryString = @"UPDATE ChatRecordTable SET GuIdString=? WHERE id = ? And FriendId = ? And FriendForMyId = ?";
    }
    //char *GuIdOriginal =  (char *)sqlite3_column_text(statement, 17);
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_text(stmt, 1, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, sqlId);
            sqlite3_bind_int(stmt, 3, friendId);
            sqlite3_bind_int(stmt, 4, friendForMyId);
        }
        else {
            sqlite3_bind_text(stmt, 1, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, sqlId);
            sqlite3_bind_int(stmt, 3, friendId);
            sqlite3_bind_int(stmt, 4, friendForMyId);
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updateFromChatRecordTableForGuIdStringTwo '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromChatRecordTableForGuIdStringTwo '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}

-(void)updateFromChatRecordTableForGuIdStringThree:(NSString *)guIdString ForFriendId:(type_base_id_int)friendId ForFriendForMyId:(type_base_id_int)friendForMyId ForChatSqlId:(int)sqlId ForChatMessageId:(int)chatMessageId type:(int)type {
    NSString *string1 = kSqlForFieldEmpty;
    if ([guIdString length] > 0) {
        string1 = guIdString;
    }
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"UPDATE ChatRecordTable SET GuIdString=? WHERE id = ? And FriendId = ? And FriendForMyId = ? And ChatMessageId = ?";
    }
    else {
        queryString = @"UPDATE ChatRecordTable SET GuIdString=? WHERE id = ? And FriendId = ? And FriendForMyId = ? And ChatMessageId = ?";
    }
    //char *GuIdOriginal =  (char *)sqlite3_column_text(statement, 17);
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_text(stmt, 1, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, sqlId);
            sqlite3_bind_int(stmt, 3, friendId);
            sqlite3_bind_int(stmt, 4, friendForMyId);
            sqlite3_bind_int(stmt, 5, chatMessageId);
        }
        else {
            sqlite3_bind_text(stmt, 1, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(stmt, 2, sqlId);
            sqlite3_bind_int(stmt, 3, friendId);
            sqlite3_bind_int(stmt, 4, friendForMyId);
            sqlite3_bind_int(stmt, 5, chatMessageId);
        }
        if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updateFromChatRecordTableForGuIdStringTwo '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromChatRecordTableForGuIdStringTwo '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}

- (void)deleteFromChatRecordTableForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId type:(int)type {
    NSString *queryString = nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"DELETE FROM ChatRecordTable WHERE FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_SECOND) {
        queryString = @"DELETE FROM ChatRecordTable WHERE FriendId = ? and FriendForMyId = ?";
    }
    else if (type == SQL_IF_TYPE_THIRD){
        queryString = @"DELETE FROM ChatRecordTable WHERE FriendId = ? and FriendForMyId = ? And ChatFlg = 8";
    }
    else {
        queryString = @"DELETE FROM ChatRecordTable WHERE FriendId = ? and FriendForMyId = ? And ChatFlg = 0";
    }
    //char *GuIdOriginal =  (char *)sqlite3_column_text(statement, 17);
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_int(statement, 1, _myId);
        }
        else if (type == SQL_IF_TYPE_SECOND) {
            sqlite3_bind_int(statement, 1, _friendId);
            sqlite3_bind_int(statement, 2, _myId);
        }
        else {
            sqlite3_bind_int(statement, 1, _friendId);
            sqlite3_bind_int(statement, 2, _myId);
        }
        if (sqlite3_step(statement) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of deleteFromChatRecordTableForFriendId '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of deleteFromChatRecordTableForFriendId '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(statement);
}
- (void)deleteFromChatRecordTableForSqlId:(int)sqlId {
    NSString *queryString = @"DELETE FROM ChatRecordTable WHERE id = ?";
    //char *GuIdOriginal =  (char *)sqlite3_column_text(statement, 17);
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, sqlId);
        if (sqlite3_step(statement) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of deleteFromChatRecordTableForSqlId '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of deleteFromChatRecordTableForSqlId '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(statement);
}
//}
//ChatRecordImageIndexTable
//FriendId,FriendForMyId,ImageIndex
//{
- (NSMutableArray *)selectFromChatRecordImageIndexTable {
    NSMutableArray *mtbArray = [[NSMutableArray alloc] init];
    NSString *queryString = @"SELECT * FROM ChatRecordImageIndexTable";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //int _id = sqlite3_column_int(statement, 0);
            type_base_id_int friendId = sqlite3_column_int(statement, 1);
            type_base_id_int friendForMyid = sqlite3_column_int(statement, 2);
            long long int imageIndex = sqlite3_column_int64(statement, 3);
            
            SessionChatImageIndexStructure *sessionChatImageIndexStructure = [[SessionChatImageIndexStructure alloc] init];
            sessionChatImageIndexStructure.friendId = friendId;
            sessionChatImageIndexStructure.friendForMyid = friendForMyid;
            sessionChatImageIndexStructure.imageIndex = imageIndex;
            [mtbArray addObject:sessionChatImageIndexStructure];
        }
    }
    sqlite3_finalize(statement);
    return mtbArray;
}
- (NSMutableArray *)selectFromChatRecordImageIndexTableForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId {
    NSMutableArray *mtbArray = [[NSMutableArray alloc] init];
    NSString *queryString = @"SELECT * FROM ChatRecordImageIndexTable WHERE FriendId = ? And FriendForMyId = ?";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, nil) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, _friendId);
        sqlite3_bind_int(statement, 2, _myId);
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //int _id = sqlite3_column_int(statement, 0);
            type_base_id_int friendId = sqlite3_column_int(statement, 1);
            type_base_id_int friendForMyid = sqlite3_column_int(statement, 2);
            long long int imageIndex = sqlite3_column_int64(statement, 3);
            
            SessionChatImageIndexStructure *sessionChatImageIndexStructure = [[SessionChatImageIndexStructure alloc] init];
            sessionChatImageIndexStructure.friendId = friendId;
            sessionChatImageIndexStructure.friendForMyid = friendForMyid;
            sessionChatImageIndexStructure.imageIndex = imageIndex;
            [mtbArray addObject:sessionChatImageIndexStructure];
        }
    }
    sqlite3_finalize(statement);
    return mtbArray;
}
- (void)insertFromChatRecordImageIndexTableForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId ForImageIndex:(long long int)imageIndex {
    char *insertDataChar = "INSERT OR REPLACE INTO ChatRecordImageIndexTable (FriendId,FriendForMyId,ImageIndex) VALUES (?,?,?)";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, insertDataChar , -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, _friendId);
        sqlite3_bind_int(statement, 2, _myId);
        sqlite3_bind_int64(statement, 3, imageIndex);
        if (sqlite3_step(statement) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of insertFromChatRecordImageIndexTableForFriendId '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of insertFromChatRecordImageIndexTableForFriendId '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(statement);
}
- (void)updateFromChatRecordImageIndexTableForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId ForImageIndex:(long long int)imageIndex {
    NSString *queryString = @"UPDATE ChatRecordImageIndexTable SET ImageIndex=? WHERE FriendId = ? And FriendForMyId = ?";
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [queryString UTF8String] , -1, &stmt, NULL) == SQLITE_OK) {
        sqlite3_bind_int64(stmt, 1, imageIndex);
        sqlite3_bind_int(stmt, 2, _friendId);
        sqlite3_bind_int(stmt, 3, _myId);
        if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of updateFromChatRecordImageIndexTableForFriendId '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of updateFromChatRecordImageIndexTableForFriendId '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(stmt);
}

- (void)updateFromGroupChatListTableForChatMessage:(NSString *)chatMessage ForChatSqlId:(int)chatSqlId {
  NSString *queryString = nil;
  queryString = @"UPDATE GroupChatListTable SET ChatMessage=? WHERE id = ?";
  sqlite3_stmt *stmt;
  if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
    sqlite3_bind_text(stmt, 1, [chatMessage UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(stmt, 2, chatSqlId);
    if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
      NSAssert1(0, @"Error: failed to updating method of updateFromChatRecordImageIndexTableForFriendId '%s'.", sqlite3_errmsg(database));
#else
#endif
    }
  }
  sqlite3_finalize(stmt);
}

- (void)updateFromFrendChatListTableForChatMessage:(NSString *)chatMessage ForChatSqlId:(int)chatSqlId {
  NSString *queryString = nil;
  queryString = @"UPDATE ChatRecordTable SET ChatContent=? WHERE id = ?";
  sqlite3_stmt *stmt;
  if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &stmt, NULL) == SQLITE_OK) {
    sqlite3_bind_text(stmt, 1, [chatMessage UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(stmt, 2, chatSqlId);
    if (sqlite3_step(stmt) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
      NSAssert1(0, @"Error: failed to updating method of updateFromChatRecordImageIndexTableForFriendId '%s'.", sqlite3_errmsg(database));
#else
#endif
    }
  }
  sqlite3_finalize(stmt);
}

- (void)deleteFromChatRecordImageIndexTableForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId {
    NSString *queryString = @"DELETE FROM ChatRecordImageIndexTable WHERE FriendId = ? and FriendForMyId = ?";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, _friendId);
        sqlite3_bind_int(statement, 2, _myId);
        if (sqlite3_step(statement) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of deleteFromChatRecordImageIndexTableForFriendId '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of deleteFromChatRecordImageIndexTableForFriendId '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(statement);
}
//}
#pragma mark- ShowGroupTable {
//ShowGroupTableK
//{
//- (void)insertFromShowGroupTableForStructure:(ShowGroupStructure *)showGroupStructure {
//    //1.
//    NSString *string1 = kSqlForFieldEmpty;
//    if ([showGroupStructure.showGroupIconPath length] > 0) {
//        string1 = showGroupStructure.showGroupIconPath;
//    }
//    NSString *string2 = kSqlForFieldEmpty;
//    if ([showGroupStructure.showGroupContent length] > 0) {
//        string2 = showGroupStructure.showGroupContent;
//    }
//    NSString *string3 = kSqlForFieldEmpty;
//    if ([showGroupStructure.showGroupDetailSring length] > 0) {
//        string3 = showGroupStructure.showGroupDetailSring;
//    }
//    //2.
//    char *errorMsg = "";
//    char *insertDataChar = "INSERT OR REPLACE INTO ShowGroupTable (ShowGroupId,ShowGroupIconPath,ShowGroupContent,ShowGroupDetailSring,showGroupVerification) VALUES (?,?,?,?,?)";
//    sqlite3_stmt *statement;
//    if (sqlite3_prepare_v2(database, insertDataChar , -1, &statement, NULL) == SQLITE_OK) {
//        sqlite3_bind_int64(statement, 1, showGroupStructure.showGroupId);
//        sqlite3_bind_text(statement, 2, [string1 UTF8String], -1, SQLITE_TRANSIENT);
//        sqlite3_bind_text(statement, 3, [string2 UTF8String], -1, SQLITE_TRANSIENT);
//        sqlite3_bind_text(statement, 4, [string3 UTF8String], -1, SQLITE_TRANSIENT);
//        sqlite3_bind_int(statement, 5, showGroupStructure.showGroupVerification);
//        if (sqlite3_step(statement) != SQLITE_DONE) {
//            NSAssert1 (0,@"Error updating table: %s",errorMsg);
//        }
//    }
//    sqlite3_finalize(statement);
//}
//}
#pragma mark }
#pragma mark ShieldTable {
- (NSMutableArray *)sqlSelectfromEnterShieldCollectTableForUserId:(type_base_id_int)userId forMyId:(type_base_id_int)myId forShieldFlg:(int)flg type:(int)type {
    NSMutableArray * mtbArray = [[NSMutableArray alloc] init];
    NSString *queryString =nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString = @"SELECT * FROM ShieldTable WHERE UserId = ? And MyId=?";
    }
    else {
        queryString = @"SELECT * FROM ShieldTable WHERE UserId = ? And MyId=? And ShieldFlg=?";
    }
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, nil) == SQLITE_OK) {
        if (type == SQL_IF_TYPE_FIRST) {
            sqlite3_bind_int(statement, 1, userId);
            sqlite3_bind_int(statement, 2, myId);
        }
        else {
            sqlite3_bind_int(statement, 1, userId);
            sqlite3_bind_int(statement, 2, myId);
            sqlite3_bind_int(statement, 3, flg);
        }
        //
        while (sqlite3_step(statement) == SQLITE_ROW) {
            type_base_id_int userId = sqlite3_column_int(statement, 1);
//            int shieldFlg = sqlite3_column_int(statement, 2);
            //
            FriendInfoStructure * friendInfoStructure = [[FriendInfoStructure alloc] init];
            //{
            friendInfoStructure.friendId = userId;
            //}
            [mtbArray addObject:friendInfoStructure];
        }
    }
    sqlite3_finalize(statement);
    return mtbArray;
}

- (void)sqlInsertfromShieldCollectTableUserId:(type_base_id_int)userId forMyId:(type_base_id_int)myId ForShieldFlg:(int)flg {
    char *insertDataChar = "INSERT OR REPLACE INTO ShieldTable (UserId,MyId,ShieldFlg) VALUES (?,?,?)";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, insertDataChar , -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, userId);
        sqlite3_bind_int(statement, 2, myId);
        sqlite3_bind_int(statement, 3, flg);
        if (sqlite3_step(statement) != SQLITE_DONE) {
            
        }
    }
    sqlite3_finalize(statement);
}
- (void)deleteFromShieldCollectTable:(type_base_id_int )userId forMyId:(type_base_id_int)myId {
    NSString *queryString = @"DELETE FROM ShieldTable WHERE UserId = ? And MyId=?";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int64(statement, 1, userId);
        sqlite3_bind_int(statement, 2, myId);
        if (sqlite3_step(statement) != SQLITE_DONE) {
            
        }
    }
    sqlite3_finalize(statement);
}
#pragma mark }
//TransactionMessageTable
//目前每个账号只存一个信息
- (NSMutableArray *)sqlSelectfromEnterTransactionMessageTableForMyId:(type_base_id_int)_myId Product_Identifier:(NSString *)product_Identifier TransactionIdentifier:(NSString * )transactionIdentifier type:(int)type{
    NSMutableArray *mtbArray = [[NSMutableArray alloc] init];
    NSString *queryString =nil;
    if (type == SQL_IF_TYPE_FIRST) {
        queryString =@"SELECT * FROM TransactionMessageTable";
    }else if (type == SQL_IF_TYPE_SECOND) {
        queryString =@"SELECT * FROM TransactionMessageTable WHERE Uid = ? And TransactionIdentifier = ?";
    }
    else {
        queryString =@"SELECT * FROM TransactionMessageTable WHERE Uid = ?";
    }
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, nil) == SQLITE_OK) {
        //
        if (type == SQL_IF_TYPE_FIRST) {
            
        }else if (type == SQL_IF_TYPE_SECOND) {
            sqlite3_bind_int(statement, 1, _myId);
            sqlite3_bind_text(statement, 2, [transactionIdentifier UTF8String], -1, SQLITE_TRANSIENT);
        }
        else {
            sqlite3_bind_int(statement, 1, _myId);
        }
        //
        while (sqlite3_step(statement) == SQLITE_ROW) {
            type_base_id_int _myId =sqlite3_column_int(statement, 1);
            char *transaction_Receipt = (char *)sqlite3_column_text(statement, 2);
            char *product_Identifier = (char *)sqlite3_column_text(statement, 3);
            char * transactionIdentifier =(char *)sqlite3_column_text(statement, 4);
            //2.
            RMStoreTransaction * transaction = [[RMStoreTransaction alloc] init];
            transaction.forMyId = _myId;
            NSString * transactionReceiptStr =[NSString stringWithUTF8String:transaction_Receipt];
            if (![transactionReceiptStr isEqualToString:kSqlForFieldEmpty]) {
                transaction.transactionReceipt =[transactionReceiptStr dataUsingEncoding:NSUTF8StringEncoding];
            }
            NSString * product_IdentifierStr = [NSString stringWithUTF8String:product_Identifier];
            if (![product_IdentifierStr isEqualToString:kSqlForFieldEmpty]) {
                transaction.productIdentifier =product_IdentifierStr;
            }
            NSString * transactionIdentifierStr = [NSString stringWithUTF8String:transactionIdentifier];
            if (![transactionIdentifierStr isEqualToString:kSqlForFieldEmpty]) {
                transaction.transactionIdentifier =transactionIdentifierStr;
            }
            [mtbArray addObject:transaction];
        }
    }
    sqlite3_finalize(statement);
    return mtbArray;
    
}
- (void)sqlInsertfromEnterTransactionMessageTableForMyId:(type_base_id_int)_myId Transaction_Receipt:(NSString * )transaction_Receipt Product_Identifier:(NSString *)product_Identifier TransactionIdentifier:(NSString * )transactionIdentifier{
    type_base_id_int forMyId = _myId;
    NSString * string1 = kSqlForFieldEmpty;
    if ([transaction_Receipt length]>0) {
        string1 = transaction_Receipt;
    }
    NSString * string2 = kSqlForFieldEmpty;
    if ([product_Identifier length]>0) {
        string2 = product_Identifier;
    }
    NSString * string3 = kSqlForFieldEmpty;
    if ([transactionIdentifier length]>0) {
        string3 = transactionIdentifier;
    }
    NSString *libraryPath = [self libraryPathSearchPath];
    NSString *dbPath = [self getPath:libraryPath sqlName:kTransactionMessage];
    BOOL isOpen = [self openSqllite:dbPath];
    if (isOpen == YES) {
        char *insertDataChar = "INSERT OR REPLACE INTO TransactionMessageTable (UId,Transaction_Receipt,Product_Identifier,TransactionIdentifier) VALUES (?,?,?,?)";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, insertDataChar , -1, &statement, NULL) == SQLITE_OK) {
            sqlite3_bind_int(statement, 1, forMyId);
            sqlite3_bind_text(statement, 2, [string1 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [string2 UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4, [string3 UTF8String], -1, SQLITE_TRANSIENT);
            if (sqlite3_step(statement) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
                NSAssert1(0, @"Error: failed to updating method of sqlInsertfromEnterTransactionMessageTableForMyId '%s'.", sqlite3_errmsg(database));
#else
                //NSLog(@"Error: failed to updating method of sqlInsertfromEnterTransactionMessageTableForMyId '%s'.",sqlite3_errmsg(database));
#endif
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    else {
        //NSLog(@"sqlInsertfromEnterTransactionMessageTableForMyId插入失败");
    }
}
- (void)sqlDeletefromEnterTransactionMessageTableForMyId:(type_base_id_int)_myId Product_Identifier:(NSString *)product_Identifier TransactionIdentifier:(NSString * )transactionIdentifier{
    NSString * queryString = @"DELETE FROM TransactionMessageTable WHERE UId = ? And TransactionIdentifier=?";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [queryString UTF8String], -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, _myId);
        sqlite3_bind_text(statement, 2, [transactionIdentifier UTF8String], -1, SQLITE_TRANSIENT);
        if (sqlite3_step(statement) != SQLITE_DONE) {
#ifdef FlipBoxLogMacro
            NSAssert1(0, @"Error: failed to updating method of sqlDeletefromEnterTransactionMessageTableForMyId '%s'.", sqlite3_errmsg(database));
#else
            //NSLog(@"Error: failed to updating method of sqlDeletefromEnterTransactionMessageTableForMyId '%s'.",sqlite3_errmsg(database));
#endif
        }
    }
    sqlite3_finalize(statement);
}
#pragma mark }
#pragma mark 城市Sql {
/*
 - (NSMutableDictionary *)sqlSelectfromCityTbale {
 [self openSqllite:kCitySqlPath];
 NSMutableDictionary *mtbDictionary = [[[NSMutableDictionary alloc] init] autorelease];
 NSMutableArray *keyList = [[[NSMutableArray alloc] init] autorelease];//主键
 NSMutableArray *subList = [[[NSMutableArray alloc] init] autorelease];//
 NSString *query = @"SELECT EL_CODE,PARENT_EL,NAME FROM CITY ";//select SQL里的CITY表
 sqlite3_stmt *statement;
 if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
 while (sqlite3_step(statement) == SQLITE_ROW) {
 char *EL_CODE =(char *)sqlite3_column_text(statement, 0);
 char *PARENT_EL =(char *)sqlite3_column_text(statement, 1);
 char *NAME =(char *)sqlite3_column_text(statement, 2);
 NSString *string = [NSString stringWithUTF8String:PARENT_EL];
 if ([string isEqualToString:@"rootElement"]) {
 NSArray *array = [NSArray arrayWithObjects:[NSString stringWithUTF8String:EL_CODE],string,[NSString stringWithUTF8String:NAME], nil];
 [keyList addObject:array];
 }
 else {
 NSArray *array = [NSArray arrayWithObjects:[NSString stringWithUTF8String:EL_CODE],string,[NSString stringWithUTF8String:NAME], nil];
 [subList addObject:array];
 }
 }
 for (int i = 0; i <[keyList count]; i++) {
 NSString *keyEL_CODE = [[keyList objectAtIndex:i] objectAtIndex:0];//主键的EL_CODE
 NSMutableArray *array = [[NSMutableArray alloc] init];//Dictionary下一主键对应一个数组
 for (int b = 0; b <[subList count]; b++) {
 NSString *subPARENT_EL = [[subList objectAtIndex:b] objectAtIndex:1];//sub的PARENT_EL
 if ([keyEL_CODE isEqualToString:subPARENT_EL]) {
 [array addObject:[[subList objectAtIndex:b] objectAtIndex:2]];
 }
 }
 //Dictionary，一主键对应一个数组
 [mtbDictionary setObject:array forKey:[[keyList objectAtIndex:i] objectAtIndex:2]];
 [array release];
 }
 }
 sqlite3_finalize(statement);
 sqlite3_close(database);
 return mtbDictionary;
 }
 #pragma mark }
 */
#pragma mark }

/**********************Plist*********************/
#pragma mark 创建Plist {
- (void)createPlist:(NSString *)plistName plistCategory:(int)plistCategory {
    // Override point for customization after application launch.
    //在library文件夹下创建Application Support文件夹，并在其下创建Plist
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fileLibrary = [self libraryPathSearchPath];
    BOOL success = [fileManager fileExistsAtPath:fileLibrary];
    if (!success) {
        [fileManager createDirectoryAtPath:fileLibrary withIntermediateDirectories:NO attributes:nil error:nil];
    }
    else {
        //NSLog(@"createPlist-Application Support目录已存在");
    }
    NSString *plistPath = [self getPath:fileLibrary sqlName:plistName];
    success = [fileManager fileExistsAtPath:plistPath];
    if (!success) {
        NSString *plistPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:plistName];
        [fileManager copyItemAtPath:plistPath toPath:plistPath error:&error];
    }
    else {
        //NSLog(@"%@已存在",plistName);
    }
}
#pragma mark }

#pragma mark pannel plist {
- (NSMutableDictionary *)readPanelDataPlist {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *libraryPath = [self libraryPathSearchPath];
    NSString *plistPath = [self getPath:libraryPath sqlName:kPanelDataName];
    BOOL success = [fileManager fileExistsAtPath:plistPath];
    if (success) {
        NSMutableDictionary *mtbDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        return mtbDict;
    }
    else {
        //NSLog(@"readPanelDataPlist:%@文件不存在",kPanelDataName);
    }
    return nil;
}
//根据key值删除对应书籍
-(BOOL)removePanelDataKey:(NSString *)key{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *libraryPath = [self libraryPathSearchPath];
    NSString *plistPath = [self getPath:libraryPath sqlName:kPanelDataName];
    BOOL success = [fileManager fileExistsAtPath:plistPath];
    if (success) {
        NSMutableDictionary *mtbDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        [mtbDict removeObjectForKey:key];
        if([mtbDict writeToFile:plistPath atomically:YES]){//删除后重新写入
            //NSLog(@"removeBookWithKey:write ok!");
            return YES;
        }else{
            //NSLog(@"removeBookWithKey:write fail!");
            return NO;
        }
    }
    else {
        //NSLog(@"removeBookWithKey:%@文件不存在",kPanelDataName);
        return NO;
    }
}
-(void)writePanelDataPlist:(NSArray*)array forKey:(NSString *)key {
    NSMutableDictionary *plistDictionary;    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *libraryPath = [self libraryPathSearchPath];
    NSString *plistPath = [self getPath:libraryPath sqlName:kPanelDataName];
    BOOL success = [fileManager fileExistsAtPath:plistPath];
    if (success) {
        plistDictionary = [self readPanelDataPlist];
    }
    else {
        //NSLog(@"writePlist:%@文件不存在",kPanelDataName);
        return;
    }
    //增加一个数据
    [plistDictionary setValue:array forKey:key]; //在plistDictionary增加一个key为...的value
    if([plistDictionary writeToFile:plistPath atomically:YES]){
        //NSLog(@"writePlist:write ok!");
    }else{
        //NSLog(@"writePlist:write fail!");
    }
}
//更改一条数据，就是把dictionary内key重写
-(void)replaceDictionary:(NSArray*)array withDictionaryKey:(NSString *)key{
    if ([self removePanelDataKey:key]) {
        [self writePanelDataPlist:array forKey:key];
    }
}
#pragma mark }
@end
