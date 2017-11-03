//
//  AppDelegate.h
//  FreeRead
//
//  Created by ispeak on 2017/11/2.
//  Copyright © 2017年 ydd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong)Reachability *remoteHostStatus;

@end

