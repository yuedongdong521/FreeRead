//
//  CmSQlite.h
//  ISspeex
//
//  Created by Administrator on 13-1-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "/usr/include/sqlite3.h"
#import "sqlite3.h"
#import "FriendStructure.h"
#import "AppDelegatePlatformUserStructure.h"
#import "GroupVoiceCommunityStructure.h"
#import "RMStore.h"

/**************
 .SQL_IF_TYPE
 **************/
enum SQL_IF_TYPE {
    SQL_IF_TYPE_FIRST = 1,
    SQL_IF_TYPE_SECOND = 2,
    SQL_IF_TYPE_THIRD = 3,
    SQL_IF_TYPE_FOUR = 4,
    SQL_IF_TYPE_FIVE = 5,
    SQL_IF_TYPE_SIX = 6,
    SQL_IF_TYPE_SEVEN = 7,
    SQL_IF_TYPE_EIGHT = 8,
    SQL_IF_TYPE_NINE = 9,
    SQL_IF_TYPE_TEN = 10,
    SQL_IF_TYPE_ELEVEN = 11,
    SQL_IF_TYPE_TWELVE = 12,
    SQL_IF_TYPE_THIRTEEN = 13,
    SQL_IF_TYPE_FOURTEEN = 14,
    SQL_IF_TYPE_FIFTEEN = 15,
    SQL_IF_TYPE_SIXTEEN = 16
};

@interface CmSQlite : NSObject {
    //数据库
	sqlite3 *database;
}

- (void)createPlist:(NSString *)plistName plistCategory:(int)plistCategory;
- (void)createSqlite:(NSString *)sqlName sqlTableCategory:(int)sqlTableCategory;
- (void)addRowToSqlite:(NSString *)sqlName sqlTableCategory:(int)sqlTableCategory;

- (BOOL)openSqlliteForUserInfoSql;
- (BOOL)openSqlliteForUserInfoExtensionSql;
- (BOOL)openSqlliteForFriendInfoSql;
- (BOOL)openSqlliteForShieldSql;
- (BOOL)openTransactionMessageSql;
- (BOOL)openSqlliteForCFriendSql;
- (void)closeSqllite;

