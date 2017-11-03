//
//  NetWorkHandle.h
//  FreeRead
//
//  Created by lanou3g on 15/4/20.
//  Copyright (c) 2015年 岳栋栋. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NetWorkHandle : NSObject

+ (void)getDataWithUrl:(NSString *)str completion:(void(^)(NSData *data))block;

+ (void)postDataWithUrl:(NSString *)str completion:(void(^)(NSData *data))block;



@end