/***User sql table***/
//{
- (NSMutableArray *)sqlSelectfromUserInformationTbaleForState:(int)stateFlg useId:(type_base_id_int)useId type:(int)type;
- (void)sqlInsertfromUserInformationTbale:(AppDelegatePlatformUserStructure *)appDelegatePlatformUserStructure;
- (void)updateFromUserInfoTableForStructure:(AppDelegatePlatformUserStructure *)appDelegatePlatformUserStructure type:(int)type;
- (void)updateFromUserInfoTableForState:(int)selfLoginState type:(int)type;
- (void)sqlDeletefromUserInformationTbale:(AppDelegatePlatformUserStructure *)appDelegatePlatformUserStructure;
//}
/***UserInfoExtension sql table***/
//{
- (NSMutableArray *)sqlSelectfromUserInfoExtensionTbaleForUseId:(type_base_id_int)useId type:(int)type;
- (void)sqlInsertfromUserInfoExtensionTbale:(AppDelegatePlatformUserStructure *)appDelegatePlatformUserStructure;
- (void)updateFromUserInfoExtensionTableTable:(AppDelegatePlatformUserStructure *)appDelegatePlatformUserStructure type:(int)type;
//}
/***RYChatPay sql table***/
//{
- (NSMutableArray *)sqlSelectfromRYChatPayForMyUId:(type_base_id_int)myUId UseUId:(type_base_id_int)useUId forMsgId:(unsigned long)msgId forSymbolFlag:(int)symbolFlag type:(int)type;
- (void)sqlInsertfromRYChatPayTableForMyUId:(type_base_id_int)myUId UseUId:(type_base_id_int)useUId forMsgId:(unsigned long)msgId forSymbolFlag:(int)symbolFlag forAmount:(int)amount;
- (void)updateFromRYChatPayTableForMyUId:(type_base_id_int)myUId UseUId:(type_base_id_int)useUId forMsgId:(unsigned long)msgId forSymbolFlag:(int)symbolFlag forAmount:(int)amount type:(int)type;
//}
/***Friend sql table***/
//FriendTable
- (NSMutableArray *)selectFromFriendTableTableForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId friendForStatus:(int)friendForStatus type:(int)type;
- (NSMutableDictionary *)selectTwoFromFriendTableTableForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId friendForStatus:(int)friendForStatus type:(int)type;
- (void)insertFromFriendTableForStructure:(FriendInfoStructure *)friendInfoStructure;
- (void)updateFromFriendTableForStructure:(FriendInfoStructure *)friendInfoStructure type:(int)type;
- (void)deleteAllDataFromFriendTable:(type_base_id_int)friendId myId:(type_base_id_int)_myId ForFriendAddStatus:(int)addStatus ForFriendOldStatus:(int)oldStatus type:(int)type;
//FriendInfoTable
//{
- (NSMutableArray *)selectFromFriendInfoTableForFriendId:(type_base_id_int)_friendId type:(int)type;
- (void)insertFromFriendInfoTableForStructure:(FriendInfoStructure *)friendInfoStructure;
- (void)updateFromFriendInfoTableForStructure:(FriendInfoStructure *)friendInfoStructure type:(int)type;
- (void)updateFromFriendInfoTableForString:(NSString *)string ForFriendId:(type_base_id_int)friendId type:(int)type;
- (void)updateFromFriendInfoTableForIconIndex:(int)index ForFriendId:(type_base_id_int)friendId;
- (void)deleteAllDataFromFriendInfoTable:(type_base_id_int)friendId type:(int)type;
//}
//SessionTable
//{
- (NSMutableArray *)selectFromSessionTable:(type_base_id_int)friendForMyId friendId:(type_base_id_int)friendId type:(int)type;
- (void)insertFromSessionTableForStructure:(SessionChatStructure *)sessionChatStructure;
- (void)updateFromSessionTableForStructure:(SessionChatStructure *)sessionChatStructure type:(int)type;
-(void)updateFromSessionTableForChatDraft:(NSString *)chatDraftString;
- (void)deleteFromSessionTableForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId type:(int)type;
//}
//ChatRecordTable
//{
- (NSMutableArray *)selectFromChatRecordTableForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId limitCount:(int)limitCountCount offsetCount:(int)offsetCount isSingle:(BOOL)isSingle type:(int)type;
- (NSMutableArray *)selectFromChatRecordTableForSqlId:(int)sqlId;
- (NSMutableArray *)selectFromChatRecordTableForString:(NSString *)cString ForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId type:(int)type;
- (NSMutableArray *)selectFromChatRecordTableForStringOne:(NSString *)cString1 ForStringTwo:(NSString *)cString2 ForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId type:(int)type;
- (NSMutableArray *)selectFromChatRecordTableForChatMessageid:(int)_messageid ForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId type:(int)type;
- (void)insertFromChatRecordTableForStructure:(SessionChatStructure *)sessionChatStructure;
- (void)updateFromChatRecordTableForStructure:(SessionChatStructure *)sessionChatStructure type:(int)type;
- (void)updateFromChatRecordTableForChatUnread:(int)chatUnread ForFriendId:(type_base_id_int)friendId ForFriendForMyId:(type_base_id_int)friendForMyId ForChatSqlId:(int)sqlId type:(int)type;
- (void)updateFromChatRecordTableForFriendId:(type_base_id_int)friendId ForFriendForMyId:(type_base_id_int)friendForMyId ForChatSqlId:(int)sqlId ForChatSendFlg:(int)sendFlg type:(int)type;
- (void)updateFromChatRecordTableForMsgid:(int)msgid ForFriendId:(type_base_id_int)friendId ForFriendForMyId:(type_base_id_int)friendForMyId ForChatSqlId:(int)sqlId ForChatSendFlg:(int)sendFlg type:(int)type;
- (void)updateFromChatRecordTableForFriendIdTwo:(type_base_id_int)friendId ForFriendForMyId:(type_base_id_int)friendForMyId ForChatSqlId:(int)sqlId forTimeString:(NSString *)TimeString type:(int)type;
-(void)updateFromChatRecordTableForChatSqlId:(int)sqlId ForAudioMessageisUnReadflg:(int)AudioMessageisUnRead;
-(void)updateFromChatRecordTableForGuIdString:(NSString *)guIdString type:(int)type;
-(void)updateFromChatRecordTableForGuIdStringTwo:(NSString *)guIdString ForFriendId:(type_base_id_int)friendId ForFriendForMyId:(type_base_id_int)friendForMyId ForChatSqlId:(int)sqlId type:(int)type;
-(void)updateFromChatRecordTableForGuIdStringThree:(NSString *)guIdString ForFriendId:(type_base_id_int)friendId ForFriendForMyId:(type_base_id_int)friendForMyId ForChatSqlId:(int)sqlId ForChatMessageId:(int)chatMessageId type:(int)type;
- (void)deleteFromChatRecordTableForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId type:(int)type;
- (void)deleteFromChatRecordTableForSqlId:(int)sqlId;
//}
//ChatRecordImageIndexTable
//{
- (NSMutableArray *)selectFromChatRecordImageIndexTable;
- (NSMutableArray *)selectFromChatRecordImageIndexTableForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId;
- (void)insertFromChatRecordImageIndexTableForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId ForImageIndex:(long long int)imageIndex;
- (void)updateFromChatRecordImageIndexTableForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId ForImageIndex:(long long int)imageIndex;
- (void)deleteFromChatRecordImageIndexTableForFriendId:(type_base_id_int)_friendId myId:(type_base_id_int)_myId;
//}
//ShowGroupTable
//{
//- (void)insertFromShowGroupTableForStructure:(ShowGroupStructure *)showGroupStructure;
//}
//ShieldTable
- (NSMutableArray *)sqlSelectfromEnterShieldCollectTableForUserId:(type_base_id_int)userId forMyId:(type_base_id_int)myId forShieldFlg:(int)flg type:(int)type;
- (void)sqlInsertfromShieldCollectTableUserId:(type_base_id_int)userId forMyId:(type_base_id_int)myId ForShieldFlg:(int)flg;
- (void)deleteFromShieldCollectTable:(type_base_id_int )userId forMyId:(type_base_id_int)myId;
//TransactionMessageTable
- (NSMutableArray *)sqlSelectfromEnterTransactionMessageTableForMyId:(type_base_id_int)_myId Product_Identifier:(NSString *)product_Identifier TransactionIdentifier:(NSString * )transactionIdentifier type:(int)type;
- (void)sqlInsertfromEnterTransactionMessageTableForMyId:(type_base_id_int)_myId Transaction_Receipt:(NSString * )transaction_Receipt Product_Identifier:(NSString *)product_Identifier TransactionIdentifier:(NSString * )transactionIdentifier;
- (void)sqlDeletefromEnterTransactionMessageTableForMyId:(type_base_id_int)_myId Product_Identifier:(NSString *)product_Identifier TransactionIdentifier:(NSString * )transactionIdentifier;
/***城市Sql***/
//- (NSMutableDictionary *)sqlSelectfromCityTbale;
/***pannel plist***/
//{
-(void)writePanelDataPlist:(NSArray*)array forKey:(NSString *)key;
- (NSMutableDictionary *)readPanelDataPlist;
//}

- (void)updateFromChatRecordTableToSendFailed;
- (void)updataFromeGroupChatRecordTebleSendFailed;

- (void)updateFromGroupChatListTableForChatMessage:(NSString *)chatMessage ForChatSqlId:(int)chatSqlId;
- (void)updateFromFrendChatListTableForChatMessage:(NSString *)chatMessage ForChatSqlId:(int)chatSqlId;

@end
